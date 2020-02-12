##Getting and cleaning data course project
#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

#Download the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
directory <- "Project directory"

download.file(fileUrl, temp, method = "curl")
unzip(zipfile = temp, exdir = directory)
setwd(directory)

#read in all features and activities:
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

#read in test set
test_set <- read.table("UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

#read in training set
train_set <- read.table("UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")


#STEP 1: Merges the training and test set to create one data set (called combined data)
#also combine labels and subjects for test and train datasets (for later)
combined_data <- rbind(test_set, train_set)
combined_labels <- rbind(test_labels, train_labels)
combined_subjects <- rbind(test_subject, train_subject)

#add the variable labels
names(combined_data) <- features[,2]

#STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#based on the name "Mean()" or "Std()", with or without a capital to start
combined_data <- combined_data[,grep("[Mm]ean\\(\\)|[Ss]td\\(\\)",features$V2)]

#Identify the same features  in the set 
final_features <- grep("[Mm]ean\\(\\)|[Ss]td\\(\\)",features$V2, value = TRUE)

#STEP 3: Uses descriptive activity names to name the activities in the data set
#add description to the labels
combined_labels$activity_description <- activity_labels[combined_labels$V1,2]

#add the labels and subjects to the combined data
labelled_data <- cbind(combined_subjects ,combined_labels[,2], combined_data)

#STEP 4: Appropriately labels the data set with descriptive variable names.
names(labelled_data) <- c("subjects","activity", final_features)

#STEP 5: From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

install.packages("reshape2")
library(reshape2)

melted_data <- melt(labelled_data, id = c("subjects", "activity"))
tidied_data <- dcast(melted_data, subjects + activity ~ variable, mean)

#rename variables to say that its the "mean of"
names(tidied_data)[c(3:ncol(tidied_data))] <- paste("mean of", names(tidied_data)[c(3:ncol(tidied_data))])

#write final, tidy dataset
write.table(tidied_data,"tidied_data.txt", row.names = FALSE)

