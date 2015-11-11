# First we want to merge the training and the test sets (X_test.txt and X_train.txt) to create one data set.

# reading the test dataset
test_features <-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
test_activities <-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

## reading the training data
train_features <-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
train_activities <-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
subject_train <-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

## Merge the training and the test sets to create one data set.
features_full<-rbind(test_features, train_features)
activities_full<-rbind(test_activities, train_activities)
subject_full<-rbind(subject_test, subject_train)

## Name the columns in x_full from features.txt
features <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
colnames(features_full)<-features[,2]

##We want to extract only the measurements on the mean and standard deviation for each measurement

## The columns with the desired measurements are labeled using mean() and std() 
rightcols<- grepl("std|mean",colnames(features_full))
features_mean_std <- features_full[,rightcols]

## We want to use descriptive activity names to name the activities in the data set "activities"
activities<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

activities_factor <- as.factor(activities_full[,1])

## Get the plyr library to use the function mapvalues
library(plyr)

activities_factor <- mapvalues(activities_factor,from = as.character(activities[,1]), to = as.character(activities[,2]))

## activities_factor is now a factor with 6 named levels
features_mean_std <- cbind(activities_factor, features_mean_std)  

## Setting the name of the new first column to "activity" 
colnames(features_mean_std)[1] <- "activity"

## Setting the name of the first column of features to "subject"
features_mean_std <- cbind(subject_full, features_mean_std)
colnames(features_mean_std)[1] <- "subject"

## We need to creates a second, independent tidy data set with the average of each variable for each activity and each 
## subject. 

## The goal is to take the average for each column of all values where subject and activity are the same, and to
## sort the resulting data so the first six rows are each activity for subject one, then the six for subject two etc.
## This can be done using the reshape functions 

library(reshape2)

features_melt<- melt(features_mean_std,id.vars=c("subject","activity"))
tidy_dataset <- dcast(features_melt, subject + activity ~ ..., mean)

write.table(tidy_dataset, "tidy_data.txt")
