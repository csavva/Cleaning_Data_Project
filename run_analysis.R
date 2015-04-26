## This script does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

# Set the data column names vector
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Set the activity labels vector
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Get only the measurements on the mean and standard deviation for each measurement.
getFeatures <- grepl("mean|std", features)

# Get and process x_test & y_test data.
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(xTest) <- features

# Get only the measurements on the mean and standard deviation for each measurement.
xTest <- xTest[,getFeatures]

# Get activity labels
yTest[,2] <- activityLabels[yTest[,1]]
names(yTest) = c("Activity_ID", "Activity_Label")
names(subjectTest) = "subject"

# Bind the test data together
testData <- cbind(as.data.table(subjectTest), yTest, xTest)

# Load and process xTrain & yTrain data.
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(xTrain) = features

# Get only the measurements on the mean and standard deviation for each measurement.
xTrain = xTrain[,getFeatures]

# Get activity data
yTrain[,2] = activityLabels[yTrain[,1]]
names(yTrain) = c("Activity_ID", "Activity_Label")
names(subjectTrain) = "subject"

# Bind data
trainData <- cbind(as.data.table(subjectTrain), yTrain, xTrain)

# Merge the test and train data together
completeData = rbind(testData, trainData)

ids   = c("subject", "Activity_ID", "Activity_Label")
dataLabels = setdiff(colnames(completeData), ids)
comboData      = melt(completeData, id = ids, measure.vars = dataLabels)

# Apply the mean function to dataset using dcast function
tidiedData   = dcast(meltedData, subject + Activity_Label ~ variable, mean)

# Write the final dataset to file
write.table(tidiedData, file = "./tidied_dataset.txt",row.name=FALSE)