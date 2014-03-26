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
#  x11(width=1200, height=300)
  plot(my.rotation$V3, type="l", main=filename)
  par(pin=c(800,300))

 }

statData<-function(filename) {
  my.rotation <- read.table(header=FALSE, filename, sep="|")
  summary(my.rotation)

 }

dataClean<-function(filename) {
   h.data = read.table(header=FALSE, filename, sep="|")
   h.data$V3[500:(length(h.data$V3)-500)]
}
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
# Change directory to our folder
# setwd(./work/bounceTracker)

gravity3 = "data/h3-preliminary/3.ST_Gravity.log"
acc3 = "data/h3-preliminary/3.3-axis_Accelerometer.log"

gravity4 = "data/h3-preliminary/4.ST_Gravity.log"
acc4 = "data/h3-preliminary/4.3-axis_Accelerometer.log"


# statData(acc3)

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
