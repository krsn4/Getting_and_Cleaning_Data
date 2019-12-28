library(data.table)
library(dplyr)
getwd()
setwd('C:/Users/akirasano/Documents')
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./Coursera/Data/dataset.zip")
#unzipped, ./Coursera/Data/UCI HAR Dataset
unzip("./Coursera/Data/dataset.zip", exdir = "./Coursera/Data")
setwd("./Coursera/Data/UCI HAR Dataset/")
# Merge X_train.txt and X_test.txt "vertically", keep the max number of columns common to all rows combined
setwd("./train/")
file.list <- list.files(pattern = './*.txt')
df.list <- lapply(file.list, fread)
#str(df.list)
train <- bind_cols(df.list)
#train <- rename(train, subject = V1, activity = V1101)

setwd("../test")
file.list <- list.files(pattern = './*.txt')
df.list <- lapply(file.list, fread)
#str(df.list)
test <- bind_cols(df.list)
#test <- rename(test, subject = V1, activity = V1101)

dataset <- bind_rows(train, test)
dataset <- rename(dataset, subject = V1, activity = V1101, V1 = V1100)
str(dataset)
# convert sub and activity as factors
dataset$subject <- as.factor(dataset$subject)
dataset$activity <- as.factor(dataset$activity)
str(dataset[, c("subject", "activity")])

#Bring activity as the second column (could have been done earlier)
setcolorder(dataset, c("subject", "activity"))

#var names from features.txt
#setwd("Coursera/Data/UCI HAR Dataset/test")
features <- read.table("../features.txt")#, as.is = TRUE)
setnames(dataset, old = c(3:563), new = as.character(features[,2]))
#only mean(), std()
mnsd <- grep("mean\\(\\)|std\\(\\)", names(dataset), value = TRUE)
cols <- append(c("subject", "activity"), mnsd)
dataset2 <- dataset[, ..cols]

#Label activities
activities <- read.table("../activity_labels.txt") #, as.is = TRUE)
#activities[,2] <- tolower(activities[,2])
#Name activities instead of numbers
for (m in 1:length(activities[,1])) 
    {dataset2[activity == activities[m,1], activity := activities[m,2],]}

# average of all variables by subject, and then by activity
feature_avgs_by_subj <-
  dataset2 %>% 
  group_by(subject) %>% 
  select(-(1:2)) %>%
  summarize_all(list(mean = mean))

feature_avgs_by_activ <-
  dataset2 %>% 
  group_by(activity) %>% 
  select(-(1:2)) %>%
  summarize_all(list(mean = mean))

#write dataset2, feature_avgs_by_subj, feature_avgs_by_activ to csv, save them in ./GCData
setwd("C:/Users/akirasano/Documents/Coursera/Getting_and_Cleaning_Data/")
dir.create("./GCData")
setwd("GCData")
fwrite(dataset2, file = "dataset2.csv")
fwrite(feature_avgs_by_subj, file = "feature_avgs_by_subj.csv")
fwrite(feature_avgs_by_activ, file = "feature_avgs_by_activ.csv")
setwd("../")

#new
#tidy dataset (dataset2) needs to be uploaded in .txt and by write.table()
write.table(dataset2, file = "C:/user/sakirasano/Documents/Coursera/Getting_and_Cleaning_Data/dataset2.txt", row.names = FALSE)
