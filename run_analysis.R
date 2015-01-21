setwd("C:/Users/Ankur/Downloads/UCI HAR Dataset")
ftr<-read.table("features.txt")
test<-read.table("test/X_test.txt")
train<-read.table("train/X_train.txt")

testy<-read.table("test/y_test.txt")
trainy<-read.table("train/y_train.txt")

tests<-read.table("test/subject_test.txt")
trains<-read.table("train/subject_train.txt")
sub<-rbind(trains, tests)
colnames(sub)<-"subject"

lab<-read.table("activity_labels.txt")

mr<-rbind(train, test)
mr1<-mr[,c(41:46,81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)]
mra<-rbind(trainy, testy)

mfinal<-cbind(mr1, mra, sub)
mfinal2<-merge(mfinal,lab)
mfinal2<-mfinal2[,-1]

ftr1<-ftr[c(41:46,81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543),]

ftr1[[3]]<-c("mean_gravity_acc_signal_x","mean_gravity_acc_signal_y","mean_gravity_acc_signal_z","sd_gravity_acc_signal_x","sd_gravity_acc_signal_y","sd_gravity_acc_signal_z","mean_body_jerk_acc_x","mean_body_jerk_acc_y","mean_body_jerk_acc_z","sd_body_jerk_acc_x","sd_body_jerk_acc_y","sd_body_jerk_acc_z","mean_body_ang_velocity_x","mean_body_ang_velocity_y","mean_body_ang_velocity_z","sd_body_ang_velocity_x","sd_body_ang_velocity_y","sd_body_ang_velocity_z","mean_body_jerk_ang_velocity_x","mean_body_jerk_ang_velocity_y","mean_body_jerk_ang_velocity_z","sd_body_jerk_ang_velocity_x","sd_body_jerk_ang_velocity_y","sd_body_jerk_ang_velocity_z","mean_body_acc_magnitude","sd_body_acc_magnitude","mean_gravity_acc_magnitude","sd_gravity_acc_magnitude","mean_body_jerk_acc_magnitude","sd_body_jerk_acc_magnitude","mean_body_ang_velocity_magnitude","sd_body_ang_velocity_magnitude","mean_body_jerk_ang_velocity_magnitude","sd_body_jerk_ang_velocity_magnitude","mean_fft_body_acc_x","mean_fft_body_acc_y","mean_fft_body_acc_z","sd_fft_body_acc_x","sd_fft_body_acc_y","sd_fft_body_acc_z","mean_fft_body_jerk_acc_x","mean_fft_body_jerk_acc_y","mean_fft_body_jerk_acc_z","sd_fft_body_jerk_acc_x","sd_fft_body_jerk_acc_y","sd_fft_body_jerk_acc_z","mean_fft_body_ang_velocity_x","mean_fft_body_ang_velocity_y","mean_fft_body_ang_velocity_z","sd_fft_body_ang_velocity_x","sd_fft_body_ang_velocity_y","sd_fft_body_ang_velocity_z","mean_fft_body_acc_magnitude","sd_fft_body_acc_magnitude","mean_fft_body_jerk_acc_magnitude","sd_fft_body_jerk_acc_magnitude","mean_fft_body_ang_velocity_magnitude","sd_fft_body_ang_velocity_magnitude", "mean_fft_body_jerk_ang_velocity_magnitude","sd_fft_body_jerk_ang_velocity_magnitude")

colnames(mfinal2)<-c(as.character(ftr1[[3]]), "Subject", "Activity description")

tidy<-data.frame()
df<-data.frame()

for(i in 1:30){
  
  for(j in 1:6){
    
    df<-mfinal2[(mfinal2$Subject==i)&(mfinal2["Activity description"]==as.character(lab[j,2])),]
    
    res <- unlist(lapply(df[,1:60], function(x) sum(x, na.rm=T)))
    
    d<-data.frame(t(res),i, as.character(lab[j,2]))
    
    tidy<-rbind(tidy, d)     
    
  }
}

tidy<-tidy[c(61,62,1:60)]
colnames(tidy)<-c("Subject", "Activity description", as.character(ftr1[[3]]))

write.table(tidy, "c:/Users/Ankur/Downloads/mydata.txt", sep="\t",row.name=FALSE)
