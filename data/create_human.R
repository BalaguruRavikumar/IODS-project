#Name: Balaguru Ravikumar
#Data: 29/11/17
#Description: Data Wrangling excerise: PCA

#Input Data:
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Explore the datasets:
str(hd)
str(gii)

#Summaries:
summary(hd)
summary(gii)

#Simplify the colnames:
d1_names <- colnames(hd)
d2_names <- colnames(gii)
nd1 <- c("hdir","c","hdi","lex","exedu","medu","gni","gnicr")
nd2 <- c("giir","c","gii","mor","birth","par","seduf","sedum","lff","lffm")
colnames(hd) <- nd1
colnames(gii) <- nd2

#Muatate Gender equality:
library(dplyr)
gii <- mutate(gii, sedf2m = (seduf/sedum))
gii <- mutate(gii, lfrfm = (lff/lffm))

#Joining the data:
human <- inner_join(hd, gii,by = "c")

#Saving the data:
write.table(human, file = "human_data.txt")
