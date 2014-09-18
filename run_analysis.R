#Loads dependencies
library(plyr)

#Reads all the data files
features<-read.table("data/UCI HAR Dataset/features.txt")
subject_train<-read.table("data/UCI HAR Dataset/train/subject_train.txt")
subject_xtrain<-read.table("data/UCI HAR Dataset/train/X_train.txt")
subject_ytrain<-read.table("data/UCI HAR Dataset/train/Y_train.txt")
subject_test<-read.table("data/UCI HAR Dataset/test/subject_test.txt")
subject_xtest<-read.table("data/UCI HAR Dataset/test/X_test.txt")
subject_ytest<-read.table("data/UCI HAR Dataset/test/Y_test.txt")

#Merges datasets into one and adds column names
train<-cbind(subject_xtrain,subject_train,subject_ytrain)
test<-cbind(subject_xtest,subject_test,subject_ytest)
data<-rbind(train,test)
colnames(data)<-features[,2]
colnames(data)[562:563]<-c("Subject","Activity")

#Subset measurements on the mean and SD for each measurement
meanIndices<-grep("mean",features$V2)
stdIndices<-grep("std",features$V2)
indices<-c(meanIndices,stdIndices,562:563)
subsetData<-data[,indices]

#Clean up column headings
colnames(subsetData)<-sub("\\(\\)","",colnames(subsetData))
colnames(subsetData)<-sub("-"," ",colnames(subsetData))

#Outputs a tidy data set with the average of each variable for each activity and subject
#Give descriptive activity names to name the activities in the data set
output<-ddply(subsetData,.(Subject, Activity),numcolwise(mean))
activity<-read.table("data/UCI HAR Dataset/activity_labels.txt")
output<-merge(output,activity,by.x="Activity",by.y="V1",all=TRUE)
colnames(output)[82]<-"Activity Description"
output<-output[c(1,82,2:81)]
output<-output[order(output$Activity, output$Subject),]

write.table(output,file="data/UCI HAR Dataset/tidy_data.txt",sep = ",",row.names=FALSE)
