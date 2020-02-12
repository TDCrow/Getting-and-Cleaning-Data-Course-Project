# Getting-and-Cleaning-Data-Course-Project
There is one R script called run_analysis.R that does the following:
## Downloads the data
The raw data (as found in the link http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is downloaded to a directory called "Project directory". Relevant data is then extracted from the raw data. This includes:
1. Feature names for the raw data; labels for the activities undertaken
2. Test data: the set of accelerometer data in the test set, the labels for that data, and the subjects who were included in the test data
3. Training data: the set of accelerometer data in the training set, the labels for that data, and the subjects who were included in the training data

## Merges the training and test set to create one data set
The raw test data and raw training data was merged.

## Extracts only the measurements on the mean and standard deviation for each measurement
Measurements were only included if they had the name "Mean()" or "Std()" in their title (with or without capitalization).

## Uses descriptive activity names to name the activities in the data set
The measurements were labelled according to their label provided in the raw dataset. The descriptive columns which specfied which subjects were undertaking each measurement and the activity they were doing at the time was added to the data to provide relevant labels.

## Appropriately labels the data set with descriptive variable names
The final data was labelled with the names "subjects" and "activity" for the columns which showed which participants had undertaken which activity, and the accelerometer-specific data was labelled according to the label set from the raw data.

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
The reshape2 package was used. The data was melted into a long, but narrow dataset. Finally, the data was transformed into a tidy dataset organised such that the first column shows which volunteer was undertaking the activites, and the second column shows the activity they were undertaking, and the remainder of the columns show the corresponding means for the relevant variables previously selected. 
- A file is created in the working directory called "tidied_data.txt"
