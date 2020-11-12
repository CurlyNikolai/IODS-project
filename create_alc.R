# Emil Levo
# 11.11.2020
# Data wrangling script for IODS RStudio Exercise 3
# data/student-*.csv from https://archive.ics.uci.edu/ml/datasets/Student+Performance

student_mat <- read.csv('data/student-mat.csv', sep=';', header=TRUE)
student_por <- read.csv('data/student-por.csv', sep=';', header=TRUE)

#View structure and dimensions of data. Uncomment what you want to see. 
#str(student_mat)
#str(student_por)
#dim(student_mat)
#dim(student_por)

library(dplyr)

#Join the two data sets using the given variables
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
student_dat <- inner_join(student_mat, student_por, by = join_by)

str(student_dat)
dim(student_dat)

# create a new data frame with only the joined columns
alc <- select(student_dat, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(student_mat)[!colnames(student_mat) %in% join_by]

for(column_name in notjoined_columns) {
  two_columns <- select(student_dat, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}

#Take weekday,weekend average and include high_use boolean
alc <- mutate(alc, alc_use = (Dalc+Walc)/2)
alc <- mutate(alc, high_use = alc_use>2)

#Glimpse data and check dimensions to make sure everything is in order
glimpse(alc)
dim(alc)

#Write csv file to data folder
write.csv(alc, "data/alc.txt", row.names = FALSE)
