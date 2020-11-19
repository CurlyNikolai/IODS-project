# Emil Levo
# 19.11.2020
# Data wrangling script for IODS RStudio Exercise 4
# Meta files http://hdr.undp.org/en/content/human-development-index-hdi
# Technical notes http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

#Libraries:
library(dplyr)

# 2. Read in the "Human development" and "Gender inequality" data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# 3. Explore the dataset by looking at the structure and dimensions of the data. Also present summaries of the data
str(hd)
dim(hd)

str(gii)
dim(gii)

summary(hd)
summary(gii)


# 4. Rename the data (very subjective task, did not really understand how the meta files could be of help here)
# Meta files link: http://hdr.undp.org/en/content/human-development-index-hdi

hd <- hd %>% 
  rename(
    HDI_rank = HDI.Rank,
    HDI = Human.Development.Index..HDI.,
    lifeExp = Life.Expectancy.at.Birth,
    eduExp = Expected.Years.of.Education,
    eduMean = Mean.Years.of.Education,
    GNI = Gross.National.Income..GNI..per.Capita,
    GNI_min_HDI_rank = GNI.per.Capita.Rank.Minus.HDI.Rank
  )

gii <- gii %>%
  rename(
    GII_rank = GII.Rank,
    GII = Gender.Inequality.Index..GII.,
    MMR = Maternal.Mortality.Ratio,
    ABR = Adolescent.Birth.Rate,
    rep = Percent.Representation.in.Parliament,
    edu2F = Population.with.Secondary.Education..Female.,
    edu2M = Population.with.Secondary.Education..Male.,
    labF = Labour.Force.Participation.Rate..Female.,
    labM = Labour.Force.Participation.Rate..Male.
  )

# 5. Mutate "gender inequality" data with ratio of female and male populations with secondary education and ratio of labour force participation between females and males
gii <- mutate(gii, edu2Rat = edu2F/edu2M)
gii <- mutate(gii, labRat = labF/labM)

# 6. Join the two datasets using Country as identifier, then check dimensions that it matches 195 observations and 19 variables. Save the data in the "data" folder
human <- inner_join(hd, gii, by="Country") 
dim(human)
write.csv(human, "data/human.dat", row.names = FALSE)

#Test to see if the data is correct
#data <- read.csv("data/human.dat", header=TRUE, sep=",")
#str(data)
#dim(data)