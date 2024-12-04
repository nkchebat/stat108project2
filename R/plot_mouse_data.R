



#' Title
#'
#' @param data  A dataframe with the variables `ID`, `date`, `weight`, and `treatment`.
#' @param title The title of your graph
#'
#'
#' @return Returns a plot showing each mouse weight over time by group.
#
#'
#' @examples
#' @export
plot_mouse_data <- function(data, title = "Body Weight Over Time by Treatment") {
  if (!all(c("ID", "date", "weight", "treatment") %in% colnames(data))) {
    stop("The data frame must contain the columns: 'ID', 'date', 'weight', and 'treatment'.")
  }

  library(ggplot2)
  library(dplyr)

  summary_data <- data %>%
    group_by(treatment, date) %>%
    summarise(mean_weight = mean(weight, na.rm = TRUE), .groups = "drop")

  plot <- ggplot(data, aes(x = date, y = weight, group = ID, color = treatment)) +
    geom_line(alpha = 0.6, size = 0.8) +
    geom_line(data = summary_data, aes(x = date, y = mean_weight, group = treatment),
              size = 1.5, linetype = "dashed") +
    labs(
      title = title,
      x = "Date",
      y = "Body Weight (g)",
      color = "Treatment"
    ) +
    theme_minimal() +
    theme(legend.position = "right")

  return(plot)
}




