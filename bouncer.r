printData<-function(filename) {
  my.rotation <- read.table(header=FALSE, filename, sep="|")
  my.jpegname = paste(filename,"png",sep=".")
  print(my.jpegname)
  png(my.jpegname,width=1200,height=350,res=72)
  plot(my.rotation$V3, type="l", main=filename)
  dev.off()
 }

showPlot<-function(filename) {
  my.rotation <- read.table(header=FALSE, filename, sep="|")
  plot(my.rotation$V3, type="l", main=filename)
 }

statData<-function(filename) {
  my.rotation <- read.table(header=FALSE, filename, sep="|")
  my.rotation$mag = sqrt(my.rotation$V2^2 + my.rotation$V3^2 + my.rotation$V4^2)
  summary(my.rotation)
 }

statDataV3<-function(filename) {
  h.data <- read.table(header=FALSE, filename, sep="|")
  h.cleaned <- h.data$V3[500:(length(h.data$V3)-500)]
  summary(h.cleaned)
 }

returnData<-function(filename) {
  my.rotation <- read.table(header=FALSE, filename, sep="|")
  my.rotation$mag = sqrt(my.rotation$V2^2 + my.rotation$V3^2 + my.rotation$V4^2)
  summary(my.rotation)
  return(my.rotation)
 }

returnDataCleaned<-function(filename) {
  h.data <- read.table(header=FALSE, filename, sep="|")
  h.cleaned <- h.data$V3[500:(length(h.data$V3)-500)]
  return(h.cleaned)
 }

cleanData <- function(collection) {
  return(collection[500:(length(collection)-500)])
}

dataClean<-function(filename) {
   h.data = read.table(header=FALSE, filename, sep="|")
   h.data$V3[500:(length(h.data$V3)-500)]
}

# To check how much we should strip from the beginning and from the end
dataCleanTest<- function(save){
  h3.slow = read.table(header=FALSE, gravity3, sep="|")
  if(save)
      png("figs/cleanupExample.png",width=1000,height=800,res=72)
  par(mfrow=c(2,1))
  plot(head(h3.slow$V3,n=1000), type="s", main="h3 slow song head noise")
  plot(tail(h3.slow$V3,n=1000), type="s", main="h3 slow song tail noise")
  if(save){
    dev.off()
    png("figs/cleanupExample_beforeAfter.png",width=1000,height=800,res=72)
  }
  par(mfrow=c(2,1))
  plot(h3.slow$V3, type="s", main="h3 slow song first record")
  plot(h3.slow$V3[500:(11027-500)], type="s", main="h3 slow song cleaned record")
  length(h3.slow$V3[500:(11027-500)])
  if(save)
    dev.off()
}

dataCleanTestGeneric<- function(file,caption,save){
  h3.song = read.table(header=FALSE, file, sep="|")
  h3.ylim = c((min(h3.song$V3)-2),(max(h3.song$V3)+2))
  if(save){
    dataCaption <- paste(paste("figs/cleanupExample", caption, sep = "_"),"png", sep=".") # "figs/cleanupExample.png"
    png(dataCaption,width=1000,height=800,res=72)
    par(mfrow=c(2,1))
    plot(head(h3.song$V3,n=1000), type="s", main="head noise")
    plot(tail(h3.song$V3,n=1000), type="s", main="tail noise")
    dev.off()
  }
  if(save){
    dataCaption <- paste(paste("figs/cleanupExample_BA", caption, sep = "_"),"png", sep=".") # "figs/cleanupExample_beforeAfter.png"
    png(dataCaption,width=1000,height=800,res=72)
  }
  par(mfrow=c(2,1))
  plot(h3.song$V3, type="s", main="original record",xlim=c(1,length(h3.song$V3)),ylim=h3.ylim)
  plot(h3.song$V3[500:(length(h3.song$V3)-500)], type="s", main="cleaned record", xlim=c(1,length(h3.song$V3)),ylim=h3.ylim)
  if(save)
    dev.off()
}


plotTogether <- function(file1,file2) {
    h.data1 <- read.table(header=FALSE, file1, sep="|")
    h.data2 <- read.table(header=FALSE, file2, sep="|")
    par(mfrow=c(2,1))
    h.ylim = c(min(c(min(h.data1$V3),min(h.data2$V3))),max(c(min(h.data1$V3),min(h.data2$V3))))
    plot(h.data1$V3, type="l", main=file1)
    plot(h.data2$V3, type="l", main=file2)
}
# plots files
plotThreeTogether <- function(file1,file2,file3) {
    h.data1 <- read.table(header=FALSE, file1, sep="|")
    h.data2 <- read.table(header=FALSE, file2, sep="|")
    h.data3 <- read.table(header=FALSE, file3, sep="|")
    h.ylim = c(min(c(min(h.data1$V3),min(h.data2$V3),min(h.data3$V3))),max(c(max(h.data1$V3),max(h.data2$V3),max(h.data3$V3))))
    par(mfrow=c(3,1))
    plot(h.data1$V3, type="l", main=file1, col=2)
    plot(h.data2$V3, type="l", main=file2, col=3)
    plot(h.data3$V3, type="l", main=file3, col=4)
}

