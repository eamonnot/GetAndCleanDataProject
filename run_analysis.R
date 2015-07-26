# This script contains all the functions necessary to process and tidy the UCI HAR Dataset.

# The function cleanMyData is a workflow function that calls subfunctions in turn to process the data.
# It takes as input the filepath to the data, which defaults to "UCI HAR Dataset"
# It returns the tidied dataset, which is also written to a "tidiedData.txt" in the working directory
cleanTheData <- function(filepath = "UCI HAR Dataset") {
  # Step 1a: Read in both training and test data
  XData = readInAndBindXData(filepath)
  YData = readInAndBindYData(filepath)
  subjectData = readInAndBindSubjectData(filepath)
  
  # Step 1b: Merge the Data
  mergedData = mergeData(XData, YData, subjectData)
  
  # Step 2: Extract Only the Mean & Std for Each Measurement
  mergedData <- extractMeanStd(mergedData)
  
  # Step 3: Label Activities
  mergedData <- addActivityLabels(mergedData)
  
  # Step 4: Appropriately Label the dataset variable names
  mergedData <- tidyVarNames(mergedData)
  
  # Step 5a: Reshape the data to get the required averages
  finalData <- reshapeData(mergedData)
  
  # Step 5b: Print the final data to file
  write.table(finalData, file="tidiedData.txt", row.names=FALSE)
  return (finalData);
}

# This function reads in the X data for both the train and test datasets.
# It takes as input the filepath to the data set.
# It also reads the feature names contained in the features.txt file
# It binds the X data, top "train" then "test" and names the variables with the feature names.
# Finally it returns a single combined dataset
readInAndBindXData <- function(filepath){
  # Read in X Training Data
  xTrain <- read.table(paste(filepath,"train/X_train.txt",sep="/"), nrows=5)
  xTrain.classes <- lapply(xTrain, class)
  xTrain <- read.table(paste(filepath,"train/X_train.txt",sep="/"), colClasses=xTrain.classes)
  
  # Read in X Test Data
  xTest <- read.table(paste(filepath,"test/X_test.txt",sep="/"), nrows=5)
  xTest.classes <- lapply(xTest, class)
  xTest <- read.table(paste(filepath,"test/X_test.txt",sep="/"), colClasses=xTest.classes)
  
  # Combine the Train and Test Data
  xDataMerged <- rbind(xTrain,xTest)
  
  # Now assign the feature names to the data from feature.txt
  xFeatureNames <- read.table(file = "UCI HAR Dataset/features.txt")
  colnames(xDataMerged) <- xFeatureNames[,2]
  
  # Return the merged X data
  return (xDataMerged);
}

# This function reads in the Y data for both the train and test datasets.
# It takes as input the filepath to the data set.
# It binds the Y data, top "train" then "test" into a single column vector.
# The data is labelled "Activity"
# Finally it returns a single combined dataset
readInAndBindYData <- function(filepath) {
  # Read in Y Training Data
  yTrain <- read.table(paste(filepath,"train/y_train.txt",sep="/"), nrows=5)
  yTrain.classes <- lapply(yTrain, class)
  yTrain <- read.table(paste(filepath,"train/y_train.txt",sep="/"), colClasses=yTrain.classes, 
                       col.names = c("Activity"))
    
  # Read in Y Test Data
  yTest <- read.table(paste(filepath,"test/y_test.txt",sep="/"), nrows=5)
  yTest.classes <- lapply(yTrain, class)
  yTest <- read.table(paste(filepath,"test/y_test.txt",sep="/"), colClasses=yTest.classes, 
                      col.names = c("Activity"))
  
  # Combine the Train and Test Data
  yDataMerged <- rbind(yTrain,yTest)
  
  # Return the merged Y data
  return (yDataMerged);
}

# This function reads in the Subject data for both the train and test datasets.
# It takes as input the filepath to the data set
# It binds the Subject data, top "train" then "test" into a single column vector.
# The data is labelled "SubjectID"
# Finally it returns a single combined dataset
readInAndBindSubjectData <- function(filepath) {
  # Read in Y Training Data
  sTrain <- read.table(paste(filepath,"train/subject_train.txt",sep="/"), nrows=5)
  sTrain.classes <- lapply(sTrain, class)
  sTrain <- read.table(paste(filepath,"train/subject_train.txt",sep="/"), colClasses=sTrain.classes, 
                       col.names = c("SubjectID"))
  
  # Read in Y Test Data
  sTest <- read.table(paste(filepath,"test/subject_test.txt",sep="/"), nrows=5)
  sTest.classes <- lapply(sTrain, class)
  sTest <- read.table(paste(filepath,"test/subject_test.txt",sep="/"), 
                      colClasses=sTest.classes, col.names = c("SubjectID"))
  
  # Combine the Train and Test Data
  sDataMerged <- rbind(sTrain,sTest)
  return (sDataMerged);
}

