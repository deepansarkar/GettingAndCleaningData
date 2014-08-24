# Preaparing the tidy data set

# Get the Activity Labels
activityLabels <- read.table( "activity_labels.txt" )
colnames( activityLabels ) <- c( "Number", "Activity" )

# Get the Features
features <- read.table( "features.txt" )
colnames( features ) <- c( "Number", "Features" )

# Creating the training data sets
trainData <- read.table( "./train/X_train.txt" )
trainLabels <- read.table( "./train/y_train.txt" )
trainSubject <- read.table( "./train/subject_train.txt" )
train <- cbind( trainSubject, trainLabels, trainData )
colnames( train ) <- c( "Subject", "Activity", as.character(features[,"Features"]) )

# Creating the testing data sets
testData <- read.table( "./test/X_test.txt" )
testLabels <- read.table( "./test/y_test.txt" )
testSubject <- read.table( "./test/subject_test.txt" )
test <- cbind( testSubject, testLabels, testData )
colnames( test ) <- c( "Subject", "Activity", as.character(features[,"Features"]) )

# Combine the data sets into one
data <- rbind( train, test )

# Locate the columns with mean and standard deviation values
colIndex1 <-  2 + grep( "mean()", as.character(features[,"Features"]) )
colIndex2 <-  2 + grep( "std()", as.character(features[,"Features"]) )
colIndex <- c( 1, 2, colIndex1, colIndex2 )
colIndex <- sort( colIndex )

# Keep the required columns
data <- data[,colIndex]

# Replace activity labels
activity <- sort( unique(data[,"Activity"]) )
for( loop1 in 1:length(activity) )
  data[data[,"Activity"]==activity[loop1],"Activity"] <- 
    as.character( activityLabels[activityLabels[,"Number"]==loop1,"Activity"] )

# Write the data to hard disk
write.table( data, "UCI HAR Dataset.txt" )

# Data set with average of each variable
avgData <- matrix( nrow=0, ncol=ncol(data) )
colnames( avgData ) <- colnames(data)

subject <- sort( unique(data[,"Subject"]) )
activity <- sort( unique(data[,"Activity"]) )
# Loop over each subject
for( loop1 in 1:length(subject) )
{
  # Loop ovear each activity
  for( loop2 in 1:length(activity) )
  {
    avgData <- rbind( avgData, NA )
    avgData[nrow(avgData),1:2] <- c( subject[loop1], activity[loop2] )
    rowIndex <- data[,"Subject"]==subject[loop1] & data[,"Activity"]==activity[loop2]
    # Loop over all attributes
    for( loop3 in 1:(ncol(data)-2) )
      avgData[nrow(avgData),loop3+2] <- mean( data[rowIndex,loop3+2], na.rm=TRUE )
  }
}

# Write the average data to hard disk
write.table( avgData, "UCI HAR Averaged Dataset.txt" )