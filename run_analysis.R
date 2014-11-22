## Grab raw data

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "wearabledata.zip", method = "curl");
unzip("wearabledata.zip");
file.remove("wearabledata.zip");

### Grab universal variables
experimentLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE);
columnLabels <- read.table("UCI HAR Dataset/features.txt", header = FALSE);

### Function to get subjects, activity, and results together
getCleanTable <- function(groupName) {
	### Here is where step 2 is handled: Extracts only the measurements on the mean and standard deviation for each measurement.
	filterResults <- function(results) {
		wantedColumns <- grepl("-mean|-std", names(results));
		results[,wantedColumns];
	}

	subjects <- read.table(paste("UCI HAR Dataset/", groupName, "/subject_", groupName, ".txt", sep = ""), header = FALSE, col.names = "Subject");
	activity <- read.table(paste("UCI HAR Dataset/", groupName, "/y_", groupName, ".txt", sep = ""), header = FALSE, col.names = "Activity");
	results <- read.table(paste("UCI HAR Dataset/", groupName, "/X_", groupName, ".txt", sep = ""), header = FALSE);

	### Here is where step 4 is handled: Appropriately labels the data set with descriptive variable names.
	### Step 2 is also called here
	colnames(results) <- as.character(columnLabels[,2]);
	results <- filterResults(results);

	### Here is where step 3 is handled: Uses descriptive activity names to name the activities in the data set
	activity <- factor(activity[,1]);
	levels(activity) <- as.character(experimentLabels[,2]);

	cbind(subjects,activity,results);
}

### Grab groups and merge them
testGroup <- getCleanTable("test");
trainGroup <- getCleanTable("train");

## This is step 1 of assignment: Merges the training and the test sets to create one data set.
combinedGroup <- rbind(testGroup,trainGroup)

## This is step 5 of assignment: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
getMeany <- function(combinedGroup) {
	sortedMeans <- data.frame();
	rowNumbers <- ncol(combinedGroup);
	
	for(subject in unique(combinedGroup$Subject)) {
		values <- data.frame()
		for(activity2 in unique(combinedGroup$activity)) {
			values <- rbind(colMeans(subset(combinedGroup, Subject == subject & activity == activity2)[,3:rowNumbers]))
			values <- cbind(activity2, values)
		}
		values <- cbind(subject, values);
		sortedMeans <- rbind(sortedMeans, values);
	}

	colnames(sortedMeans) <- names(combinedGroup);
	final <- final[order(subject, activity)];
	sortedMeans;
}

tidySubjectActivity <- getMeany(combinedGroup);