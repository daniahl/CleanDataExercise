# This script first gets the source data, then creates two data frames (tibbles) according to the exercise:
# * data: contains the merged trian and test data
# * mean_data: contains grouped means of the variables
#
# Finally, it saves mean_data to a text file.

# download data if not already available
if (!file.exists("data.zip")) download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="data.zip", method="curl")
if (!file.exists("UCI HAR Dataset")) unzip("data.zip")

# read features and activity labels
features <- read_table(file.path("UCI HAR Dataset", "features.txt"), col_names=F) %>% pull(2)
activity_labels <- read_table(file.path("UCI HAR Dataset", "activity_labels.txt"), col_names=F) %>% pull(2)

# read training data
subject_train <- read_table(file.path("UCI HAR Dataset", "train", "subject_train.txt"), col_names="subject")
X_train <- read_table(file.path("UCI HAR Dataset", "train", "X_train.txt"), col_names=features)
y_train <- read_table(file.path("UCI HAR Dataset", "train", "y_train.txt"), col_names="activity", col_types="f")
train <- bind_cols(subject_train,X_train, y_train) %>% mutate(source="train")

# read test data
subject_test <- read_table(file.path("UCI HAR Dataset", "test", "subject_test.txt"), col_names="subject")
X_test <- read_table(file.path("UCI HAR Dataset", "test", "X_test.txt"), col_names=features)
y_test <- read_table(file.path("UCI HAR Dataset", "test", "y_test.txt"), col_names="activity", col_types="f")
test <- bind_cols(subject_test,X_test, y_test) %>% mutate(source="test")

# merge data and select only variables of interest
data <- bind_rows(train, test) %>% select(subject, activity, source, contains("mean()"), contains("std()"))

# code activity factor as names
levels(data$activity) <- activity_labels

# create grouped means data frame
mean_data <- data %>% group_by(subject, activity) %>% summarize(across(-source, ~ mean(.x, na.rm=T)))

# save mean_data
write.table(mean_data, file="mean_data.txt", row.names = FALSE)
