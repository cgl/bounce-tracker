#!/usr/bin/python

import traceback, sys, re, getopt, datetime, os

def checkTip(pos, points):
    # if next point is higher than this point, then this is not a tip
    if pos+1 < len(points):
       if points[pos] < points[pos+1]:
          return False
    # check next 10 points
    for i in range(pos+1, pos+20):
       # if one of them is higher than this(pos), then it is not a tip
       if i < len(points) and points[pos] < points[i]:
          return False
    return True

def checkBottom(pos, points):
    # if prev point is lower than this point, then this is not a bottom
    if pos-1 >= 0:
       if points[pos] > points[pos-1]:
          return False
    # check prev 10 points
    for i in reversed(range(pos-20, pos-1)):
       # if one of them is lower than this(pos), then it is not a bottom
       if i < len(points) and points[pos] > points[i]:
          return False
    return True

def detectBounce(points):
    for i in range(0, len(points)):
       # find point which is higher than the next point
       if i > 0 and checkTip(i, points):
          # go back find the lowest point
          firstPeak = i
          leftBottom = -1
          maxSecondPeak = -20
          maxSecondDiff = 0
          for j in reversed(range(i-50, i-1)):
             if j > 0 and checkBottom(j, points) and points[firstPeak]-points[j] > 7:
                leftBottom = j
                for j in range(i+1, i+50):
                   if j < len(points) and checkBottom(j, points) and points[firstPeak]-points[j] > 5:
                      rightBottom = j
                      maxRight = -1
                      for k in range(j+1, j+50):
                          if k < len(points) and checkTip(k, points) and points[firstPeak]-points[k] > 3 and maxSecondPeak < points[k]:
                             secondPeak = k
                             maxSecondPeak = points[secondPeak]
                             for l in range(k+1, k+50):
                                 if l < len(points) and checkBottom(l, points) and points[secondPeak]-points[l] > 5 and maxSecondDiff <= (points[secondPeak]-points[l]):
                                    maxSecondDiff = points[secondPeak]-points[l]
                                    #print "%d,%d,%d,%d,%d" % (leftBottom, firstPeak, rightBottom, secondPeak, l)
                                    #print "%f,%f,%f,%f,%f" % (points[leftBottom],points[firstPeak], points[rightBottom],points[secondPeak], points[l])
                                    print "%d=%f %d=%f %d=%f %d=%f %d=%f" % (leftBottom, points[leftBottom], firstPeak, points[firstPeak], rightBottom, points[rightBottom], secondPeak, points[secondPeak], l, points[l])
                                    peakSeen = False
                                    for m in range(l+1, k+50):
                                        if m < len(points) and checkTip(m, points):
                                            if points[m]-points[l] > 5:
                                                 peakSeen = True
                                                 break
                                    if peakSeen:
                                        maxRight = l
                                        break
                          if k == maxRight:
                             break
                peakSeen = False
                for k in reversed(range(j-10, j-1)):
                    if k > 0 and checkTip(k, points):
                        if points[k]-points[leftBottom] > 5:
			    peakSeen = True
                            break
                if peakSeen:
                    break
points = []
#file = open("data/20140327-1205-/11.ST_Linear_Acceleration.log", 'r')
file = open("pieces/24.BOSCH_BMA250_3-axis_Accelerometer.log.piece-2", 'r')
lines = file.readlines()
for line in lines:
   fields = line.split("|")
   points.append(float(fields[1]))

print "%d points" % (len(points))
detectBounce(points)
