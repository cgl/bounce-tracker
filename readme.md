# Bounce Tracker  (Lindy Hop-O-Meter)
======

Bounce Traker is a set of R scripts that can asses body movements during dancing. We use mobile data collected with Sensor Log (https://play.google.com/store/apps/details?id=com.hfalan.activitylog) in order to assess bodily movements while dancing and give automatic feedback by comparing those movements to the norms of the dance.

## Getting Started

Below are the instructions you can use to bootstrap with our library.

In your R shell or R.app, first we need to change our directory. This is same as "cd bounceTracker" as in a unix shell. Then we will import the bounce library.

    > setwd("bounceTracker")
    > source("bouncer.r")
    > source("init.r")

To see the the names of the objects and functions loaded with the bounce library you can use:

    > ls(envir=.GlobalEnv)

We use files:

    > int_male1_p1 = "pieces/20.BOSCH_BMA250_3-axis_Accelerometer.log.piece-1"
    > int_male1_p3 = "pieces/20.BOSCH_BMA250_3-axis_Accelerometer.log.piece-3"

In order to get a summary of the bounce data:

    > statData(int_male1_p1)
           x                 y                 z                 mag  
     Min.   :-19.498   Min.   :-19.498   Min.   :-15.553   Min.   : 0.1149  
     1st Qu.: -6.665   1st Qu.: -6.665   1st Qu.:  1.724   1st Qu.: 7.9488  
     Median : -4.022   Median : -4.022   Median :  3.448   Median :10.2858  
     Mean   : -4.333   Mean   : -4.333   Mean   :  3.610   Mean   :11.3968  
     3rd Qu.: -1.456   3rd Qu.: -1.456   3rd Qu.:  5.325   3rd Qu.:14.2527  
     Max.   : 16.012   Max.   : 16.012   Max.   : 19.269   Max.   :32.8766 
     
To use the data we put into a R data frame:

    > data_int_male3_p1 = returnData(int_male3_p1)
    > summary(data_int_male3_p1)
           x                   y                   z                mag         
     Min.   :-17.69794   Min.   :-17.69794   Min.   :-15.744   Min.   : 0.9234  
     1st Qu.: -2.03986   1st Qu.: -2.03986   1st Qu.:  1.532   1st Qu.: 7.4481  
    Median : -0.15323   Median : -0.15323   Median :  2.796   Median : 9.8630  
    Mean   : -0.09925   Mean   : -0.09925   Mean   :  3.060   Mean   :10.5610  
    3rd Qu.:  1.83875   3rd Qu.:  1.83875   3rd Qu.:  4.482   3rd Qu.:12.9351  
    Max.   : 14.67167   Max.   : 14.67167   Max.   : 19.690   Max.   :31.0169 

    
To clean the head and tail of the data you can use dataClean function. It strips 500 data points from both beginning and the end of the data coloumn given. 

    > cleaned_x = cleanData(data_int_male3_p1$x)
    > summary(cleaned_x)
        Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    -17.7000  -2.3370  -0.4980  -0.5055   1.4560  14.6700 
    
Plotting a coloumn, file and vector are done by using:
    
    > plotCollection(data_int_male3_p1, "x")
    > plotTwoCollections(data_int_male2_p1, data_int_male3_p1, "y")
    > plotTwoFiles(int_male2_p1, adv_male2_p1,"z")
    > plotThreeFiles(int_male2_p1, int_male2_p2, int_male2_p3,"mag")
    > plotThreeVector(data_int_male2_p1$mag, data_int_male2_p2$mag, data_int_male2_p3$mag) 

If we only want to plot a small portion of the vector from the center with a given radius:
    > plotCenterFile(adv_male2_p1,"z",2000)
    > plotCenterThreeFile(adv_male2_p1,adv_male2_p2,adv_male2_p3,"z",2000)
    > plotCenterVector(data_adv_male2_p1$z,"Caption for adv male 2",2000)
    > plotCenterThreeVector(data_adv_male2_p1$z, data_adv_male2_p2$z, data_adv_male2_p3$z, "p1", "p2", "p3", 2000)

    

For test we used the below function, when set to TRUE saves two PNGS into figs folder:

    > dataCleanTest(TRUE)
