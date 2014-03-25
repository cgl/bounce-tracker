# Bounce Tracker  (Lindy Hop-O-Meter)
======

Bounce Traker is a set of R scripts that can asses body movements during dancing. We use mobile data collected with Sensor Log (https://play.google.com/store/apps/details?id=com.hfalan.activitylog) in order to assess bodily movements while dancing and give automatic feedback by comparing those movements to the norms of the dance.

## Getting Started

Below are the instructions you can use to bootstrap with our library.

In your R shell or R.app, first we need to change our directory. This is same as "cd bounceTracker" as in a unix shell. Then we will import the bounce library.

    > setwd(bounceTracker)
    > source("bouncer.r")

To see the the names of the objects and functions loaded with the bounce library you can use:

    > ls(envir=.GlobalEnv)

In order to get a summary of the bounce data:

    > statData(acc3)
    > statData(gravity3)
