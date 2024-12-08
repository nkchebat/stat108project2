#' Clean Mouse Data
#'
#' @param file_path The path to the Excel file containing the mouse data.
#' @return A cleaned dataframe with columns `ID`, `date`, `weight`, and `treatment`.
#' @examples
#' cleaned_data <- clean_mouse_data("mousedata.xlsx")
#' @export
clean_mouse_data <- function(file_path) {
  library(readxl)
  library(dplyr)
  library(tidyverse)

  sheets <- excel_sheets(file_path)
  data_list <- lapply(sheets, function(sheet) read_excel(file_path, sheet = sheet))
  combined_data <- bind_rows(data_list)

  required_columns <- c("ID", "weight", "date", "treatment")
  for (col in required_columns) {
    if (!col %in% colnames(combined_data)) {
      combined_data[[col]] <- NA  # Add missing columns with NA values
    }
  }

  weight_cols <- grep("^Body Weight", colnames(combined_data), value = TRUE)
  combined_data[weight_cols] <- lapply(combined_data[weight_cols], function(col) {
    as.numeric(as.character(col))
  })

  if ("weight" %in% colnames(combined_data) && "date" %in% colnames(combined_data)) {
    combined_data <- combined_data %>%
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
      select(ID, weight, date, treatment)
  }

  cleaned_data <- combined_data %>%
    filter(!is.na(weight) & weight > 0) %>%
    group_by(ID) %>%
    mutate(baseline_weight = first(weight, na.rm = TRUE)) %>%
    filter(weight >= 0.8 * baseline_weight) %>%
    ungroup() %>%
    mutate(
      date = as.Date(date),
      treatment = ifelse(is.na(treatment), "Unknown", treatment)
    ) %>%
    select(-baseline_weight)


  issue_flags <- combined_data %>%
    mutate(
      missing_weight = is.na(weight),
      missing_date = is.na(date),
      invalid_weight = weight <= 0
    ) %>%
    summarise(
      total_missing_weight = sum(missing_weight, na.rm = TRUE),
      total_missing_date = sum(missing_date, na.rm = TRUE),
      total_invalid_weight = sum(invalid_weight, na.rm = TRUE)
    )

  message("Data Cleaning Summary:")
  print(issue_flags)

  return(cleaned_data)
}
