
# Parameters
# ===========
# set project directory as working directory
setwd("~/NvH_R_Projects/ChinaStudy")
# ===========



# Packages 
# --------
library(readr)
library(dplyr)
library(stringr)


# import data 
# ============

# data dictionary
chname <- read_delim("china-study-data-archive/CHNAME.txt", 
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

# Create table with descriptions of variable categories
category <- unique(chname$category)
cat_description <- c("Mortality", "Plasma", "Red blood cell", "Urine", "Diet", 
                     "Geographic", "Questionnaire")
cat_descr_df <- data_frame(category, cat_description)

# join the variable category descriptions to the data dictionary
chname <- inner_join(chname, cat_descr_df, "category")
  
# investigate mortality tables

ch83m <- read_csv("china-study-data-archive/CH83M.csv")
ch83m[, 4:72] <- lapply(ch83m[, 4:72], as.double)

#figuring out how to add cols m001 to m006 to get an all mortality rate
# then check if the figure balances out
ch83m$sumall <- ch83m %>%
  mutate(sum_mort_all = sum(M001:M006))
colSums()




  
  