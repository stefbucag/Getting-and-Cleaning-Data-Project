# CodeBook

A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md

### Data
- Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


### Variables
* General Data Sets
  - features  - Features data
  - activity_labels - Activity labels data

* Reading Training Sets
  - subject_train  - Subject Training Data Set
  - x_train        - X Training Data Set
  - y_train        - Y Training Data Set
  - training_data  - Combined subject, X and Y Training Data Sets

* Reading Test set
  - subject_test - Subject Test Set
  - x_test       - X Test Set
  - y_test       - Y Test Set
  
### Data Transformation
1. Read each data sets as per variables above.
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive activity names.
6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
