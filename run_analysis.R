#2015 summer coursera "Getting and Cleaning Data" Project 2015-07-20
library(dplyr)
library(tidyr)

# first set working directory in the fold "UCI HAR Dataset"

# read files in R
features <- read.table("features.txt")

subject_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

subject_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

# TASK ONE: Merges the training and the test sets to create one data set

# first merge by columns for test set and training set
test <- cbind(y_test, X_test); dim(test)

train <- cbind(y_train, X_train); dim(train)

# merge data frames by rows for test and train
All <- rbind(train, test)
dim(All)


# TASK Four:Appropriately labels the data set with descriptive variable names

# the features row number equals X_test or X_train column number
nrow(features) == ncol(X_test); nrow(features) == ncol(X_train)

# add features as column name of data frame 'All'
# Sinec ID "y_train" and "y_test" were merged, so total column number should be ID + feature
# class of features[,2] is factor, so it need to be changed as a character 

class(features[,2])
names(All) <- c("activity",as.character(features[,2]))

# check if column names were changed
All[1:3,1:5]


# TASK two:Extracts only the measurements on the mean and standard deviation for each measurement.

# grepl() extract column name has 'activity', 'mean()', 'std()'
# mean() in grepl is 'mean\\(\\)'

idx <- grepl("activity|mean\\(\\)|std\\(\\)", names(All))

idx[1:5]

# file only mean and std for each each measurement, use idx to slect the columns 
Mean_Std <- All[,idx]

# compare Mean_Std and All
dim(Mean_Std)
dim(All)

# check if the column names of "Mean_Std" are correct for mean and std
names(Mean_Std)


# TASK THREE:Uses descriptive activity names to name the activities in the data set
MS <- Mean_Std

#Extract Unique Elements in MS$activity
unique(MS$activity)

MS$activity[MS$activity == 1] <-"WALKING" 
MS$activity[MS$activity == 2] <-"WALKING_UPSTAIRS"  
MS$activity[MS$activity == 3] <-"WALKING_DOWNSTAIRS"
MS$activity[MS$activity == 4] <-"SITTING"
MS$activity[MS$activity == 5] <-"STANDING"
MS$activity[MS$activity == 6] <-"LAYING"

# check if acticity number changed to words
unique(MS$activity)


# TASK FIVE: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

#All <- rbind(train, test)
# merge subject_train and subject_test by rows
subject <- rbind(subject_train,subject_test)

names(subject) <- "Subject"

dim(subject)
dim(MS)

#merge subject and MS by columns
New_MS <- cbind(subject, MS)

New_MS[1:3,1:5]

# wide form 
result <- New_MS %>%
        mutate(Group = paste(New_MS[,1],New_MS[,2],sep = ".")) %>%
        group_by(Group) %>%
        select(3:68) %>%
        summarise_each(funs(mean))%>%
        separate(Group, c('ID','ACT'), sep ="\\.") %>%
        arrange(as.numeric(ID),ACT)

dim(result)

write.table(result,"TidyData_WideForm.txt", row.name=FALSE, sep = "\t")
# Narrow form
result2 <- New_MS %>%
        mutate(Group = paste(New_MS[,1],New_MS[,2],sep = ".")) %>%
        group_by(Group) %>%
        select(3:68) %>%
        summarise_each(funs(mean))%>%
        gather(Activity,Value,-Group)%>%
        separate(Group, c('ID','ACT'), sep ="\\.") %>%
        arrange(ID,ACT)

write.table(result2,"TidyData_NarrowForm.txt", row.name=FALSE, sep = "\t")


