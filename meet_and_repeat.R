# Emil Levo
# 2.12.2020
# Data wrangling script for IODS RStudio Exercise 6

library(dplyr)
library(tidyr)

#6.1 Read in the data and study it
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')


names(BPRS)
str(BPRS)

names(RATS)
str(RATS)

#6.2 Convert categorical variables to factors

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#6.3 Convert data sets to long form, add week variable to BPRS and time variable to RATS

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4)))


#6.4 Compare the datasets before and after long form conversion, make sure you understand the differences

names(BPRSL)
names(BPRS)

glimpse(BPRSL)
glimpse(BPRS)

str(BPRSL)
str(BPRS)

names(RATSL)
names(RATS)

glimpse(RATSL)
glimpse(RATS)

str(RATSL)
str(RATS)

#Save datasets to data folder
write.csv(BPRS, "data/bprs.dat", row.names = FALSE)
write.csv(RATS, "data/rats.dat", row.names = FALSE)
write.csv(BPRSL, "data/bprsl.dat", row.names = FALSE)
write.csv(RATSL, "data/ratsl.dat", row.names = FALSE)
