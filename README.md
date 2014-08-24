GettingAndCleaningData
======================

Course Project for Getting and Cleaning Data Course

A 'run_analysis.R' script converts the provided data into the two required tidy data sets.

A code book is provided in both .md and .csv formats.

The procedure for converting the data files into the required data sets is given below.

Procedure:
1. Read the activity labels
2. Read the feature names
3. Read the train data - the data, the labels, the subjects
4. Bind the data from step 3 into 1 data table - the train data
5. Assign the correct column names to the train data
6. Read the test data - the data, the labels, the subjects
7. Bind the data from step 6 into 1 data table - the test data
8. Assign the correct column names to the test data
9. Combine the train and test data into 1 data table
10. Replace the activity labels with the activity names
11. Publish the data set as 'UCI HAR Dataset.txt' data file
12. Loop over each subject and each activity to get the mean values of all features and store in a table
13. Publish the data set as 'UCI HAR Averaged Dataset.txt' data file
