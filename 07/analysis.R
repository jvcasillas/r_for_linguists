
## @knitr libs 
library(tidyverse); library(lingStuff)

## @knitr setwd 

# Set working directory
setwd("~/academia/teaching/ru/ru_spanish_585/585_01_s2017/programming/r/07/")


## @knitr loadData

# Combine files vertically into large data frame
temp <- list.files(path = "./data/", full.names = TRUE, pattern = ".csv")
myfiles = lapply(temp, read.csv, sep = ",")
df <- do.call("rbind", myfiles)

## @knitr cleandata

# remove unwanted characters from column
df$f0 <- gsub("--undefined--", "NA", paste(df$f0))
df$f0 <- as.numeric(df$f0)

# separate columns to create 'segment', 'id', and 'item'
df <- df %>%
  separate(., col = prefix, into = c('segment', 'id', 'item'), sep = "_")

# create a vowel column (every vowel is /a/)
df$vowel <- 'a'

# check structure
str(df)


## @knitr densityVOT
ggplot(df, aes(vot)) + 
  geom_histogram(aes(y = ..density..), colour = "black", 
                 fill = "lightgrey", binwidth = 10, alpha = 0.6) +  
  geom_density(bw = 5, fill = "red", alpha = 0.4) +
  xlim(-150, 150) + 
  theme_bw()


## @knitr densityVOTindividual
ggplot(df, aes(vot, color = id)) + 
  geom_histogram(aes(y = ..density..), colour = "black", 
                 fill = "lightgrey", binwidth = 10) +
  geom_density(bw = 10) + 
  xlim(-150, 150) + 
  theme_bw()



## @knitr vowelPlot 
vowel_plot(df, vowel = 'vowel', f1 = 'f1', f2 = 'f2', group = 'id')





