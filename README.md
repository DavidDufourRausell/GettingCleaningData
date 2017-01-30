## Getting and cleaning data

In this assignment we are provided with a smartphone kinetic activities measurements, and we are required to download a data set, perform operations to make it tidy, select some variables, and create a second data set in with means for each combination of subject and activity. The following is an explanation of the steps taken in the run_analysis.R script to get to the result.

1. Since the names of the variables are stored in “features.txt”, this files is read and its contents stores in feature_names.

2. The file “activity_labels.txt” is also read and stored in the activity_labels variable. It has two columns, one for the numeric labels and other for the names of the activities.

3. The “X_test.txt”, “testY.txt” and “subject_test.txt” files are read and joined together by column to conform the test data set.

4. Same thing is done with the training data set.

5. Both data sets are joined by row in allData.

6. Then only the columns that contain mean() or std() are selected, and the resulting ones are joined column-wise to the subject and activity_label columns again, in tempData.

7. Then the temp data set is merged with the activity labels, so in each row there is the proper name for each activity.

8. The column with the activity numeric label is eliminated.

9. The final temp data set is grouped by activity label and by subject, before the grouped data set is used to calculate the mean of each variable.

10. Finally, the results are written in the “results.txt” file.