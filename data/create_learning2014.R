#Name: Balaguru Ravikumar
#Data: 14/11/17
#Description: Data Wrangling excerise: Regression and model validation

#Input Data:
data <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header=TRUE, sep = "\t")

#Exploring the data:
summary(data)

#Displays the first 10 line of the dataset giving an overview of the dataset
head(data,n=10)

#Details the structure of the data, explaing the type of data variable, the various columns
#of the data and the type of values in the columns
str(data)

#Details the dimension of the dataset, showing the number of rows and columns of the data.
dim(data)

#Analysis Dataset:
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#Combining varibales and scaling:
library(dplyr)
data$deep <- rowMeans(select(data, one_of(deep_questions)))
data$surf <- rowMeans(select(data, one_of(surface_questions)))
data$stra <- rowMeans(select(data, one_of(strategic_questions)))

#Chnage column names:
colnames(data)[which(colnames(data) =="Age")] <- "age"
colnames(data)[which(colnames(data) =="Attitude")] <- "attitude"
colnames(data)[which(colnames(data) =="Points")] <- "points"

#Filtering columns from data
columns_to_keep <- c("gender","age","attitude", "deep", "stra", "surf", "points")
analysis_data <- filter(select(data, one_of(columns_to_keep)), points != 0)

#Writing data:
write.table(analysis_data, file = "data/learning2014.txt",col.names = TRUE)

#Reading learning2014:
lrn2014 <- read.table("data/learning2014.txt", header=TRUE)
str(lrn2014)
dim(lrn2014)


