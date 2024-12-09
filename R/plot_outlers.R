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

  variable <- enquo(variable)  # Capture the bare column name

  # Check if the column exists
  column_name <- as_label(variable)
  if (!column_name %in% names(data)) {
    stop(paste("Variable", column_name, "not found in the dataset."))
  }

  # Identify outliers
  outliers <- boxplot.stats(data[[column_name]])$out
  outlier_data <- data %>% filter(!!variable %in% outliers)

  # Create the plot
  ggplot(data, aes(y = !!variable)) +
    geom_boxplot(outlier.colour = "red", outlier.size = 3, fill = "lightblue") +
    geom_point(
      data = outlier_data,
      aes(y = !!variable),
      color = "red",
      size = 3,
      shape = 21,
      stroke = 1.5
    ) +
    labs(
      title = paste("Boxplot of", column_name),
      y = column_name,
      x = ""
    ) +
    theme_minimal()
}
