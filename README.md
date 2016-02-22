# README for run\_analysis.R version 1.0

February 2016

Jeff Spoelstra - jeff@jeffspoelstra.com


This file describes how to use the run\_analysis.R script. Refer to the CodeBook.md file for details on the specific processing performed by the script and for details regarding the input and output data.

This script was created to fulfill the course project assignment of the Getting and Cleaning Data course of the Coursera.org Data Science specialization.

##Environment Setup
This script requires a typical R installation along with the plyr, dplyr, and tidyr packages (along with their prerequisite packages). These packages will be loaded by this script if they have not already been loaded before the script is run. It will not, however, install the packages if they are not already installed.

This script does not rely on any specific environment configuration.

This script was created and testing in a Windows environment. It's usefulness in any other environment is not guaranteed.

##Data Setup
The raw data used by this script is the Human Activity Recognition Using Smartphones Dataset Version 1.0 (donation date 12/10/2012) available from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) web site.

The raw data must be downloaded and unpacked into the same working directory as the script. The raw data is organized into sub-directories which do NOT need to be flattened. This script will automatically traverse the directories to find the data.

##Running the script
1. Set the R working directory to the directory containing the run\_analysis.R  script (and also is the root directory of the raw data).

2. Load and run the script using the following command.

    source("run\_analysis.R")

3. During it's execution, the script will print a sequence of progress messages to the console window.
4. The R command prompt will return when the script has finished.

##Script Results
When the script has finished, there will be a file named HARresults.txt in the working directory. It will contain the final tidy processed data from the script. In the R environment, there will also be a variable named HARresults which is the in-memory form of the same results. Refer to the CodeBook.md file for details on the format of the processed data and how to read the output data file.

##License
This script is distributed AS-IS and no responsibility implied or explicit can be addressed to the author.

The author claims no responsibility nor ownership regarding the raw data, and makes no warranty implied or explicit regarding the validity and usability of it.
