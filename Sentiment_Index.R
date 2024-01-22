# # # Individual statement # # #

cleaned_data
test <- cleaned_data[3,2]
test <- tolower(test)

# First step: Identify the words from the keyword dictionary

words_in_statement <- unlist(strsplit(tolower(test), "\\W+"))
matching_words <- words_in_statement[words_in_statement %in% List_of_Keywords_and_Their_Scores$keyword]

# Second step: Identify the closest modifiers from the modifier dictionary

modifiers <- List_of_Modifiers_and_Their_Scores$modifier

find_closest_modifier <- function(word) {
  closest_modifier <- modifiers[which.min(adist(word, modifiers))]
  return(closest_modifier)
}

closest_modifiers <- sapply(matching_words, find_closest_modifier)
closest_modifiers_df <- data.frame(
  keyword = names(closest_modifiers),
  modifier = unname(closest_modifiers)
)

pairs_df <- merge(closest_modifiers_df, List_of_Keywords_and_Their_Scores, by = "keyword", all.x = FALSE)
pairs_df$modifier_value <- List_of_Modifiers_and_Their_Scores$score[match(pairs_df$modifier, List_of_Modifiers_and_Their_Scores$modifier)]
pairs_df$product <- pairs_df$score * pairs_df$modifier_value
pairs_df

# Third step: Calculate the score

sum_product <- sum(pairs_df$product)
num_words <- length(words_in_statement)
overall_sentiment_index <- sum_product / sqrt(num_words)
overall_sentiment_index

# # # Loop # # #

statements <- cleaned_data[,2]
overall_sentiment_indices <- numeric(length(statements))

for (i in seq_along(statements)) {
  
  # First step: Identify the modifiers from the modifier dictionary
  
  words_in_statement <- unlist(strsplit(tolower(statements[i]), "\\W+"))
  
  # Second step: Identify the closest modifiers from the modifier dictionary
  
  closest_modifiers <- sapply(words_in_statement, find_closest_modifier)
  
  closest_modifiers_df <- data.frame(
    keyword = names(closest_modifiers),
    modifier = unname(closest_modifiers)
  )
  
  pairs_df <- merge(closest_modifiers_df, List_of_Keywords_and_Their_Scores, by = "keyword", all.x = FALSE)
  
  pairs_df$modifier_value <- List_of_Modifiers_and_Their_Scores$score[match(pairs_df$modifier, List_of_Modifiers_and_Their_Scores$modifier)]
  
  # Third step: Calculate the score
  
  pairs_df$product <- pairs_df$score * pairs_df$modifier_value
  sum_product <- sum(pairs_df$product)
  num_words <- length(words_in_statement)
  
  overall_sentiment_indices[i] <- sum_product / sqrt(num_words)
}

overall_sentiment_indices
