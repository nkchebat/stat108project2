
#'
#' @param data A data frame containing at least the columns `treatment`, `date`, and `weight`.
#' @return A table summarizing the specified statistics for each treatment group and time point.
#' @examples
#' # Example usage:
#' summary_table <- generate_summary_table(data = data)
#'
#' @export
create_table <- function(data) {
  if (!all(c("treatment", "date", "weight") %in% colnames(data))) {
    stop("The data frame must contain the columns: 'treatment', 'date', and 'weight'.")
  }

  library(dplyr)
  library(gt)

  summary_data <- data %>%
    group_by(treatment, date) %>%
    summarise(
      mean_weight = mean(weight, na.rm = TRUE),
      sd_weight = sd(weight, na.rm = TRUE),
      n = n(),
      .groups = "drop"
    )

  summary_table <- summary_data %>%
    gt() %>%
    tab_header(
      title = "Summary of Body Weight by Treatment Group",
      subtitle = "Mean, Standard Deviation, and Count Over Time"
    ) %>%
    fmt_number(
      columns = c(mean_weight, sd_weight),
      decimals = 2
    ) %>%
    cols_label(
      treatment = "Treatment Group",
      date = "Date",
      mean_weight = "Mean Weight (g)",
      sd_weight = "SD Weight (g)",
      n = "Count"
    ) %>%
    cols_align(
      align = "center",
      columns = everything()
    ) %>%
    tab_options(
      table.font.size = "small",
      heading.align = "center"
    )

  return(summary_table)
}


