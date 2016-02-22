# Code book for run\_analysis.R version 1.0

February 2016

Jeff Spoelstra - jeff@jeffspoelstra.com


This code book applies to the run_analysis.R script created to fulfill the course project assignment of the Getting and Cleaning Data course of the Coursera.org Data Science specialization. It describes the raw data, processed data, and transformation process applied to produce the processed data.

The raw data and the requirements for the processed data were provided as part of the above mentioned course.

## Study Design
This section describes the algorithm of the run\_analysis.R script to process the raw data to produce the end results. Refer to the README.txt file accompanying this code book for details on how to run the script.

###Step 1: Load descriptive data
The data for mapping activity indicators to descriptive labels and for labeling the "features" (hereafter referred to as measurements) in the measurement files is loaded from the root-level data files. 

###Step 2: Read and subset the test and train measurement data
The raw data is separated into two sets: one set referred to as the "test" data and the other as the "training" (abbreviated as "train") data. The measurement data collected for each is the same, and the files containing it are formatted in the same way. Refer to the README.txt file for the raw data for details (see the Code Book section below).

For both the test and train data, the measurement, activity, and subject files are read into memory. These three types of data are read from three separate files.

Only the mean and standard deviation data is desired - comprising only 66 of the total 561 measurements read. These measurements are identified by "mean()" and "std()", respectively, in the measurement labels.

The desired measurements are extracted out of the data read and then column-wise combined with the activity list (after it has been converted to text labels rather than numerical indices) and the subjects list to produce a single table with all the desired data.

###Step 3: Combine the test and train data
The test and train data are row-wise appended and then sorted by activity and subject to group together all of the rows with identical values for those variables.

###Step 4: Aggregate the measurements by activity and subject
For each unique combination of activity and subject, each measurement data column is aggregated/summarized by computing the mean of the measurement values for that particular activity-subject pair. The result is a much smaller table with one row for each unique activity-subject pair and with the computed mean values replacing the raw data in the measurement columns.

###Step 5: Tidy the data to produce the final results
The result of step #4 is a very wide table that is not very conducive to further analysis because some of the useful variable information is stored in the measurement column labels. For example, the axis of motion variable is recorded as "-X", "-Y", or "-Z" at the end of many measurement names. Doing so makes it difficult to set up further data processing/analysis based on subsets/groups of measurements and axes as that information cannot be easily extracted without manipulating measurement names.

To tidy the data, the measurement names are melted into two columns, one containing the true measurement type (ex, "fBodyAcc") and the other identifying the axis of motion ("X", "Y", or "Z"). Some measurements in the raw data are not specific to an axis of motion, and will have a corresponding NA value in the axis column. Adding NAs to the data is generally not desired, but in this case NA composes a small percentage of the data. The upside of having greater searchability of the data overcomes the downside of having NAs.

The aggregated means for the raw mean and standard deviation columns exist as separate columns in the results as they represent dependent observation data based upon the independent observation identifiers (activity + subject + measurement + axis).

The result is tidy data that is narrow and tall versus wide and short. Without a specific purpose for the use of the tidy data, it is arguable which is best in this case. This script opts for the narrow approach because of the greater ease of future sorting and sub-setting the data using simple tools for any further processing of the data.

###Step 6: Save the results and cleanup the environment
In the final step, the tidy processed data is saved to disk. The in-memory table is retained in the R environment in the event that further processing of it will happen immediately by other scripts or manually entered commands. All other intermediate variables/resources used in the processing sequence are deleted in order to free the memory.

## Code Book
### Description of the raw data
The raw data used by this script is the Human Activity Recognition Using Smartphones Dataset Version 1.0 (donation date 12/10/2012) available from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) web site.

**NOTE:** The raw data is not provided with the script as it is readily available from the UCI web site.

To avoid the need for downloading the raw data file set to understand the results of the run\_analysis.R script, the full text of the README.txt file provided with the raw data file set is reproduced below. This information was copied in whole rather than being edited in any way to avoid the possibility of introducing errors, inaccuracies, or misunderstandings with regard to the raw data.

**NOTE:** It is recommended that the README.txt file be obtained directly from the UCI web site as the only way to assure correct interpretation of the raw data as it is unknown if the information will change over time. The README.txt contents available at the time the run\_analysis.R script was created are reproduced below solely for convenience. 

#####_Beginning of README.txt_

Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features\_info.txt' for more details. 

**For each record it is provided:**

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

**The dataset includes the following files:**

- 'README.txt'

- 'features\_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity\_labels.txt': Links the class labels with their activity name.

- 'train/X\_train.txt': Training set.

- 'train/y\_train.txt': Training labels.

- 'test/X\_test.txt': Test set.

- 'test/y\_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject\_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total\_acc\_x\_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total\_ac\c\_x\_train.txt' and 'total\_acc\_z\_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body\_acc\_x\_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body\_gyro\_x\_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

**Notes:**

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

**License:**

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

#####_End of README.txt_


### Description of the processed data
The following describes the processed data results from the run\_analysis.R script. The data is available in the file HARresults.txt, an example of which is provided with the script.

The data can be read and viewed using the following R commands.

    df <- read.table(filepath, header=TRUE)
    View(df)

The processed data contains one row for each unique combination of test activity, test subject, measurement type, and measurement axis in the raw data. Using version 1.0 of the raw data file set and version 1.0 of run_analysis.R resulted in 5,940 rows of data.

Each data row comprises six columns that identify the independent variables and the generated dependent variables. See the data definitions below.

The processed data is in tidy form to allow for greatest flexibility in further processing and analysis. Refer to the Study Design section for details on how the raw data is processed into tidy form.

####Processed data column definitions
**activity** (independent - categorical - string) Labels for the tested activities. It will be one of the following values:

- WALKING
- WALKING\_UPSTAIRS
- WALKING\_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

**subject** (independent - categorical - integer) Integer values from 1 to 30 representing a unique ID value of an anonymous human test subject. No mapping of subject ID to any identifying information for a subject is provided.

**meas** (independent - categorical - string) Labels for the subset of measurement values extracted from the full set of measurements provided in the raw data files. It will be one of the following values:

- fBodyAcc
- fBodyAccJerk
- fBodyAccMag
- fBodyBodyAccJerkMag 
- fBodyBodyGyroJerkMag
- fBodyBodyGyroMag
- fBodyGyro
- tBodyAcc            
- tBodyAccJerk
- tBodyAccJerkMag
- tBodyAccMag
- tBodyGyro           
- tBodyGyroJerk
- tBodyGyroJerkMag
- tBodyGyroMag
- tGravityAcc         
- tGravityAccMag

**axis** (independent - categorical - string) The specific axis of movement measured. It will be one of the following values:

- X
- Y
- Z
- NA (if the measurement is not specific to an axis)

**aggmean** (dependent - continuous - numeric) The aggregated mean for the group of mean values in the raw data specific to a unique combination of activity, subject, meas, and axis. Example: the mean of all the mean values in the raw data for the tBodyAcc measurements along the X axis produced by the WALKING activity of subject #1.

**meanstd** (dependent - continuous - numeric) The aggregated mean value of all the standard deviation values in the raw data for each unique combination of activity, subject, meas, and axis. Example: the mean of all the standard deviation values in the raw data for the tBodyAcc measurements along the X axis produced by the WALKING activity of subject #1.
