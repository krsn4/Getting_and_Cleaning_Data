# Getting_and_Cleaning_Data

*The code script run_analysis.R downloads the necessary data set from the sepcified site to local disk, and unzips it.

*It then merges train and test data sets, converts subject and activity variables as factors, then moves them to the left most columns,
followed by other feature variable columns.

*It then renames the default non-descriptive column names by the descriptive ones found in features.txt.

*It then transforms the activity id numbers by the corresponding activity names, using activity_labels.txt. 

*It then searches for the columns with mean() or std() values in them and extracts them. The result is the tidy dataset2, attached.

*It then calculates subject-level means of each variable, as well as activity-level means.

*The three datasets are saved as csv files in ./GCData.

*CodeBook.md is the code book file giving varaiable name descriptions and types.
