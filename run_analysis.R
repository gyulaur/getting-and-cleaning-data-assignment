# author: Gyula Magyar for the coursera course "Getting and Cleaning Data"

run_analysis <- function() {
  validateFiles()
}

validateFiles <- function() {
  required_files <- c("UCI_HAR_Dataset/activity_labels.txt", "UCI_HAR_Dataset/features.txt",
                      "UCI_HAR_Dataset/test/subject_test.txt", "UCI_HAR_Dataset/test/X_test.txt",
                      "UCI_HAR_Dataset/test/y_test.txt", "UCI_HAR_Dataset/train/subject_test.txt",
                      "UCI_HAR_Dataset/train/X_test.txt", "UCI_HAR_Dataset/train/y_test.txt")
  if (!file.exists("UCI_HAR_Dataset/activity_labels.txt")) {
    stop("Missing input files")
  }
}