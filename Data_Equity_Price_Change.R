## Money, Credit and Finance - Research and Policy Seminar

# Load Data

NZ_index_data <- read.csv("/Users/maximilianvonposer/Documents/Maximilian /Studium/WU Wien/Money, Credit and Finance Seminar/Project/Equity Prices/HistoricalPrices_NZ_Index.csv",
                          sep = ";")

# Convert Date column into dates

NZ_index_data$Date <- as.Date(NZ_index_data$Date, format = "%m/%d/%y")

# Create Vector for Dates that are relevant

MPS_statement_dates <- c("2000-03-15", "2000-05-17", "2000-08-16", "2000-12-06", 
                         "2001-03-14", "2001-05-16", "2001-08-15", "2001-11-14",
                         "2002-03-20", "2002-05-15", "2002-08-14", "2002-11-20",
                         "2003-03-06", "2003-06-05", "2003-09-04", "2003-12-04",
                         "2004-03-11", "2004-06-10", "2004-09-09", "2004-12-09",
                         "2005-03-10", "2005-06-09", "2005-09-15", "2005-12-08",
                         "2006-03-09", "2006-06-08", "2006-09-14", "2006-12-07",
                         "2007-03-08", "2007-06-07", "2007-09-13", "2007-12-06",
                         "2008-03-06", "2008-06-05", "2008-09-11", "2008-12-04",
                         "2009-03-12", "2009-06-11", "2009-09-10", "2009-12-10",
                         "2010-03-11", "2010-06-10", "2010-09-16", "2010-12-09",
                         "2011-03-10", "2011-06-09", "2011-09-15", "2011-12-08",
                         "2012-03-08", "2012-06-14", "2012-09-13", "2012-12-06",
                         "2013-03-14", "2013-06-13", "2013-09-12", "2013-12-12",
                         "2014-03-13", "2014-06-12", "2014-09-11", "2014-12-11",
                         "2015-03-12", "2015-06-11", "2015-09-10", "2015-12-10",
                         "2016-03-10", "2016-06-09", "2016-08-11", "2016-11-10",
                         "2017-02-09", "2017-05-11", "2017-08-10", "2017-11-09",
                         "2018-02-08", "2018-05-10", "2018-08-09", "2018-11-08",
                         "2019-02-13", "2019-05-08", "2019-08-07", "2019-11-13")

# Convert Vector into Dates
MPS_statement_dates <- as.Date(MPS_statement_dates)

# Rearrange vector according to the dataset
MPS_statement_dates_rev <- rev(MPS_statement_dates)

# Daily Equity Price Changes 
NZ_Index_changes <- if (any(NZ_index_data$Date %in% MPS_statement_dates_rev)) {
  # Get the indices where the condition is TRUE
  matching_indices <- which(NZ_index_data$Date %in% MPS_statement_dates_rev)
  
  # Calculate the difference between Close and Open for the matching indices
  price_difference <- NZ_index_data$Open[matching_indices-1] - NZ_index_data$Open[matching_indices]
  
  # Print or use the result as needed
  print("Price difference for matching dates:")
  print(price_difference)
} else {
  print("No matching dates found.")
}

# Filter dataset with matching dates 
matching_indices_dataset <- NZ_index_data[matching_indices,]

# Number of elements of NZ_index_change vector that are != 0
sum(NZ_Index_changes != 0.00)

# There is data available for all the dates



