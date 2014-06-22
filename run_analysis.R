url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
name = "HAR.zip"
if(!file.exists(name)) #downloads only once
    download.file(url,name)
unzip(name)
dir = "UCI HAR Dataset/"
dataTestId <- read.table(paste(dir,"test/subject_test.txt",sep=""),col.names="ID")
dataTestActivity <- read.table(paste(dir,"test/y_test.txt",sep=""),col.names="Activity")

#descriptive variable names (requirement #4)
FeatureName <- scan(paste(dir,"features.txt",sep=""), what=character(),sep=" ")
evens <- seq(2,1122,by=2)
FeatureName <- FeatureName[evens] #throw away numbers by using only evens
dataTestMeasure <- read.table(paste(dir,"test/X_test.txt",sep=""),col.names=FeatureName)

#checks for substring of mean or std, or returns false if it isn't
meanOrStd <- function(x){
         if(grepl("mean",x)) return(TRUE)
         if(grepl("std",x)) return(TRUE)
         return(FALSE)
     }

#boolean vector for tidying data
check <- sapply(FeatureName,meanOrStd)

dataTestMeasure <- dataTestMeasure[,check]

dataTest <- cbind(dataTestId,dataTestActivity,dataTestMeasure)

#redo for train

dataTrainId <- read.table(paste(dir,"train/subject_train.txt",sep=""),col.names="ID")
dataTrainActivity <- read.table(paste(dir,"train/y_train.txt",sep=""),col.names="Activity")
dataTrainMeasure <- read.table(paste(dir,"train/X_train.txt",sep=""),col.names=FeatureName)
dataTrainMeasure <- dataTrainMeasure[,check]
dataTrain <- cbind(dataTrainId,dataTrainActivity,dataTrainMeasure)

#final combine

dataTidy <- rbind(dataTest,dataTrain) #this is the first data frame we want

#introduce descriptive activity labels (requirement #3)

ActivityName <- scan(paste(dir,"activity_labels.txt",sep=""), what=character(),sep=" ")
ActivityName <- ActivityName[seq(2,12,by=2)] #evens
dataTidy$Activity <- ActivityName[dataTidy$Activity]

#make the secondary data frame

library(reshape2)

dataMelt <- melt(dataTidy,id=c("ID","Activity"))
dataMelt <- dcast(dataMelt, ID + Activity ~ variable, mean) #the data frames with averages

write.table(dataMelt,"tidyTable.txt",row.names=FALSE)