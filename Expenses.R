#This R script analyzes personal expenses by reading a CSV file, formatting dates, calculating total spending, summarizing spending by category, and visualizing the data using bar and line charts. It provides insights into spending patterns over time and across different categories
rm(list = ls())
gc()
setwd("/Users/kaylasamuel/Desktop/R")
install.packages(c("tidyverse", "lubridate", "ggplot2"))
library(tidyverse) #collection of R packages that share an underlying design philosophy and are great for data manipulation and analysis.
library(lubridate) #used for working with dates and times.
library(ggplot2) #specifically for creating visualizations.

expenses <- read_csv("expenses - Sheet1 (1).csv")

expenses <- expenses %>%
  mutate(Date = as.Date(Date, format = "%Y-%m-%d")) #This ensures that the date is properly formatted. 
total_spent <- sum(expenses$Amount)
print(paste("Total spent: $", total_spent)) #This will give the total number of money spent. 

category_summary <- expenses %>%
  group_by(Category) %>%
  summarise(total_spent = sum(Amount)) %>%
  arrange(desc(total_spent))
print(category_summary)  #Prints each category from largest to smallest based on how much spent. 


ggplot(category_summary, aes(x = reorder(Category, -total_spent), y = total_spent, fill = Category)) +
  geom_bar(stat = "identity") +
  labs(title = "Spending by Category", x = "Category", y = "Total Spent ($)") 

ggplot(expenses, aes(x = Date, y = Amount)) +
  geom_line(color = "black") +
  geom_point() +
  theme_minimal() +
  labs(title = "Spending Over Time", x = "Date", y = "Amount ($)")
