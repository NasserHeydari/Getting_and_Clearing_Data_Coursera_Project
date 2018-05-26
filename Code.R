features_path <- "...../features.txt"

x_train_path <- "..../X_train.txt"

y_train_path <- ".../y_train.txt"

subject_train_path <- "..../subject_train.txt"

x_test_path <- "..../X_test.txt"

y_test_path <- "..../y_test.txt"

subject_test_path <- "..../subject_test.txt"

activity_labels <- ".../activity_labels.txt"

#*********************************************************************************************

features <- read.delim(features_path, header = FALSE, sep ="")  

cnames <- t(as.data.frame(features$V2))

#***********************************************Tiday Train Data************************************************

train_x <- read.delim(x_train_path, header = FALSE, sep ="",dec=".")

train_y <- read.delim(y_train_path, header = FALSE, sep ="",dec=".")

subject_train <- read.delim(subject_train_path, header = FALSE, sep ="",dec=".")

train <- cbind(subject_train,train_y, train_x)

colnames(train) <- c("subject","activity",cnames)

#***********************************************Tiday Test Data**************************************************

test_x <- read.delim(x_test_path , header = FALSE, sep ="",dec=".")

test_y <- read.delim(y_test_path, header = FALSE, sep ="",dec=".")

subject_test <- read.delim(subject_test_path, header = FALSE, sep ="",dec=".")

test <- cbind(subject_test,test_y, test_x)

colnames(test) <- c("subject","activity",cnames)


#************************Merges the training and the test sets to create one data set*************************

Data <- rbind(test,train)

#*******************Only the measurements on the mean and standard deviation***********************************

mean_features <- Data[ , grepl( "mean" , names( Data ) ) ]

std_features <- Data[ , grepl( "std" , names( Data ) ) ]

mean_std_features <- cbind(Data$subject,Data$activity,mean_features,std_features)


#******************Descriptive activity names to name the activities in the data set***************************

activity_labels <- read.delim(activity_labels, header = FALSE, sep ="",dec=".")  #

for(i in 1: nrow(activity_labels)){Data$activity <-gsub(activity_labels[i,1],activity_labels[i,2],Data$activity) }


#******************Average of each variable for each activity and each subject***************************

mean_data_by_group <- aggregate(Data[, 3:ncol(Data)], list(Data$activity,Data$subject), mean)