# author: Gyula Magyar for the coursera course "Getting and Cleaning Data"

run_analysis <- function() {
  # Basic validation to ensure that the required input files are in place
  validateFiles()
  
  # Read the required files
  activity_labels <- read.table("UCI_HAR_Dataset/activity_labels.txt", col.names=c("activity_id", "activity_name"))
  feature_names <- read.table("UCI_HAR_Dataset/features.txt")[,2]
  
  test_subjects <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
  test_set <- read.table("UCI_HAR_Dataset/test/X_test.txt")
  test_labels <- read.table("UCI_HAR_Dataset/test/y_test.txt")
  
  train_subjects <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
  train_set <- read.table("UCI_HAR_Dataset/train/X_train.txt")
  train_labels <- read.table("UCI_HAR_Dataset/train/y_train.txt")
}

validateFiles <- function() {
  if (!file.exists("UCI_HAR_Dataset/activity_labels.txt") || !file.exists("UCI_HAR_Dataset/features.txt")
      || !file.exists("UCI_HAR_Dataset/test/subject_test.txt") || !file.exists("UCI_HAR_Dataset/test/X_test.txt")
      || !file.exists("UCI_HAR_Dataset/test/y_test.txt") || !file.exists("UCI_HAR_Dataset/train/subject_train.txt")
      || !file.exists("UCI_HAR_Dataset/train/X_train.txt") || !file.exists("UCI_HAR_Dataset/train/y_train.txt")) {
    stop("Missing input files")
  }
}