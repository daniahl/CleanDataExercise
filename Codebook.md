# Code Book

## Original data
The original activity recognition data set is available here:

* data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* code book: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Modifications
The original data is split up in train and test sets. These are merged, and the
columns are named according to names in the file features.txt.

Beside the many sensor data columns, there are three additional ones:

* subject: subject number
* activity: factor with names of activities according to activity_labels.txt
* source: whether a row comes from the train or the test set.

## Output
Two data frames are output from the script:

* data: contains the merged and cleaned original data
* mean_data: contains means for all columns grouped by subject and activity.
