#' Clean and Prepare Mouse Data
#'
#' This function takes raw mouse data in a "wide" format and cleans and transforms it into a long, tidy format suitable for analysis. Specifically, it:
#' - Converts date columns to `Date` objects.
#' - Transforms repeated body weight measurements from wide to long format.
#' - Removes (or flags) mice that have lost more than 20% of their baseline weight at any time point.
#' - Removes records for mice after they have died (i.e., weight marked as "Dead").
#' - Optionally assigns a treatment group to each mouse (half vaccine, half placebo).
#'
#' @param data A data frame containing raw mouse data. It should contain columns for ID, multiple body weight measurements, and corresponding date columns.
#'   The expected naming convention is something like: `ID`, `Body Weight 1`, `Date Body Weight 1`, `Body Weight 2`, `Date Body Weight 2`, etc.
#' @param weight_prefix A character string indicating the prefix for weight columns. Default is `"Body Weight"`.
#' @param date_prefix A character string indicating the prefix for the date columns corresponding to the weight measurements. Default is `"Date Body Weight"`.
#' @param remove_dead A logical value. If `TRUE`, records with "Dead" are removed entirely. If `FALSE`, these weight values are set to `NA`. Default is `TRUE`.
#' @param remove_20pct_loss A logical value. If `TRUE`, any mouse that loses more than 20% of its baseline weight at a time point is removed from the dataset from that time point onwards. Default is `TRUE`.
#' @param assign_treatment A logical value. If `TRUE`, the function will assign half of the mice to "Vaccine" and half to "Placebo" in alphabetical order of their IDs. Default is `FALSE`.
#'
#' @return A cleaned data frame with columns: `ID`, `date`, `weight`, and optionally `treatment`.
#'
#' @examples
#' # Example usage (assuming `raw_mouse_data` is in your environment):
#' # cleaned_data <- clean_data(raw_mouse_data)
#' # head(cleaned_data)
#'
#' @export
clean_data <- function(data,
                       weight_prefix = "Body Weight",
                       date_prefix = "Date Body Weight",
                       remove_dead = TRUE,
                       remove_20pct_loss = TRUE,
                       assign_treatment = FALSE) {
  # Load required packages
  # (In a package, you'd typically list these in the DESCRIPTION and use Imports.)
  library(dplyr)
  library(tidyr)
  library(stringr)
  library(lubridate)
  
  # Identify columns that are weights and dates
  weight_cols <- grep(paste0("^", weight_prefix), colnames(data), value = TRUE)
  date_cols <- grep(paste0("^", date_prefix), colnames(data), value = TRUE)
  
  if (length(weight_cols) == 0 || length(date_cols) == 0) {
    stop("No columns identified for weights or dates. Check your prefixes or data structure.")
  }
  
  # Ensure we have pairs of date and weight columns
  if (length(weight_cols) != length(date_cols)) {
    stop("Number of weight columns does not match number of date columns. Check data consistency.")
  }
  
  # Convert date columns to Date format
  # Attempt to parse using standard formats; you may adjust if needed
  for (dc in date_cols) {
    data[[dc]] <- as.Date(data[[dc]], format = "%m/%d/%y")
  }
  
  # Pivot data from wide to long format
  # We create a long dataset with three main columns: ID, date, weight
  long_data <- data %>%
    pivot_longer(
      cols = c(all_of(weight_cols), all_of(date_cols)),
      names_to = c(".value", "measurement"),
      names_pattern = paste0("^(", weight_prefix, "|", date_prefix, ") (.+)$")
    ) %>%
    # The above step will create columns named after the prefixes. We get "Body Weight" and "Date Body Weight" as .value
    rename(weight = !!weight_prefix, date = !!date_prefix) %>%
    select(ID, date, weight)
  
  # Convert "Dead" or other non-numeric weights to NA
  # Then handle remove_dead as requested
  long_data <- long_data %>%
    mutate(weight = as.character(weight))
  
  if (remove_dead) {
    long_data <- long_data %>%
      filter(weight != "Dead")
  }
  
  # Convert weight to numeric
  # Non-numeric values (like "Dead") that remain after filtering become NA automatically
  suppressWarnings(
    long_data$weight <- as.numeric(long_data$weight)
  )
  
  # Remove rows where weight is NA (if any remain after dead filtering)
  long_data <- long_data %>%
    filter(!is.na(weight), !is.na(date))
  
  # Sort by ID and date to facilitate baseline calculations
  long_data <- long_data %>%
    arrange(ID, date)
  
  # Calculate baseline weight for each mouse (first measurement)
  baseline <- long_data %>%
    group_by(ID) %>%
    summarise(baseline_weight = first(weight), .groups = "drop")
  
  long_data <- long_data %>%
    left_join(baseline, by = "ID")
  
  # If remove_20pct_loss is TRUE, remove mice after they lose >20% of baseline
  if (remove_20pct_loss) {
    long_data <- long_data %>%
      group_by(ID) %>%
      mutate(over_20pct_loss = weight < 0.8 * baseline_weight) %>%
      mutate(first_loss_idx = ifelse(any(over_20pct_loss), which(over_20pct_loss)[1], NA)) %>%
      # Keep only records before the first 20% loss
      filter(is.na(first_loss_idx) | row_number() < first_loss_idx) %>%
      select(-over_20pct_loss, -first_loss_idx) %>%
      ungroup()
  }
  
  # Drop the baseline_weight column now that cleaning is done
  long_data <- long_data %>%
    select(-baseline_weight)
  
  # Optionally assign treatment
  if (assign_treatment) {
    # Get unique IDs
    mouse_ids <- sort(unique(long_data$ID))
    n <- length(mouse_ids)
    half_n <- floor(n / 2)
    
    # Assign first half as Vaccine, second half as Placebo
    assigned_treatment <- data.frame(
      ID = mouse_ids,
      treatment = c(rep("Vaccine", half_n), rep("Placebo", n - half_n))
    )
    
    long_data <- long_data %>%
      left_join(assigned_treatment, by = "ID")
  }
  
  # Return cleaned data
  return(long_data)
}
