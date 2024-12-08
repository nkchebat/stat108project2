#' Clean Mouse Data
#'
#' @param data A dataframe containing mouse data with columns for IDs, weights, and dates.
#' @return A cleaned dataframe with columns `ID`, `date`, `weight`, and `treatment`.
#' @examples
#' cleaned_data <- clean_mouse_data(data = raw_data)
#' @export
clean_mouse_data <- function(data) {
  library(dplyr)
  library(tidyr)

  required_columns <- c("ID", "Body Weight 1", "Date Body Weight 1",
                        "Body Weight 2", "Date Body Weight 2",
                        "Body Weight 3", "Date Body Weight 2.1")
  if (!all(required_columns %in% colnames(data))) {
    stop("The data frame must contain the required columns.")
  }

  data <- data %>%
    mutate(`Body Weight 3` = as.numeric(`Body Weight 3`))

  long_data <- data %>%
    pivot_longer(
      cols = starts_with("Body Weight"),
      names_to = "weight_measurement",
      values_to = "weight"
    ) %>%
    pivot_longer(
      cols = starts_with("Date Body Weight"),
      names_to = "date_measurement",
      values_to = "date"
    ) %>%
    filter(
      substr(weight_measurement, nchar(weight_measurement), nchar(weight_measurement)) ==
        substr(date_measurement, nchar(date_measurement), nchar(date_measurement))
    ) %>%
    select(ID, weight, date)

  cleaned_data <- long_data %>%
    filter(!is.na(weight) & weight > 0)

  cleaned_data <- cleaned_data %>%
    group_by(ID) %>%
    mutate(baseline_weight = first(weight)) %>%
    filter(weight >= 0.8 * baseline_weight) %>%
    ungroup() %>%
    select(-baseline_weight)

  cleaned_data <- cleaned_data %>%
    mutate(date = as.Date(date))

  return(cleaned_data)
}
