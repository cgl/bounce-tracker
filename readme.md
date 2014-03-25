# Bounce Tracker  (Lindy Hop-O-Meter)
======

Bounce Traker is a set of R scripts that can asses body movements during dancing. We use mobile data collected with Sensor Log (https://play.google.com/store/apps/details?id=com.hfalan.activitylog) in order to assess bodily movements while dancing and give automatic feedback by comparing those movements to the norms of the dance.

## Getting Started

Below are the instruction you can find to bootstrap.

In your R shell or R.app first we change our directory. This is same as "cd bounceTracker" as in shell.

    > setwd(./bounceTracker)
    > source("bouncer.r")

To see the the names of the objects loaded you can use:

    > ls(envir=.GlobalEnv)

In order to get a summary of the bounce data:

    > statData(acc3)
    > statData(gravity3)
    
To clean the head and tail of the data you can use:

    > dataClean (yazılmadı henüz bu fonk)
    
For test we used the below function, when set to TRUE saves two PNGS into figs folder:

    > dataCleanTest(TRUE)
