# author: Gyula Magyar, for the coursera course "Getting and Cleaning Data"

library(dplyr)
library(reshape2)

run_analysis <- function() {
  # Basic validation to ensure that the required input files are in place
  validateFiles()
  
  # Read the required files
  cat("Reading input files...\n")
  activities <- read.table("UCI_HAR_Dataset/activity_labels.txt", col.names=c("activityId", "activityName"))
  features <- read.table("UCI_HAR_Dataset/features.txt", col.names=c("featureId", "featureName"))
  extractedFeatures <- grep("-mean\\(\\)|-std\\(\\)", features$featureName)
  
  test_subjects <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
  test_set <- read.table("UCI_HAR_Dataset/test/X_test.txt")
  test_labels <- read.table("UCI_HAR_Dataset/test/y_test.txt")
  
  train_subjects <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
  train_set <- read.table("UCI_HAR_Dataset/train/X_train.txt")
  train_labels <- read.table("UCI_HAR_Dataset/train/y_train.txt")
  
  cat("Merging datasets...\n")
  X <- rbind(train_set, test_set)
  
  cat("Extracting features...\n")
  names(X) <- features$featureName
  X <- X[, extractedFeatures]
  
  cat("Merging subjects\n")
  subjects <- rbind(train_subjects, test_subjects)
  names(subjects) <- "subjectId"
  
  cat("Merging activities\n")
  Y <- rbind(train_labels, test_labels)
  names(Y) <- "activityId"
  
  cat("Merging dataframes")
  data <- cbind(subjects, X, Y)
  data <- merge(activities, data, by="activityId")
  data <- select(data, select = -activityId)
  names(data) <- gsub("\\(\\)","", names(data))
  tidy_data <- melt(data, id = c("subjectId", "activityName"))
  tidy_data <- dcast(tidy_data, subjectId + activityName ~ variable, mean)
  write.table(tidy_data, file="tidy_data.txt", row.names=FALSE)
  tidy_data
}

validateFiles <- function() {
  if (!file.exists("UCI_HAR_Dataset/activity_labels.txt") || !file.exists("UCI_HAR_Dataset/features.txt")
      || !file.exists("UCI_HAR_Dataset/test/subject_test.txt") || !file.exists("UCI_HAR_Dataset/test/X_test.txt")
      || !file.exists("UCI_HAR_Dataset/test/y_test.txt") || !file.exists("UCI_HAR_Dataset/train/subject_train.txt")
      || !file.exists("UCI_HAR_Dataset/train/X_train.txt") || !file.exists("UCI_HAR_Dataset/train/y_train.txt")) {
    stop("Missing input files")
  }
}