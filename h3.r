source("bouncer.r")
datalinacc3 = returnDataCleaned(linacc3)
datalinacc4 = returnDataCleaned(linacc4)
datalinacc6 = returnDataCleaned(linacc6)

datalinacc3minus =  c(-1 * datalinacc3)
datalinacc4minus =  c(-1 * datalinacc4)
datalinacc6minus =  c(-1 * datalinacc6)

plotSampleh3 <- function() {
  png("figs/h3Sample.png",width=600,height=800,res=72)
  plotCenterThreeVector(datalinacc3minus, datalinacc4minus, datalinacc6minus, "Slow song center data", "Medium song center data", "Fast song center data")
  dev.off()
}

datalinacc1 = returnDataCleaned(linacc1)
datalinacc1minus =  c(-1 * datalinacc1)

datalinacc16 = returnDataCleaned(linacc16)
plotSampleh2 <- function() {
  png("figs/h2Sample.png",width=600,height=300,res=72)
  plotCenterVector(datalinacc16, "Partnered dance center data")
  dev.off()
}