# This function merges the X, Y and Subject datasets together using a simple column bind.
# It takes as input the x (the X dataset), y (the Y dataset) and s (the Subject Data Set)
# It returns a single combined dataset with the first column being the Subject data.
# The second column is the Activity data. all subsequent columns are the X data.
mergeData <- function(x = data.frame(), y = data.frame(), s = data.frame()) {
  # Merge the data using cbind()
  allDataMerged <- cbind(s,y,x)
  # Return the merged dataset
  return (allDataMerged);
}

# This function takes the initial merged dataset and removes unwanted variables.
# Unwanted variables are any variables that are not related to mean or standard deviation of measurements.
# It does this by keeping only columns with "mean()" or "std()" in the column names.
# The Activity and SubjectID columns are also retained.
extractMeanStd <- function(x){
  # Set up the strings we are looking for in column names.
  meanString <- "mean\\(\\)"
  stdString <- "std\\(\\)"
  # Keep only those columns that meet this criteria.
  x <- x[,grepl(meanString,names(x),ignore.case = TRUE) 
           | grepl(stdString,names(x),ignore.case = TRUE) 
           | grepl("Activity",names(x))
           | grepl("SubjectID",names(x))]
  
   #Return the updated dataset
  return(x)
}

# This function is responsibly for tidying the variable names of the dataset.
# It takes as input the merged dataset with untidy names.
# Variable names are made tidy using gsub, ensuring they are human readable.
# It returns the dataset x with updated tidy variable names.
tidyVarNames <- function(x){
  # Step 1: Remove special characters around Mean and Std
  colnames(x) <- gsub("\\-mean\\(\\)\\-", "Mean", colnames(x))
  colnames(x) <- gsub("\\-mean\\(\\)", "Mean", colnames(x))
  # Step 1a: Replace the  
  colnames(x) <- gsub("\\-std\\(\\)\\-", "StandardDeviation", colnames(x))
  colnames(x) <- gsub("\\-std\\(\\)", "StandardDeviation", colnames(x))
  # Step 2: Replace the t and f at the start of variables with Time and Frequency respectivley.
  colnames(x) <- gsub("^t","Time",colnames(x))
  colnames(x) <- gsub("^f","Frequency",colnames(x))
  # Step3: Replace the abbrevations for Accelerometer and Gyroscope with the actual words
  colnames(x) <- gsub("[Aa]cc","Accelerometer",colnames(x))
  colnames(x) <- gsub("[Gg]yro","Gyroscope",colnames(x))
  # Step 4: Replace the abbrevations for Magnitude with the actual Words.
  colnames(x) <- gsub("[Mm]ag","Magnitude",colnames(x))
  # Step 5: Tidy up the Axis Details
  colnames(x) <-gsub("MeanX$","XAxisMean",colnames(x))
  colnames(x) <-gsub("MeanY$","YAxisMean",colnames(x))
  colnames(x) <-gsub("MeanZ$","ZAxisMean",colnames(x))
  colnames(x) <-gsub("StandardDeviationX$","XAxisStandardDeviation",colnames(x))
  colnames(x) <-gsub("StandardDeviationY$","YAxisStandardDeviation",colnames(x))
  colnames(x) <-gsub("StandardDeviationZ$","ZAxisStandardDeviation",colnames(x))
  
  
  return(x)
}

# This function replaces the Activity Codes in the raw dataset with the descriptive Activity Name
# It takes as input the data frame x
# It returns the dataframe x with the Activity Codes replaced by descriptive Activity Names.
addActivityLabels <- function(x){
  x$Activity <- as.factor(x$Activity)
  myFactors <- read.table("UCI HAR Dataset/activity_labels.txt")
  levels(x$Activity) <- myFactors$V2
  return(x)
}

# This function reshapes the merged dataset so that the values for each variable are combined
# and averaged for each activity and each subject.
# The function loads the reshape2 library to do this.
# It returns the reshaped dataset.
reshapeData <- function(x){
  # Load the library reshape2
  library(reshape2)
  
  # Get the ID names and measure.vars names for the melt function
  # Id names are in column 1 and 2
  idNames = colnames(x)[1:2]
  # measure.vars are all other variables.
  varChoice = colnames(x) %in% idNames
  varNames = colnames(x)[!varChoice]
  
  # Melt the dataset 
  meltedX <- melt(x,id=idNames, measure.vars = varNames)
  # Recast the dataset using dcast, grouping by Activity and SubjectID across all variables
  # And applying a mean across each of these groups.
  recastX <- dcast(meltedX, Activity + SubjectID ~ variable, mean)
  
  # Return the recast dataset.
  return(recastX)
}

