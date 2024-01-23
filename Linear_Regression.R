## Regression Index Data on Sentiment Score

# Load Data 

sentiment_index <- readRDS("/Users/maximilianvonposer/Documents/Maximilian /Studium/WU Wien/Money, Credit and Finance Seminar/Project/cleaned_data_with_indices.rds")
indices_dataset <- readRDS("/Users/maximilianvonposer/Documents/Maximilian /Studium/WU Wien/Money, Credit and Finance Seminar/Project/Equity Prices/matching_indices_dataset.rds")

# Find Matching dates

indices_dataset <- rename(indices_dataset, doc_id = Date)

merged_data <- merge(sentiment_index, indices_dataset, by = "doc_id")

# Regression 

regression <- lm(Index_Change ~ sentiment_index, data = merged_data)
summary(regression)
