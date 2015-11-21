# author: Gyula Magyar for the coursera course "Getting and Cleaning Data"

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
  
  cat("Merging data...\n")
  X <- rbind(test_set, train_set)
  names(X) <- features$featureName
  X <- X[, extractedFeatures]
}

validateFiles <- function() {
  if (!file.exists("UCI_HAR_Dataset/activity_labels.txt") || !file.exists("UCI_HAR_Dataset/features.txt")
      || !file.exists("UCI_HAR_Dataset/test/subject_test.txt") || !file.exists("UCI_HAR_Dataset/test/X_test.txt")
      || !file.exists("UCI_HAR_Dataset/test/y_test.txt") || !file.exists("UCI_HAR_Dataset/train/subject_train.txt")
      || !file.exists("UCI_HAR_Dataset/train/X_train.txt") || !file.exists("UCI_HAR_Dataset/train/y_train.txt")) {
    stop("Missing input files")
  }
}