---
title: "README"
author: "Eamonn O'Toole"
date: "25/07/2015"
---

# Summary
This repository contains the files for the Get and Clean Data Project as part of the Data Science Specialisation on Coursera

* run_analysis.R
* codeBook.md
* README.md

# Creating the tidy data 
The data is processed and tidied by the RScript run_analysis.R. This file contains a main workflow function cleanTheData, which in turn calls a series of sub-functions to process the data correctly. How to start this process and the functions involved will now be described.

## Initial Setup
* Open R and set the working directory to the directory where the unzipped UCI HAR Dataset folder and run_analysis.R are located.  
* Next load run_analysis.R into R source('run_analysis.R')

## The Tidy Data Process
* To begin the tidy data process you run cleanTheData(). You can specify a sub-folder that the UCI data is contained in, however by default the script uses "UCI HAR Dataset".

### Step 1: Read in and Merge the Data


# Codebook
The codebook for the tidy data is found in Codebook.md. This file contains a description of the contents of the tidy data file "tidiedData.txt" created by the process implemented in run_analysis.R and described above. This description includes:
* Information about the variables in the tidied data set
* Information on the units for each variable
* Information on the summary choices made during processing

# Tidy Data Principles
The following tidy data principles are adhered when creating the tidy dataset
* Each column corresponds to a single variable
* Each observation of a variable corresponds to a different row
* The top row in the dataset contains the variable names which are human readable
