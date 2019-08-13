###############
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##############

# Load necessary libraries
library(dplyr)

# Download the dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "dataset.zip")

# Unzip the dataset
unzip("dataset.zip")

# Extract columns with std() and mean() measurements from the feature.txt file
features <- read.table("UCI HAR Dataset/features.txt")
char_features <- lapply(features$V2, as.character)

indexes <- which(grepl("-mean()|-std()",char_features))


# Extract information from the test set and construct the test data set
SubjectTest <- as.factor(read.table("UCI HAR Dataset/test/subject_test.txt"))
ActivityTest <- as.factor(read.table("UCI HAR Dataset/test/y_test.txt"))

Xtest <- read.table("UCI HAR Dataset/test/X_test.txt")

test_dataset <- bind_cols(SubjectTest,ActivityTest,Xtest[indexes])

# Extract information from the training set and construct the data set
SubjectTrain <- as.factor(read.table("UCI HAR Dataset/train/subject_train.txt"))
ActivityTrain<- as.factor(read.table("UCI HAR Dataset/train/y_train.txt"))

Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")

train_dataset <- bind_cols(SubjectTrain,ActivityTrain,Xtrain[indexes])

# Merge both train and test data sets
dataset <- bind_rows(test_dataset,train_dataset)

# Labeling the dataset
labels <- c("Subject","Activity",char_features[indexes])
names(dataset) <- labels

# Disply the dataset
head(dataset)

# Creating second dataset

by_sub_act <- dataset %>%   group_by(Subject,Activity) %>% summarise_all(funs(mean))


