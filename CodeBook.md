# Information on the variables represented in the dataset

## The UCI HAR Dataset

The UCI HAR Dataset has a number of measurements in regards to time, frequency, and motion type.
In addition, it separated the 30 subjects into train and test groups.

## Processed Data

The final document, tidySubjectActivity.txt, has done the following to the UCI HAR Dataset:

* Merged the train and test groups
* Collated only the mean and standard deviation of the measurements, leaving all other values out
* Taken the mean of each subject's trials for each activity
	* Effectively, this means we have taken the "mean of the mean" for each measurement, as well as the "mean of the std"
	* Example: Subject 1's WALKING trials' measurements have been averaged into a single row

The final result is a document with 79 measurements.
The first two columns are the subject's ID (number) and the activity performed.
The 79 remaining columns are named using shorthand:

* t or f: time or frequency measurement
* Body
* Acc or Gyro: indicating the measuring agent, accelerometer or gyroscope
* (optional) Mag or Jerk: *could not find; possibly movement type*
* mean or std: indicating if the measurement is the mean or std
* (optional) X,Y, or Z: Indicating axis; if absent, overall