Getting and Cleaning Data Assignment
====================================

Course project for the coursera course "Getting and Cleaning Data"

Submitted files
---------------
- [run_analysis.R](run_analysis.R): contains the script to create the tidy data
- [README.md](README.md): the current file
- [CodeBook.md](CodeBook.md): describes the process of tidying the data and lists the variables in the resulting data set
- [tidy_data.txt](tidy_data.txt): contains the resulting tidy data

run_analysis.R
--------------
The cleanup script performs the following steps:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To run the script you should first download and extract the [source data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to your working directory, and install the R packages "dplyr" and "reshape2". After loading the script you can run it with
```
run_analysis()
```
The result is saved in a file called "tidy_data.txt". To load the tidy data, use
```
read.table("tidy_data.txt", header=TRUE)
```
