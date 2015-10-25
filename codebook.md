# Codebook of Getting and Cleaning Data Course Project

Codebook describing the variables, data and work performed to clean up the data.

## Data Source

1. The data is collected from accelerometers from the Samsung Galaxy S smartphone. 
2. Data was collected for a research title 'Human Activity Recognition Using Smartphones Data Set'.
3. The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
4. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist.
4. Full description and download link can be obtained in README.md file.

## Data Set 

The sets of interested data will be used in this course project from the data set provided are

1. `X_train.txt` containing value of variable features recorded from 70% of the volunteers that were selected.
2. `y_train.txt` containing the activity number corresponding to value of variable in `X_train.txt` 
   to be used to recognize the activity number from `subject_train.txt`.
3. `subject_train.txt` containing the number of the activity corresponding to name in `activity_labels.txt`.
4. `X_test.txt` contains value of variable features from 30% of the volunteers that were selected.
5. `y_test.txt` containing the activity number corresponding to value of variable in `X_test.txt` 
   to be used to recognize the activity name from `subject_test.txt`.
6. `subject_test.txt` containing the number of the activity corresponding to number in `activity_labels.txt`.
7. `features.txt` containing the name of variable feature in the `X_train.txt` and `X_test.txt`.
8. `activity_labels.txt` containing name on the different types of activities.

Number in `subject_test.txt` and `subject_train.txt` corresponding to `activity_labels.txt`
- 1 corresponding to WALKING
- 2 corresponding to WALKING_UPSTAIRS
- 3 corresponding to WALKING_DOWNSTAIRS
- 4 corresponding to SITTING
- 5 corresponding to STANDING
- 6 corresponding to LAYING

Number in `y_train.txt` and `y_test.txt` are integers of 1,2,3 until 30, corresponding to the 30 volunteers for the activity.

Features Name Description :
- t     = Time
- f     = Frequency (Freq as short abbreviation)
- Acc   = Accelerometer
- Gyro  = Gyroscope 
- mean = Mean
- std  = Standard Deviation
- Mag   = Magnitude
- Jerk  = Linear Acceleration
- X,Y,Z = 3-Axial

## Transformation to tidy data

1. Read all sets of interested data

```r
allFeatures <- fread("./UCI HAR Dataset/features.txt")
allActivityLabels <- fread("./UCI HAR Dataset/activity_labels.txt")

subject_Train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_Test <-  read.table("./UCI HAR Dataset/test/subject_test.txt")

x_Test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_Test <- read.table("./UCI HAR Dataset/test/y_test.txt")

x_Train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_Train <- read.table("./UCI HAR Dataset/train/y_train.txt")
```

2. Extract only mean and standard deviation features
 
```r
features_Mean_Std <- allFeatures[grepl("mean\\(\\)|std\\(\\)", Features)]
x_Test <- x_Test[, features_Mean_Std$Features]
```

3. Combine all the data for training and testing
```r
full_Data <- rbind(train_Data, test_Data)
```

4. Reshape the data to generate tidy data set with the average of each variable for each activity and each subject
```r
arrange_Data <- melt(full_Data, id = main_Names, measure.vars = data_Names)
tidy_data   = dcast(arrange_Data, Subject + Activity ~ variable, mean)
```

5. Appropriate labelling of data set with descriptive variable names
```r
names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Freq", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data) <- gsub("-mean\\(\\)", "Mean", names(tidy_data))
names(tidy_data) <- gsub("-std\\(\\)", "SD", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
```

## Output Data Set

A space-delimited text file name `tidy_data.txt` will be generated in the working directory
with header of the tidy data set with average of each variable of mean and standard deviation
for each of the 6 activities by 30 volunteers.