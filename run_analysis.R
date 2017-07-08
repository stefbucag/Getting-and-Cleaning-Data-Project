#
# This script does the following
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Set working environment

setwd("/Users/martinstefannybucag/Documents/personal/Coursera/Course3-Cleaning-Data/")

# Reading general set
features        <- read.table("./UCI-HAR-Dataset/features.txt",header=FALSE)
activity_labels <- read.table("./UCI-HAR-Dataset/activity_labels.txt",header=FALSE)

# Reading Training Sets
subject_train   <- read.table("./UCI-HAR-Dataset/train/subject_train.txt", header=FALSE)
x_train         <- read.table("./UCI-HAR-Dataset/train/X_train.txt", header=FALSE)
y_train         <- read.table("./UCI-HAR-Dataset/train/y_train.txt", header=FALSE)

# Assign column names to the data above.
colnames(activity_labels) <- c("activityId","activityType")
colnames(subject_train)   <- "subId"
colnames(x_train) 		  <- features[,2]
colnames(y_train) 	      <- "activityId"

# Merges the training and test set to create one data set
training_data <- cbind(subject_train, x_train, y_train)

# Reading Test set
subject_test <- read.table("./UCI-HAR-Dataset/test/subject_test.txt")
x_test <- read.table("./UCI-HAR-Dataset/test/X_test.txt")
y_test <- read.table("./UCI-HAR-Dataset/test/y_test.txt")

# Assign column names.. same as for training data..
colnames(subject_test) <- "subId"
colnames(x_test) <- features[,2]
colnames(y_test) <- "activityId"

# Merges the test data
test_data <- cbind(subject_test, x_test, y_test)

# 1. Merge the training and the test sets to create one data set.
merged_data <- rbind(training_data, test_data)

# 2. Extract only the measurements on the mean and standard deviation for each measurement
data_mean_std <- merged_data[,grepl("mean|std|subject|activityId",colnames(merged_data))]

# 3. Uses descriptive activity names to name the activities in the data set
library(plyr)

data_mean_std <- join(data_mean_std, activity_labels, by = "activityId", match = "first")
data_mean_std <-data_mean_std[,-1]

# 4. Appropriately labels the data set with descriptive variable names.

#Remove parentheses
names(data_mean_std) <- gsub("\\(|\\)", "", names(data_mean_std), perl  = TRUE)

#correct syntax in names
names(data_mean_std) <- make.names(names(data_mean_std))

# Label the data sets
names(data_mean_std) <- gsub("Acc", "Acceleration", names(data_mean_std))
names(data_mean_std) <- gsub("^t", "Time", names(data_mean_std))
names(data_mean_std) <- gsub("^f", "Frequency", names(data_mean_std))
names(data_mean_std) <- gsub("BodyBody", "Body", names(data_mean_std))
names(data_mean_std) <- gsub("mean", "Mean", names(data_mean_std))
names(data_mean_std) <- gsub("std", "Std", names(data_mean_std))
names(data_mean_std) <- gsub("Freq", "Frequency", names(data_mean_std))
names(data_mean_std) <- gsub("Mag", "Magnitude", names(data_mean_std))

# 5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.


id_labels   = c("subject", "activityId", "activityType")
data_labels = setdiff(colnames(merged_data), id_labels)
melt_data   = melt(merged_data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

write.table(tidy_data, file = "./tidydata.txt")
