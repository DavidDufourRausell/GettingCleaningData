########################################
#                                      #
# Getting and cleaning data assignment #
# David Dufour Rausell                 #
# 2017/01/29                           #
#                                      #
########################################

library(dplyr)

#Get the names of the features
features_names <- read.table(file = 'features.txt', header = FALSE, stringsAsFactors = FALSE)
features_names <- features_names[,2]

#Get the correspondence between the number label of each activity and its name value
activity_labels <- read.table(file = './activity_labels.txt', stringsAsFactors = FALSE)
names(activity_labels) <- c("activity_label", "labels")

#Get and organize the test set
X_test <- read.table(file = './test/X_test.txt', header = FALSE)
names(X_test) <- features_names
testY <- read.table(file = './test/y_test.txt', header = FALSE, col.names = "activity_label")
subject_test <- read.table(file = './test/subject_test.txt', header = FALSE, col.names = "subject")
test <- cbind(subject_test, X_test, testY)

#Get and organize the training set
X_train <- read.table(file = './train/X_train.txt', header = FALSE)
names(X_train) <- features_names
trainY <- read.table(file = './train/y_train.txt', header = FALSE, col.names = "activity_label")
subject_train <- read.table(file = './train/subject_train.txt', header = FALSE, col.names = "subject")
train <- cbind(subject_train, X_train, trainY)

#Join test and train datasets
allData <- rbind(train, test)

#Create a temporary data set to extract only the variables that are mean or std
tempData <- allData[,grep('mean\\(|std\\(',names(allData))]

#Recover the subject and activity label data
tempData <- cbind("subject" = allData[,1], tempData, "activity_label" = allData[,"activity_label"])

#Merge this temp data set with the activity labels, so the activities have proper names
tempData <- merge(tempData, activity_labels, by="activity_label")

#Get rid of the redundant numeric label column and rename the label column to a proper name
tempData <- tempData[,2:length(names(tempData))] %>% rename(activity_label = labels)

#Group the data by activity and subject, and apply a mean to the rest of the columns
results <- tempData %>% group_by(activity_label, subject) %>% summarise_each(funs(mean), 2:67)

#Write the results
write.table(results, file = "results.txt", row.name=FALSE)
