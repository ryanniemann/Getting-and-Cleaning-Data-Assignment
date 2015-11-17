#Getting-and-Cleaning-Data-Assignment


#Setting the working directory to "Temp"
setwd("C:/Temp")


#Installing packages required for the script
packages <- c("RCurl", "downloader", "data.table", "rapport", "tidyr")
sapply(packages, require, character.only=TRUE, quietly=TRUE)


#Downloading Dataset File 
#Check to see if the file is there, if not download it
if (!file.exists("UCI HAR Dataset")) { 
        dir.create("UCI HAR Dataset") 
        dataFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(dataFile, "getdata_projectfiles_UCI HAR Dataset.zip")
        unzip("./getdata_projectfiles_UCI HAR Dataset.zip") 
}


#Merging the training and the test sets to create one data set.
dataActivityTest <- read.table("./UCI HAR Dataset/test/Y_test.txt", header = FALSE)
dataActivityTrain <- read.table("./UCI HAR Dataset/train/Y_train.txt", header = FALSE)

dataSubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
dataSubjectTest  <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

dataFeaturesTest  <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
dataFeaturesTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)

dataActivity <- rbind(dataActivityTrain, dataActivityTest)
dataSubject  <- rbind(dataSubjectTrain, dataSubjectTest)
dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

names(dataSubject)<- c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table("./UCI HAR Dataset/features.txt", head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)


#Extracting only the measurements on the mean and standard deviation for each measurement
subdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
selectedNames <- c(as.character(subdataFeaturesNames), "subject", "activity" )
Data <- subset(Data,select=selectedNames) 


#Uses descriptive activity names to name the activities in the data set.



#Appropriately labels the data set with descriptive activity names.



#Creates a second, independent tidy data set with the average of each variable for each activity and each subject.