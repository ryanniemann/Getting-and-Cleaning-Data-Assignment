#Getting-and-Cleaning-Data-Assignment


#Setting the working directory to "Temp"
#setwd("C:/Temp")


#Installing packages required for the script
#packages <- c("RCurl", "downloader", "data.table", "rapport", "tidyr", "plyr")
#sapply(packages, require, character.only=TRUE, quietly=TRUE)

This
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
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))

joinLabel <- rbind(dataActivityTrain,dataActivityTest)
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

names(dataSubject) <- "subject"
Data <- cbind(dataSubject, joinLabel, Data)


#Appropriately labels the data set with descriptive activity names.
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))


#Creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject.
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)
