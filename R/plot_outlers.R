#' Plot Outliers
#'
#' @param data A dataframe containing the variable to check.
#' @param variable The name of the variable (column) to plot.
#' @return A ggplot2 boxplot highlighting outliers.
#' @examples
#' plot_outliers(data, body_weight)
#' @export
plot_outliers <- function(data, variable) {
  library(ggplot2)
  library(dplyr)

  # Check if the variable (quoted column name) exists in the dataset
  if (!variable %in% names(data)) {
    stop(paste("Variable", variable, "not found in the dataset."))
  }

  # Check for non-NA values
  if (all(is.na(data[[variable]]))) {
    stop(paste("Variable", variable, "contains only NA values. No plot generated."))
  }

  # Identify outliers
  outliers <- boxplot.stats(data[[variable]])$out
  outlier_data <- data %>% filter(.data[[variable]] %in% outliers)

  # Create the base plot
  ggplot(data, aes(y = .data[[variable]], x = 1)) +
    geom_boxplot(outlier.colour = "red", outlier.size = 3, fill = "lightblue") +
    geom_point(
      data = outlier_data,
      aes(y = .data[[variable]], x = 1),
      color = "red",
      size = 3,
      shape = 21,
      stroke = 1.5
    ) +
    labs(
      title = paste("Boxplot of", variable),
      y = variable,
      x = ""
    ) +
    theme_minimal()
}
