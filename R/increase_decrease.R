#' Increase Decrease Check
#'
#' @param data A dataframe containing the measurements to check.
#' @param column1 The name of the first column (e.g., `Body Weight 1`).
#' @param column2 The name of the second column (e.g., `Body Weight 2`).
#' @param trend Either "increase" or "decrease". Defaults to "increase".
#' @return A table highlighting rows that violate the expected trend.
#' @examples
#' check_trend(data, "Body Weight 1", "Body Weight 2", "decrease")
#' @export
check_trend <- function(data, column1, column2, trend = "increase") {
  library(tidyverse)
  library(gt)

  if (!(column1 %in% colnames(data)) || !(column2 %in% colnames(data))) {
    stop(paste("Columns must be in dataset"))
  }
  data <- data %>%
    mutate(id = row_number())

  inconsistent_rows <- data %>%
    filter(
      (trend == "increase" & !!sym(column2) < !!sym(column1)) |
        (trend == "decrease" & !!sym(column2) > !!sym(column1))
    ) %>%
    select(id, !!sym(column1), !!sym(column2)) %>%
    rename(
      change1 = !!sym(column1),
      change2 = !!sym(column2)
    )
  table <- inconsistent_rows %>%
    gt() %>%
    tab_header(
      title = paste("Check for :", trend),
      subtitle = paste("Highlighting rows where", column2, "does not", trend, "from", column1)
    ) %>%
    cols_label(
      id = "Row Number",
      change1 = column1,
      change2 = column2
    ) %>%
    tab_style(
      style = cell_text(weight = "bold", color = "red"),
      locations = cells_body(
        columns = vars(change1, change2),
        rows = change2 < change1 & trend == "increase" |
          change2 > change1 & trend == "decrease"
      )
    )

  return(table)
}
