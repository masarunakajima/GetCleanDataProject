# GetCleanDataProject

In this project, I wrote a code to extract the mean and standard deviation of the data collected by\
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The repository includes the following files:

- README.md
- CodeBook.md : Describes the variables used
- run_analysis.R : The main analysis script

## Script

The script first requires dplyr packages.\
It first loads the train and test data sets.

1. Merges the training and the test sets to create one data set. \
The train and test datasets are merged and saved in variables `x` (data) and `y`(label).

2. Extracts only the measurements on the mean and standard deviation for each measurement.\
It first reads the the list of features and saves them to the variable `features_vec`. 
Then it creates a vector named `mask` which indicates the variable names containing 'mean' or 'std'.
The data set subset by `mask` is stored in `mean_std`.

3. Uses descriptive activity names to name the activities in the data set\
The activity labels are loaded and `y` is mutated to have a new column 'label'.

4. Appropriately labels the data set with descriptive variable names. \
The columns of `mean_std` are replaced by the corresponding variable names in `features_vec`

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.\
The suject ID information is loaded for the train and test dataset and merged. 
`aggregate` function is used to get the mean for each variable while indexing by activity type and subject id.
