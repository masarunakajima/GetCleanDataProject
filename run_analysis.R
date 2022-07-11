#Assume that the working directory contains the directory 'UCI HAR Dataset'
library(dplyr)



# read the train and test files 
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("Activity"))
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("Activity"))


#1. Merges the training and the test sets to create one data set.
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("UCI HAR Dataset/features.txt")
features_vec <- features$V2
mask <- grepl("mean", features_vec)|grepl("std", features_vec)
mean_std <- x[,mask]

#3. Uses descriptive activity names to name the activities in the data set
# Get features
act_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
act_map <- factor(act_labels$V2)
y <- mutate(y, label=act_map[Activity])
#x$label <- y$label

#4. Appropriately labels the data set with descriptive variable names. 
names(mean_std) <- features_vec[mask]

#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
sub <- rbind(sub_train, sub_test)
Subject <- sub$V1
Activity <- y$label
act_sub_mean <- aggregate(.~Activity+Subject, mean_std, mean)

