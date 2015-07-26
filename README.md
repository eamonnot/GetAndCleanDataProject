## Summary
This repository contains the files for the Get and Clean Data Project as part of the Data Science Specialisation on Coursera

* run_analysis.R
* codeBook.md
* README.md

## Creating the tidy data 
The data is processed and tidied by the RScript run_analysis.R. This file contains a main workflow function cleanTheData, which in turn calls a series of sub-functions to process the data correctly. How to start this process and the functions involved will now be described.

### Initial Setup
* Open R and set the working directory to the directory where the unzipped UCI HAR Dataset folder and run_analysis.R are located.  
* Next load run_analysis.R into R with > source('run_analysis.R')

### The Tidy Data Process
The processing is carried out by the function cleanTheData(). To begin the tidy data process you can run the following command:
* > tidyData = cleanTheData() 

You can specify a sub-folder that the UCI data is contained in, however by default the script uses "UCI HAR Dataset". The cleanTheData function writes the tidy dataset to file and returns it to the user as output. The process is described in detaili below.

#### Step 1: Read in and Merge the Data
The first set of functions called by cleanTheData() are:
* readInAndBindXData
* readInAndBindYData
* readInAndBindSubjectData
* mergeData

The three readInAndBind functions read in the the X, Y and Subject data from the train and test data sets and combines them using rbind() with the train dataset being placed on top of the test dataset. The raw data .feature names for the X data are also read in and applied to the data at this point.

The mergeData function takes the output from the three readInAndBind functions and combines them using a cbind().

#### Step 2: Extract Only the Mean & Std for Each Measurement
Next cleanTheData calls the function extractMeanStd(). This function takes the initial merged dataset and removes unwanted variables. Unwanted variables are any variables that are not related to mean or standard deviation of measurements. It does this by keeping only columns with "mean()" or "std()" in the column names. The Activity and SubjectID columns are also retained.

#### Step 3: Label Activities
The next step is to replace the Activity Codes found in the raw data with the correct descriptive activity names. This task is completed by the function, addActivityLabels(). It does this by reading in the activity names from activity_labels.txt. Next it converts the activity codes in the dataset to factors and sets the levels of these factors using the read in activity names.

#### Step 4: Appropriately Label the dataset variable names
The task of appropriately naming the variables in the dataset is completed by the function, tidyVarNames(). This funciton takes as input the merged dataset with untidy names. Variable names are made tidy using a series of gsub commands on the colnames of the dataset. The goal of this processing is to ensure that the variable names are human readable. This is done by:
1. Removing special characters such as ( ) or -
2. Removing abbreviation such as "std" or "mag", which become "Standard Deviation" and "Magnitude".
3. Removing abbreviation such that "f" or "t" at the start of a variable name becomes "Frequency" and "Time" respectively.
4. Removing abbreviation such that "acc" and "gyro" become "Accelerometer" and "Gyroscope" respecitvely

#### Step 5: Reshape the Data
The second to last task is to reshape the data such that the variables are averaged across activity and subject id. This is completed by the function, reshapeData. It loads the library "reshape2" to do this. Next it identifies the columns that will be used as IDs during the melting and recast, "Activity" and "SubjectID" with all remaining columns representing variables. Once this is done, the dataset is melted and then recast using dcast, with averaging applied. The rescast dataset is returned ready to be printed to file.

#### Step 6: Print to file
The final task of cleanTheData is to print the tidy dataset to file, which it does into a file called "tidiedData.txt". This file is written in the current working directory and is done using the write.table command. Finally, cleanTheData returns the tidied dataset to the user in case the user wishes to examine it during their current session.

## Codebook
The codebook for the tidy data is found in Codebook.md. This file contains a description of the contents of the tidy data file "tidiedData.txt" created by the process implemented in run_analysis.R and described above. This description includes:
* Information about the variables in the tidied data set
* Information on the units for each variable
* Information on the summary choices made during processing

## Tidy Data Principles
The following tidy data principles are adhered when creating the tidy dataset
* Each column corresponds to a single variable
* Each observation of a variable corresponds to a different row
* The top row in the dataset contains the variable names which are human readable
