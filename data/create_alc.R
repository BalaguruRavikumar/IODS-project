#Name: Balaguru Ravikumar
#Data: 17/11/17
#Description: Data Wrangling excerise: Logistic Regression

#Upload both the Datatsets:
math <- read.table("student-mat.csv", sep = ";" , header=TRUE)
por <-  read.table("student-por.csv", sep = ";" , header=TRUE)

#Explore Structure and Dim of data:
str(math); str(por)
dim(math) # 359 X 33 
dim(por) # 649 X 33

#Join dataset and Select entries:
library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(math, por, suffix = c(".math",".por"),by = join_by)

#Exploring the Structure and Dimension of dataset:
str(math_por)
dim(math_por) #382 X 53

#Combine duplicate answers:
alc <- select(math_por, one_of(join_by))
notjdcl <- colnames(math)[!colnames(math) %in% join_by]

#For-loop with if else:
for(cname in notjdcl){
  cls <- select(math_por, starts_with(cname))
  if(is.numeric(cls[[1]])){
    alc[cname] <- round(rowMeans(cls))
  }else{ alc[cname] <- cls[[1]]}
}

#Explore data:
str(alc)
dim(alc)
str(alc)

#Alcohol Consumptions and High Use:
alc <- mutate(alc, alc_use = (Dalc+Walc)/2)
alc <- mutate(alc, high_use = alc_use > 2)

#Explore the dataset:
glimpse(alc)

#Saving the data:
write.table(alc, file = "alc_data.txt")
