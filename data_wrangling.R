
# Parameters
# ===========
  
# ===========



# Packages 
# --------
library(readr)
library(dplyr)
library(stringr)


# import data 
# ============

# data dictionary
chname <- read_delim("~/NvH_R_Projects/ChinaStudy/china-study-data-archive/CHNAME.txt", 
                     "\t", escape_double = FALSE, col_names = FALSE, 
                     trim_ws = TRUE)

# data wrangling 
# ==============

# data dictionary 
# take out lines with no info 
chname <- chname %>% 
  mutate(definition = X1) %>%
  filter(str_count(definition) > 4) %>%
  select(-X1) %>%
  mutate(category = str_sub(definition, 1, 1)) %>%
  mutate(variable = str_sub(definition, 1, 4))
# Be aware that there are duplicate variables where the definition runs into the next line



