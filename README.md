Data Science Coursera
===================
#Getting and Cleaning Data Course Project

###Instructions for running the run_analysis.R script
1. Download run_analysis.R into your R working directory
2. Unzip the data file obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip into the your R working directory
3. Do not rename the unzipped folder; it should be named "UCI HAR Dataset"
4. Make sure you have the plyr package installed before running the script
5. Run run_analysis.R and the tidy data file will be in your in UCI HAR Dataset folder

###Explanation of run_analysis.R script
- The script reads all test and train data files (excluding data from Inertial Signals folder) and combines them to form 1 dataset
- Every column is assigned a title by reading from the features.txt file
- The column containing subject_train and subject_test data is named "Subject" since it identifieds the subject who performed the activity
- The column containing y_train and y_test is named "Activity" since it identifies the activity number that was performed by the subject
- Only columns containing the words "mean" and "std" are kept in the data table
- Column names are cleaned up by removing unncessary characters such as "()" and "-"
- A tidy data set is created by calculating the average of each variable for each activity and subject
- The activity number is matched to an activity description to give the data table more readability