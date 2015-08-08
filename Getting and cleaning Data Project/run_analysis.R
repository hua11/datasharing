# Getting_and_Cleaning_Data_Project 20150724

library(dplyr)
library(tidyr)

# Set working directory 
setwd("~/Desktop/Get_clean_data/project/UCI_HAR_Dataset")

# read file in R
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")


X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")


#TASK ONE: Merges the training and the test sets to create one data set

# Combine Objects by Rows 
XX <- rbind(X_test,X_train )

dim(XX)

#TASK TWO:Extracts only the measurements on the mean and standard deviation for each measurement. 

# search string 'mean()' and 'std()' index
idx <- grep("mean\\(\\)|std\\(\\)", features[,2])

# select the columns in XX data set
XX_MeanStd <- XX[,idx]
dim(XX_MeanStd)


#TASK THREE:Uses descriptive activity names to name the activities in the data set

# Combine activity lable by Rows 
act  <- rbind(y_test,y_train)

# change the column from "V" to "Activity"
names(act) <- "Activity"

# check if all unique activity code was 1 to 6
unique(act$Activity)

# change the class labels with their activity name
act$Activity = activity_labels[act$Activity, 2]

# check if all class labels are changed
unique(act$Activity)

# TASK FOUR:Appropriately labels the data set with descriptive variable names.

# edit measurement names
IDs <- features$V2[idx]
IDs <- gsub("\\(\\)","",IDs)
IDs <- gsub("-","\\.",IDs)
IDs <- gsub("mean","Mean",IDs)
IDs <- gsub("std","Std",IDs)


#labels the data set with descriptive variable names
names(XX_MeanStd) <- IDs


# TASK FIVE:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Combine objects by Rows 
subject <- rbind(subject_test,subject_train)
names(subject) <- "Subject"

# create a data frame by merge file ID of subject:'subject', activity lable:'act', measurement means and std: 'XX_MeanStd'.

df <- cbind(subject,act,XX_MeanStd)

df[1:3,1:5]

# create a wide form tidy data
TidyData.W <- df%>%
    group_by(Grp = factor(paste(df[,1], df[,2], sep='-'))) %>%
    select(3:68)%>%
    summarise_each(funs(mean))%>%
    separate(Grp,c("Subject", "Activity"), sep = "-")%>%
    arrange(Subject,Activity)

TidyData.W[1:3,1:5]


# create a narrow form tidy data
TidyData.N <- df%>%
    group_by(Grp = factor(paste(df[,1], df[,2], sep='-'))) %>%
    select(3:68)%>%
    summarise_each(funs(mean))%>%
    separate(Grp,c("Subject", "Activity"), sep = "-")%>%
    gather("Feature", "Value", -c(Subject,Activity))%>%
    arrange(Subject,Activity)


TidyData.L[1:5,1:4]


# export tidy data

if(!file.exists('output')){
        dir.create('output')
}

# write table
write.table(TidyData.W, "output/TidyData-W.txt", row.name=FALSE, sep ='\t')
write.table(TidyData.L, "output/TidyData-N.txt", row.name=FALSE,sep ='\t')

# infomation for data produce system
version



