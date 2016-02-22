library(plyr)
library(dplyr)
library(tidyr)

#
# This R script file will do the following:
# 1. Load a set of UCI HAR training and test data files.
# 2. Create a tidy data file and in-memory data frame containing the mean values for 
#    the mean and standard deviation observations for a specific subset of the 
#    measurements supplied in the raw data files.
# 
# Refer to the CodeBook.md and README.md files for this script for complete details.
#
# This script was created to fulfill the course project assignment of the Getting and 
# Cleaning Data course of the Coursera.org Data Science specialization.
#
# Author: Jeff Spoelstra
# Version: 1.0 - February 2016
#

# This function loads a set of UCI HAR Dataset tables, creating a data frame specifically 
# formatted for use by the main code of this script. NOTE: this function relys on variables
# mnames, subvars, and actnames created within the environment it is called from. These
# variables must be correctly set prior to calling this function.

readHARData <- function(x_fname, y_fname, s_fname) {
    # Read the entire measurement table. Set the column names using the preloaded 
    # feature names list.
    x_dat<-read.table(x_fname, col.names=mnames, check.names=FALSE)
    
    # Pull out the specific variables/columns of interest.
    x_dat<-x_dat[,subvars]
    
    # Read the activities data. Change the activity indices to long activity names 
    # using the preloaded activity names table.
    y_dat<-read.table(y_fname, col.names="aid")
    y_dat<-transmute(y_dat, activity=actnames[aid,"adesc"])
    
    # Read the subjects data.
    s_dat<-read.table(s_fname, col.names="subject")
    
    # Column-wise combine the actitity, subject, and measurement data and return 
    # the result.
    cbind(y_dat, s_dat, x_dat)
}


#
# Start of the main code of this script.
# 

# Load the "feature" (measurement) names for the measurement data.
print("Loading data feature names and activity names...")

mnames<-read.table("features.txt", stringsAsFactors = FALSE)
mnames<-mnames[,2]     # strip off the index column

# Create a list of only the variable names for the columns containing mean and std data.
subvars<-grep("-(std|mean)\\(\\)", mnames, value=TRUE)

# Strip the "()" characters in both name sets.
mnames<-sub("\\(\\)", "", mnames)
subvars<-sub("\\(\\)", "", subvars)

# Load the activity names data.
actnames<-read.table("activity_labels.txt", col.names=c("aid","adesc"), stringsAsFactors=FALSE)

# Load the training data files.
print("Loading training data...")
train_dat<-readHARData("./train/X_train.txt", "./train/y_train.txt", "./train/subject_train.txt")

# Loads the test data files.
print("Loading test data...")
test_dat<-readHARData("./test/X_test.txt", "./test/y_test.txt", "./test/subject_test.txt")

# Append the train and test data tables then sort to regroup all of the observations by
# activity and subject.
print("Collating and summarizing the data...")
all_dat<-rbind(test_dat, train_dat) %>%
    arrange(activity, subject)

# Determine the mean of each measurement column grouped by activity and subject.
mean_dat<-aggregate(x=all_dat[,subvars],by=list(activity=all_dat$activity, subject=all_dat$subject),mean)

# Tidy the data by gathering all the measurement columns into one column and then
# splitting that back out based on the measurement type, stat type, and axis components
# of the column name. 
# Then, spread the stat column back into separate columns as that data represents the 
# dependent variables of the independent observation ID variables (activity, subject, 
# measure, and axis).
# Finally, sort the data based on the observation ID variables and then rename the mean 
# and std columns to reflect that they are now the mean values of the original stat 
# values.
print("Tidying the results...")
HARresults<-gather(mean_dat, meas, value, -activity, -subject) %>%
    separate(meas, c("meas","stat","axis"), sep="-", fill="right") %>%
    spread(stat, value) %>%
    arrange(activity, subject, meas, axis) %>%
    rename(aggmean=mean, meanstd=std)

# Save the results on disk.
write.table(HARresults, "HARresults.txt", col.names=TRUE, row.names=FALSE)

# Clean up all intermediate variables, leaving only the final HARresults data frame in
# the environment.
rm(readHARData)
rm(test_dat, train_dat, all_dat, mean_dat)
rm(mnames, subvars, actnames)
