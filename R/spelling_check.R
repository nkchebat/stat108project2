#' Check for Spelling Errors
#'
#' @param data A dataframe containing the column to analyze.
#' @param column The name of the column to check.
#' @param valid_options A character vector of valid values for the column.
#' @return A character vector of unmatched values (potential spelling errors).
#' @examples
#' check_spelling(birth_data, "Treatment", c("Placebo", "Treatment"))
#' @export
check_spelling <- function(data, column, valid_options) {
  if (!column %in% names(data)) {
    stop(paste("Column", column, "not found in the dataset."))
  }

  variations <- unique(na.omit(data[[column]]))

  unmatched <- variations[!sapply(variations, function(x) any(grepl(tolower(x), tolower(valid_options))))]

  return(unmatched)
}
