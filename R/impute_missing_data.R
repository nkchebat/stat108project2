#' Impute Missing Values in Numeric Columns
#'
#' @param data A dataframe containing numeric columns with missing values.
#' @param method A character string specifying the imputation method: "mean" or "median".
#' @return A dataframe with missing values imputed and a table summarizing the missing data.
#' @examples
#' data <- data.frame(
#'   A = c(1, 2, NA, 4),
#'   B = c(NA, 5, 6, 7),
#'   C = c("cat", "dog", "mouse", NA)
#' )
#' imputed_data <- impute_missing_data(data, method = "mean")
#' print(imputed_data)
#' @export
impute_missing_data <- function(data, imputation = "mean") {
  if (!imputation %in% c("mean", "median")) {
    stop("Invalid choice. Choose either 'mean' or 'median'.")
  }

  missing_summary <- data.frame(
    Column = names(data),
    Missing_Count = sapply(data, function(column) sum(is.na(column))),
    Missing_Percentage = sapply(data, function(column) mean(is.na(column)) * 100)
  )

  cat("Missing Data Summary:\n")
  print(missing_summary)

  data <- data.frame(lapply(data, function(column) {
    if (is.numeric(column)) {
      if (imputation == "mean") {
        column[is.na(column)] <- mean(column, na.rm = TRUE)
      } else if (imputation == "median") {
        column[is.na(column)] <- median(column, na.rm = TRUE)
      }
    }
    return(column)
  }))

  return(list(Imputed_Data = data, Missing_Summary = missing_summary))
}
