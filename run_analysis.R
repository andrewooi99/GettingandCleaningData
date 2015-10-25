## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## auto download "data.table"/"reshape2" packages if any of them are not installed.
if (!require("data.table")) {
    install.packages("data.table")
}

if (!require("reshape2")) {
    install.packages("reshape2")
}

require("data.table", character.only = TRUE, quietly = TRUE)
require("reshape2", character.only = TRUE, quietly = TRUE)

allFeatures <- fread("./UCI HAR Dataset/features.txt")
setnames(allFeatures, names(allFeatures), c("No", "Features"))

#Extract only the mean and standard deviation
features_Mean_Std <- allFeatures[grepl("mean\\(\\)|std\\(\\)", Features)]

allActivityLabels <- fread("./UCI HAR Dataset/activity_labels.txt")
setnames(allActivityLabels, names(allActivityLabels), c("No", "Activity"))

subject_Train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_Test <-  read.table("./UCI HAR Dataset/test/subject_test.txt")

x_Test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_Test <- read.table("./UCI HAR Dataset/test/y_test.txt")

x_Train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_Train <- read.table("./UCI HAR Dataset/train/y_train.txt")

names(x_Test) <- allFeatures$Features
x_Test <- x_Test[, features_Mean_Std$Features]

y_Test[,2] <- allActivityLabels[y_Test[,1]]$Activity
names(y_Test) = c("Activity_Code", "Activity")
names(subject_Test) <- "Subject"

test_Data <- cbind(subject_Test, y_Test, x_Test)

names(x_Train) <- allFeatures$Features
x_Train <- x_Train[, features_Mean_Std$Features]

y_Train[,2] <- allActivityLabels[y_Train[,1]]$Activity
names(y_Train) = c("Activity_Code", "Activity")
names(subject_Train) <- "Subject"

train_Data <- cbind(subject_Train, y_Train, x_Train)

full_Data <- rbind(train_Data, test_Data)

main_Names <- c("Subject", "Activity_Code", "Activity")
data_Names <- setdiff(colnames(full_Data), main_Names)
arrange_Data <- melt(full_Data, id = main_Names, measure.vars = data_Names)
tidy_data   = dcast(arrange_Data, Subject + Activity ~ variable, mean)

names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Freq", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data) <- gsub("-mean\\(\\)", "Mean", names(tidy_data))
names(tidy_data) <- gsub("-std\\(\\)", "SD", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))

write.table(tidy_data, file = "./tidy_data.txt", row.names = FALSE)

