# Getting and Cleaning Data : Course Project

## General Description of Course Project

The object of the project is to demonstrate the ability to collect, work with
and to generate a clean data set from a given set of data. The meaning of a clean
data set is a set of data that is appropriate, tidy and directly usable for activity
like analysis.

The data provided for this course is collected from accelerometers from
Samsung Galaxy S smartphone. Full description is available at the site below where
the data was obtained.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The below link is the url to download the data for the project.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Functionality of the script

The script named run_analysis.R is to perform the following steps

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Prerequisites for running `run_analysis.R`

1. Requires "data.table" package to be installed.
2. Requires "reshape2" package to be installed.
3. In case of the two packages mentioned above are not installed, the `run_analysis.R` code
   will trigger the download of the two required packages.

## How to work with the script

1. Download the data from the download link provided. 
2. Download the `run_analysis.R` provided in the repository.
3. Place the `run_analysis.R` in a folder you desired, extract the data downloaded that has a sub-folder titled
   as `UCI HAR Dataset` and place the folder `UCI HAR Dataset` inside the folder where you placed `run_analysis.R`.
4. Run your R programming IDE and set the directory to be the folder where you place `run_analysis.R` and `UCI HAR Dataset` to be your working directory.
5. Load the `run_analysis.R` script in your R programming IDE with `source("run_analysis.R")
6. A text file named `tiny_data.txt` will then be generated in the working directory.
