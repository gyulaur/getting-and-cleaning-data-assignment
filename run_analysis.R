# author: Gyula Magyar, for the coursera course "Getting and Cleaning Data"

library(dplyr)
library(reshape2)

run_analysis <- function() {
  # Basic validation to ensure that the required input files are in place
  validateFiles()
  
  # Reading common input files
  activities <- read.table("UCI_HAR_Dataset/activity_labels.txt", col.names=c("activityId", "activityName"))
  features <- read.table("UCI_HAR_Dataset/features.txt", col.names=c("featureId", "featureName"))
  # Selecting the required features
  extractedFeatures <- grep("-mean\\(\\)|-std\\(\\)", features$featureName)
  
  # Reading the test data set
  test_subjects <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
  test_set <- read.table("UCI_HAR_Dataset/test/X_test.txt")
  test_labels <- read.table("UCI_HAR_Dataset/test/y_test.txt")
  
  # Reading the training data set
  train_subjects <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
  train_set <- read.table("UCI_HAR_Dataset/train/X_train.txt")
  train_labels <- read.table("UCI_HAR_Dataset/train/y_train.txt")
  
  # Merging the training and test sets to one data set (step 1)
  X <- rbind(train_set, test_set)
  
  # Extracting the measurements on standard deviation and mean (step 2)
  names(X) <- features$featureName
  X <- X[, extractedFeatures]
  
  # Preparing the subjects
  subjects <- rbind(train_subjects, test_subjects)
  names(subjects) <- "subjectId"
  
  # Preparing the activities
  Y <- rbind(train_labels, test_labels)
  names(Y) <- "activityId"
  
  # Merging the subjects, the data, and the activities
  data <- cbind(subjects, X, Y)
  
  # Replacing activity ids with their names (step 3)
  data <- merge(activities, data, by="activityId")
  data <- select(data, select = -activityId)
  
  # Labeling the data with descriptive variable names. The original names are OK,
  # just removing the parenthesis to make it readable (step 4)
  names(data) <- gsub("\\(\\)","", names(data))
  
  # Creating a tidy data set with the mean of each variable for each activity and each subject (step 5)
  tidy_data <- melt(data, id = c("subjectId", "activityName"))
  tidy_data <- dcast(tidy_data, subjectId + activityName ~ variable, mean)
  write.table(tidy_data, file="tidy_data.txt", row.names=FALSE)
}

validateFiles <- function() {
  if (!file.exists("UCI_HAR_Dataset/activity_labels.txt") || !file.exists("UCI_HAR_Dataset/features.txt")
      || !file.exists("UCI_HAR_Dataset/test/subject_test.txt") || !file.exists("UCI_HAR_Dataset/test/X_test.txt")
      || !file.exists("UCI_HAR_Dataset/test/y_test.txt") || !file.exists("UCI_HAR_Dataset/train/subject_train.txt")
      || !file.exists("UCI_HAR_Dataset/train/X_train.txt") || !file.exists("UCI_HAR_Dataset/train/y_train.txt")) {
    stop("Missing input files")
  }
}