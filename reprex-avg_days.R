# setting working directory
setwd("~/STA370/work/sta220-activity_2.6")

# greater than 30 is considered late in codebook
lim <- 30

library(tidyverse)

claims_small <- tribble(
  ~claim_id, ~days_to_close,
  "X-001",               28,
  "X-002",               40,
  "X-003",               -1,
  "X-004",               -1
)

claims_small |>
  summarize(
    # turns -1s into NAs, then removes NAs from avgs and shares
    avg_days   = mean(na_if(days_to_close, -1), na.rm = TRUE),
    share_late = mean(na_if(days_to_close, -1) > 30, na.rm = TRUE)
  )

# saving to output file
write_csv(claims_small, "output/claims_small_final.csv")