plotTwoTogether <- function(file1,file2) {
    h.data1 <- read.table(header=FALSE, file1, sep="|")
    h.data2 <- read.table(header=FALSE, file2, sep="|")
    h.ylim = c(min(c(min(h.data1$V3),min(h.data2$V3))),max(c(max(h.data1$V3),max(h.data2$V3))))
    par(mfrow=c(2,1))
    plot(h.data1$V3, type="l", main=file1, col=2)
    plot(h.data2$V3, type="l", main=file2, col=3)
}

# plots vectore
plotThreeVector <- function(vec1,vec2,vec3) {
    h.ylim = c(min(c(min(vec1),min(vec2),min(vec3))),max(c(max(vec1),max(vec2),max(vec3))))
    par(mfrow=c(3,1))
    plot(vec1, type="l", col=2)
    plot(vec2, type="l", col=3)
    plot(vec3, type="l", col=4)
}
# Change directory to our folder
# setwd(./work/bounceTracker)

plotCenterFile <- function(file1){
  h.data1 <- read.table(header=FALSE, file1, sep="|")
  center = length(h.data1$V3)/2
  plot(h.data1$V3[(center-200):(center+200)], type="l", main=file1, col=2)
}

plotCenterVector <- function(vec1,cap1){
  center = length(vec1)/2
  plot(vec1[(center-200):(center+200)], type="l", main=cap1)
}

plotCenterThreeFile <- function(file1,file2,file3){
  par(mfrow=c(3,1))
  plotCenterFile(file1)
  plotCenterFile(file2)
  plotCenterFile(file3)
}

# plots the vectors with captions
plotCenterThreeVector <- function(file1,file2,file3,cap1,cap2,cap3){
  par(mfrow=c(3,1))
  plotCenterVector(file1,cap1)
  plotCenterVector(file2,cap2)
  plotCenterVector(file3,cap3)
}

#-------------- Files ----------------------------------------

# h2 ------------
path = "data/ahter/"

gravity1 <- paste(path,"1.ST_Gravity.log",sep="")
acc1 <- paste(path,"1.3-axis_Accelerometer.log",sep="")
linacc1 <- paste(path,"1.ST_Linear_Acceleration.log", sep="")

# h3 ------------
path = "data/h3-preliminary/"
gravity3 = "data/h3-preliminary/3.ST_Gravity.log"
acc3 = "data/h3-preliminary/3.3-axis_Accelerometer.log"

linacc3 <- "data/h3-preliminary/3.ST_Linear_Acceleration.log"
linacc4 <- paste(path,"4.ST_Linear_Acceleration.log", sep="")
linacc6 <- paste(path,"6.ST_Linear_Acceleration.log", sep="")

gravity4 = "data/h3-preliminary/4.ST_Gravity.log"
acc4 = "data/h3-preliminary/4.3-axis_Accelerometer.log"

gravity6 = paste(path,"6.ST_Gravity.log",sep="")
acc6 = paste(path,"6.3-axis_Accelerometer.log",sep="")

# 16 düz 17 ters

path16 <- "data/h0-ters-duz/16."
path17 <- "data/h0-ters-duz/17."

acc16 = paste(path16,"3-axis_Accelerometer.log",sep="")
linacc16 = paste(path16,"ST_Linear_Acceleration.log",sep="")
gravity16 = paste(path16,"ST_Gravity.log",sep="")

linacc17 = paste(path17,"ST_Linear_Acceleration.log",sep="")

# 11 bounce down 12 boune up
path11 <- "data/h0-bounce-down-up/11."
acc11 = paste(path11,"3-axis_Accelerometer.log",sep="")
linacc11 = paste(path11,"ST_Linear_Acceleration.log",sep="")
gravity11 = paste(path11,"ST_Gravity.log",sep="")

# 13|bounce down 15|bounce up

path13 <- "data/h0-ahter/13."
path15 <- "data/h0-ahter/15."

gravity13 = paste(path13,"ST_Gravity.log",sep="")
gravity15 = paste(path15,"ST_Gravity.log",sep="")

acc13 = paste(path13,"3-axis_Accelerometer.log",sep="")
acc15 = paste(path15,"3-axis_Accelerometer.log",sep="")

linacc13 = paste(path13,"ST_Linear_Acceleration.log",sep="")
linacc15 = paste(path15,"ST_Linear_Acceleration.log",sep="")
# statData(acc3)

#----------------------------



#------------- Examples --------------------------------
rExamples<- function(){
  getwd()
  list.files(path = ".")
}

plotExamples<- function(){
  plot(6:25,rnorm(20),type="b",xlim=c(1,30),ylim=c(-2.5,2.5),col=2)
  par(new=T)
  plot(rnorm(30),type="b",axes=F,col=3)
  par(new=F)

  upvar<-rnorm(10)+seq(1,1.9,by=0.1)
  downvar<-rnorm(20)*5+19:10
  par(mar=c(5,4,4,4))
  plot(6:15,upvar,pch=1,col=3,xlim=c(1,20),xlab="Occasion",ylab="",main="Dual ordinate plot")
  mtext("upvar",side=2,line=2,col=3)
}
