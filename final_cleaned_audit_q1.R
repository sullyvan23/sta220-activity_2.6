library(tidyverse)

# setting working directory
setwd("~/STA370/work/sta220-activity_2.6")

q1_2025 <- read_csv("data/2025_q1.csv")

# expect 48 rows and 4 columns
dim(q1_2025)
names(q1_2025)
summary(q1_2025)

# Clean, making -1s into NAs
q1_2025 <- q1_2025 |> mutate(days_to_close = na_if(days_to_close, -1))

# greater than 30 is considered late in codebook
lim <- 30

# Analyze
q1_2025 <- q1_2025 |> mutate(late = days_to_close > lim)
q1_2025_by_claim <- q1_2025 |> group_by(claim_type) |> 
                               summarise(claims = n(), 
                                         still_open = sum(is.na(days_to_close)),
                                         mean_days = mean(days_to_close, na.rm = TRUE), 
                                         pct_late = mean(late, na.rm = TRUE))
q1_2025_by_claim

# Save
write_csv(q1_2025_by_claim,"output/final.csv")
