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

# Change directory to our folder
# setwd(./work/bounceTracker)

gravity3 = "data/20140325-1937-h3-cagil/3.ST_Gravity.log"
acc3 = "data/20140325-1937-h3-cagil/3.3-axis_Accelerometer.log"

# statData(acc3)
