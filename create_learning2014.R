# Emil Levo
# 5.11.2020
# Data wrangling script for IODS RStudio Exercise 2

library(dplyr)

#Read learning data from provided url
lrn14 <- read.csv("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header=TRUE, sep="\t")

#Print structure of data
str(lrn14)

#Print dimensions of data
dim(lrn14)

#Vectors for selecting questions as instructed
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#Select questions with vectors
deep_columns <- select(lrn14, one_of(deep_questions))
surf_columns <- select(lrn14, one_of(surface_questions))
stra_columns <- select(lrn14, one_of(strategic_questions))

#Create new columns based on questions
lrn14$deep <- rowMeans(deep_columns)
lrn14$surf <- rowMeans(surf_columns)
lrn14$stra <- rowMeans(stra_columns)

#Keep specified columns, and exclude rows where points is zero
keep_columns <- c("gender", "Age", "Attitude", "deep", "stra", "surf", "Points")
lrn14 <- select(lrn14, one_of(keep_columns))
lrn14 <- filter(lrn14, Points>0)

#Scale attitude column by dividing by 10
lrn14$Attitude <- lrn14$Attitude/10

#Decapitalize first letters in each column that needs it
colnames(lrn14)[2] <- "age"
colnames(lrn14)[3] <- "attitude"
colnames(lrn14)[7] <- "points"

#Now the dimensions should be 166x7
dim(lrn14)

#Write dataframe to data folder
write.csv(lrn14, "data/learning2014.txt", row.names = FALSE)

#Demonstrate that we can read the written file:
data_test <- read.csv("data/learning2014.txt")
str(data_test)
dim(data_test)
head(data_test)

