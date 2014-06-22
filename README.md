### Getting and Cleaning Data Course Project

Source data and information: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


This repo includes a script which takes the Human Activity Recognition Using Smartphones data set found in the above link and creates a tidy data frame from the data given.

The run_analysis.R file has two data frames taking data from multiple files from the source. Firstly, it creates a data frame called "dataTidy" with every recorded entry for tests and trials, which can be further manipulated in R. It also has another data frame called "dataMelt" which takes the averages of the measurements for every person and activity measured, and also exports a .txt file named "tidyTable" with this data.

####Using the script "run_analysis.R"

Source this into R and it should download and create the data frames and text file into your working directory.

This uses the library reshape2 so using the command

install.packages("reshape2")

may be necessary.

####How the script works

First this downloads the raw data from the source into the working directory

It saves a vector by cleaning the names given by features.txt. The function meanOrStd is used to determine if the measurement is a mean or standard deviation to be retained in the final data frame, the variable check is a boolean vector to choose which columns are needed

Then it creates a data frame for the person identifier (dataTestId), activity identifier (dataTestActivity), and measurements (dataTestMeasure, which uses the vector FeaturedName to name the values). The measurements are then reduced using the "check" vector. Finally, the 3 vectors are combined using cbind so the dataframe has all the columns wanted.

This process is repeated for the Train folder. Then, both the test and train data are combined using rbind, this gives the first data frame.

After this is done, the the activity identifiers are transformed into descriptors using the activity_labels.txt file. At this point the "dataTidy" dataframe is ready to be used.


The reshape2 library is loaded to create the second data frame.

This melts the data by the identifier and activity, which will be reshaped by finding the mean of the variables and produce the second table.

This second table is then exported by the script.