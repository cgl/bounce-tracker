# Bounce Tracker  (Aka. LINDY HOP-O-METER)
==========

Bounce Traker is a set of R scripts that calculates if your bounces are down into the floor as they should ne in Lindy Hop.

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

