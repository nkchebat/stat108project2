#' Plot Outliers
#'
#' @param data A dataframe containing the variable to check.
#' @param variable The name of the variable (column) to plot.
#' @return A ggplot2 boxplot highlighting outliers.
#' @examples
#' plot_outliers(data, "body_weight")
#' @export
plot_outliers <- function(data, variable) {
  library(ggplot2)
  library(dplyr)

  if (!variable %in% names(data)) {
    stop(paste("Variable", variable, "not found in the dataset."))
  }

  boxplot <- ggplot(data, aes_string(y = as.numeric(variable))) +
    geom_boxplot(outlier.colour = "red", outlier.size = 3, outlier.shape = 21, fill = "lightblue") +
    geom_point(
      data = data %>%
        filter(!!rlang::sym(variable) %in% boxplot.stats(data[[variable]])$out),
      aes_string(y = variable),
      color = "red",
      size = 3,
      shape = 21,
      stroke = 1.5  # Bold the outliers
    ) +
    labs(
      title = paste("Boxplot of", variable),
      y = variable,
      x = ""
    ) +
    theme_minimal()

  return(boxplot)
}
