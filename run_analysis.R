
cleanMyData <- function(filepath = "UCI HAR Dataset") {
  # Step 1a: Read in both training and test data
  XData = readInXData(filepath)
  YData = readInYData(filepath)
  subjectData = readInSubjectData(filepath)
  
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
  write.table(finalData, file="cleanedData.txt", row.names=FALSE)
  #return (finalData);
  View(finalData)
  return("Data Cleaned and saved to 'cleanedData.txt'");
}

readInXData <- function(filepath){
  xFeatureNames <- read.table(file = "UCI HAR Dataset/features.txt")
  
  # Read in X Training Data
  xTrain <- read.table(paste(filepath,"train/X_train.txt",sep="/"), nrows=5)
  xTrain.classes <- lapply(xTrain, class)
  xTrain <- read.table(paste(filepath,"train/X_train.txt",sep="/"), colClasses=xTrain.classes)
  
  # Set X Column names
  colnames(xTrain) <- xFeatureNames[,2]
  
  # Read in X Test Data
  xTest <- read.table(paste(filepath,"test/X_test.txt",sep="/"), nrows=5)
  xTest.classes <- lapply(xTest, class)
  xTest <- read.table(paste(filepath,"test/X_test.txt",sep="/"), colClasses=xTest.classes)
  
  # Set X Column names
  colnames(xTest) <- xFeatureNames[,2]
  
  return (list(train = xTrain, test = xTest));
}

readInYData <- function(filepath) {
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
  return (list(train = yTrain, test = yTest));
}

readInSubjectData <- function(filepath) {
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
  return (list(train = sTrain, test = sTest));
}

#This function merges the data, both X to Y and training set to test set
mergeData <- function(x = list(), y = list(), s = list()) {
  xDataMerged <- rbind(x$train,x$test)
    
  yDataMerged <- rbind(y$train,y$test)
  sDataMerged <- rbind(s$train,s$test)
  
  allDataMerged <- cbind(sDataMerged,yDataMerged,xDataMerged)
  
  return (allDataMerged);
}

extractMeanStd <- function(x){
  # Look for columns with these in the names
  meanString <- "mean\\(\\)"
  stdString <- "std\\(\\)"
  x <- x[,grepl(meanString,names(x),ignore.case = TRUE) 
           | grepl(stdString,names(x),ignore.case = TRUE) 
           | grepl("Activity",names(x))
           | grepl("SubjectID",names(x))]
  
  return(x)
}

tidyVarNames <- function(x){
  colnames(x) <- gsub("\\-mean\\(\\)\\-", "Mean", colnames(x))
  colnames(x) <- gsub("\\-std\\(\\)\\-", "StandardDeviation", colnames(x))
  colnames(x) <- gsub("\\-mean\\(\\)", "Mean", colnames(x))
  colnames(x) <- gsub("\\-std\\(\\)", "StandardDeviation", colnames(x))
  colnames(x) <- gsub("^t","Time",colnames(x))
  colnames(x) <- gsub("^f","Frequency",colnames(x))
  colnames(x) <- gsub("[Aa]cc","Accelerometer",colnames(x))
  colnames(x) <- gsub("[Gg]yro","Gyroscope",colnames(x))
  colnames(x) <- gsub("[Mm]ag","Magnitude",colnames(x))
  return(x)
}

addActivityLabels <- function(x){
  x$Activity <- as.factor(x$Activity)
  myFactors <- read.table("UCI HAR Dataset/activity_labels.txt")
  levels(x$Activity) <- myFactors$V2
  
  return(x)
}

reshapeData <- function(x){
  library(reshape2)
  idNames = colnames(x)[1:2]
  varChoice = colnames(x) %in% idNames
  varNames = colnames(x)[!varChoice]

  meltedX <- melt(x,id=idNames, measure.vars = varNames)
  
  recastX <- dcast(meltedX, Activity + SubjectID ~ variable, mean)
  
  return(recastX)
}

