# Getting-and-Cleaning-Data-Assignment

###The R script called run_analysis.R does the following:  

Checks to see if the dataset file is downloaded, if not the script will download the dataset file. 

###Then: 

1.Merges the training and the test sets to create one data set.

2.Extracts only the measurements on the mean and standard deviation for each measurement. 

3.Uses descriptive activity names to name the activities in the data set

4.Appropriately labels the data set with descriptive variable names.

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Result: 

The script produces the final tidy dataset "tidydata.txt".  

###Packages: 
If needed, you can uncomment these lines (5 and 6) to check for the packages required to run the script. 

    #packages <- c("RCurl", "downloader", "data.table", "rapport", "tidyr", "plyr")
    #sapply(packages, require, character.only=TRUE, quietly=TRUE)

