#CodeBook (tidy data)

This is a code book that describes the variables, the data, and any transformations or work that were performed to clean up the data

###The data source:

[Original data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


[link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphon es): A full description is available at the site where the data was obtained 


###Data Set Information


The experiments have been carried out with a group of **30** volunteers within an age bracket of 19-48 years. Each person performed six activities **(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)** wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the **training data** and 30% the **test data**. 

See original dataset 'features_info.txt' for more details. 

####The following files from original dataset were used for this analysis:
- 'features.txt': List of all (561) features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt' and 'test/subject_test.txt': Their descriptions are equivalent.Each row identifies the subject who performed the activity for each window sample. **Its range is from 1 to 30**.


###Manipulating data

**Need R package**

dplyr

tidyr

**There are 5 process steps:**

1. Merges the training and the test sets to create one data set.2. 
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive activity names. See below example
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

more details see run_analysis.R


**For example:**
Edited_Feature_Name  *vs.* Orignal_Feature_Name
```
-------------------------------------------------
Edited_Feature_Name       |  Orignal_Feature_Name
-------------------------------------------------
tBodyAcc.Mean.X           |  tBodyAcc-mean()-X
tBodyAcc.Std.X            |  tBodyAcc-std()-X
fBodyAcc.Mean.X           |  fBodyAcc-mean()-X
fBodyAcc.Mean.Y           |  fBodyAcc-mean()-Y
-------------------------------------------------
```
###Output tidy data variable

**Subject**: 
identifies the subjects, factor variable

**Activity**: 
activity name, character variable

**Features_IDs**:
Measurement Means, numeric variable

####Output two tidy data:
**wide form**: 
TidyData-W.txt (180 x 69)

**narrow form**: 
TidyData-N.txt (11880 x 4)

See [link](https://en.wikipedia.org/wiki/Wide_and_narrow_data) for more details:

###infomation for system

R version 3.2.0 (2015-04-16)

Mac OSX 10.9.4








