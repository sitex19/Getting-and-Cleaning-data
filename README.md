# Getting-and-Cleaning-data

The goal of this assignment is to prepare tidy data that can be used for later analysis. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


###Assumptions

The script assumes the data will be found in the directory "./UCI HAR Dataset/". 
The script requires that the packages "plyr" and "reshape2" are available.

###How the script works

    First it merges the training and the test sets to create one data set.
    It extracts only the measurements on the mean and standard deviation for each measurement. 
    It uses descriptive activity names to name the activities in the data set
    And it ppropriately labels the data set with descriptive variable names. 
