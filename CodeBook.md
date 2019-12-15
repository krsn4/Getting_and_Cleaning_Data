---
title: "Code Book"
output: html_notebook
---

subject: subject id (1-30)

activity: activities (walking, walking upstairs, walking downstairs, sitting, standing, laying)


t: time, Acc=accelerometer, Gyro=gyroscope,

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag


For each of the above, mean() and std() values were chosen as feature variables in dataset2.

In the final subject-level and activity-level means, F_mean()_mean and F_std()_mean were calculate, where F is one of the features above.
