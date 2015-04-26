# Cleaning_Data_Project

A project for the Cleaning Data module of Data Science specialisation in Coursera

## The Project Requirement


Create an R script called ```run_analysis.R``` that does the following:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to work on this course project

- Download the data source and unzip it into a folder on your drive. It will create a UCI HAR Dataset folder.
- Put ```run_analysis.R``` in the parent folder of UCI HAR Dataset, then set it as your working directory.
- Run the script (```run_analysis.R```)
- A new file ```tidied_dataset.txt``` will be created in your working directory.


##Dependencies

The ```run_analysis.R``` file will install all the dependencies. 

Packages required: 

- reshape2

- data.table
