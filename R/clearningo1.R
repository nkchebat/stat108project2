#' Clean Mouse Data
#'
#' @param birth_data A dataframe for the Birth sheet.
#' @param outcome_data A dataframe for the Outcome sheet.
#' @param bodyweight_data A dataframe for the Body Weight sheet.
#' @param remove_dead Logical. If TRUE, remove rows where weight is "Dead".
#' @param remove_20pct_loss Logical. If TRUE, remove data after 20% weight loss.
#' @return A dataframe with `ID`, `date`, `weight`, `outcome`, `sex`, and `treatment`.
#' @export
clean_mousedata <- function(birth_data,
                            outcome_data,
                            bodyweight_data,
                            remove_dead = TRUE,
                            remove_20pct_loss = TRUE) {
  
  library(dplyr)
  library(tidyr)
  library(stringr)
  library(lubridate)
  
  birth_clean <- birth_data %>%
    mutate(
      treatment = case_when(
        str_detect(tolower(Treatment), "plac") ~ "Placebo",
        str_detect(tolower(Treatment), "tmt|trmt") ~ "Treatment",
        TRUE ~ "Unknown"
      ),
      sex = Sex
    ) %>%
    select(ID, sex, treatment)
  
  outcome_val_cols <- grep("^Outcome \\d+$", colnames(outcome_data), value = TRUE)
  outcome_date_cols <- grep("^Date Outcome \\d+$", colnames(outcome_data), value = TRUE)
  if (length(outcome_val_cols) != length(outcome_date_cols)) stop("Mismatch in outcome columns.")
  
  outcome_long <- outcome_data %>%
    rename(ID = Subject_ID) %>%
    pivot_longer(
      cols = c(all_of(outcome_val_cols), all_of(outcome_date_cols)),
      names_to = c(".value", "measurement"),
      names_pattern = "^(Outcome|Date Outcome) (\\d+)$"
    ) %>%
    rename(outcome = Outcome, date = `Date Outcome`) %>%
    mutate(date = as.Date(date, "%m/%d/%y")) %>%
    select(ID, date, outcome)
  
  weight_val_cols <- grep("^Body Weight \\d+$", colnames(bodyweight_data), value = TRUE)
  date_val_cols <- grep("^Date Body Weight \\d+\\.?\\d*$", colnames(bodyweight_data), value = TRUE)
  if (length(weight_val_cols) != length(date_val_cols)) stop("Mismatch in body weight columns.")
  
  bodyweight_long <- bodyweight_data %>%
    pivot_longer(
      cols = c(all_of(weight_val_cols), all_of(date_val_cols)),
      names_to = c(".value", "measurement"),
      names_pattern = "^(Body Weight|Date Body Weight) (\\d+\\.?\\d*)$"
    ) %>%
    rename(weight = `Body Weight`, date = `Date Body Weight`) %>%
    mutate(
      weight = ifelse(weight == "Dead" & remove_dead, NA, weight),
      weight = as.numeric(weight),
      date = as.Date(date, "%m/%d/%y")
    ) %>%
    filter(!is.na(weight))
  
  bw_merged <- bodyweight_long %>% left_join(birth_clean, by = "ID")
  outcome_merged <- outcome_long %>% left_join(birth_clean, by = "ID")
  
  full_data <- full_join(bw_merged, outcome_merged, by = c("ID", "date", "sex", "treatment"))
  
  if (remove_20pct_loss) {
    full_data <- full_data %>%
      group_by(ID) %>%
      arrange(date, .by_group = TRUE) %>%
      mutate(baseline_weight = first(weight, na.rm = TRUE),
             over_20pct_loss = weight < 0.8 * baseline_weight,
             first_loss_idx = ifelse(any(over_20pct_loss), which(over_20pct_loss)[1], NA)) %>%
      filter(is.na(first_loss_idx) | row_number() < first_loss_idx) %>%
      select(-over_20pct_loss, -first_loss_idx, -baseline_weight) %>%
      ungroup()
  }
  
  full_data
}
