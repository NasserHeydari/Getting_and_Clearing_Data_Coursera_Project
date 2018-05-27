dir <- "............./UCI HAR Dataset"   #please provide the directory to "UCI HAR Dataset" 

features_path <- paste(dir,"/features.txt",sep="") 

x_train_path <- paste(dir,"/train","/X_train.txt",sep ="")

y_train_path <- paste(dir,"/train/y_train.txt",sep="")

subject_train_path <- paste(dir,"/train","/subject_train.txt",sep="")

x_test_path <- paste(dir,"/test","/X_test.txt",sep="")

y_test_path <- paste(dir,"/test","/y_test.txt",sep="")

subject_test_path <- paste(dir,"/test","/subject_test.txt",sep="")

activity_labels <- paste(dir,"/activity_labels.txt",sep="")

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

Data <- rbind(test,train)    #Train and test dataset together

#*******************Only the measurements on the mean and standard deviation***********************************

mean_std_features <- Data[ , grepl( "subject|activity|mean|std" , names( Data ) ) ]

#******************Descriptive activity names to name the activities in the data set***************************

activity_labels <- read.delim(activity_labels, header = FALSE, sep ="",dec=".")  #

for(i in 1: nrow(activity_labels)){mean_std_features$activity <-gsub(activity_labels[i,1],activity_labels[i,2],mean_std_features$activity) }   # this is for variable of mean and standard deviation


#******************Average of each variable for each activity and each subject***************************

mean_data_by_group <- aggregate(mean_std_features[, 3:ncol(mean_std_features)], list(mean_std_features$activity,mean_std_features$subject), mean)

colnames(mean_data_by_group)[which(names(mean_data_by_group) == "Group.1")] <- "activity"

colnames(mean_data_by_group)[which(names(mean_data_by_group) == "Group.2")] <- "subject"

write.table(mean_data_by_group,"Final.txt",row.name=FALSE)

