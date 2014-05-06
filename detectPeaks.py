#!/usr/bin/python

import traceback, sys, re, getopt, datetime, os

def listdir_fullpath(d):
    return [os.path.join(d, f) for f in os.listdir(d)]

def checkTip(pos, points):
    # check next 5 points
    for i in range(pos+1, pos+5):
       # if one of them is higher than this(pos), then it is not a tip
       if i < len(points) and points[pos] < points[i]:
          return False
    return True

def checkBottom(pos, points, first, last):
    # if prev point is lower than this point, then this is not a bottom
    if first:
      # check prev 10 points
      for i in reversed(range(pos-10, pos-1)):
         # if one of them is lower than this(pos), then it is not a bottom
         if i < len(points) and points[pos] > points[i] and i >= last:
#            if i > 650:
#              print "%d %d %f > %f (l=%d)" % (pos, i, points[pos], points[i], last)
            return False
    else:
      for i in range(1, 5):
        if pos+i < len(points) and points[pos+i] < points[pos]:
          return False
    return True

def detectPeaks(points):
    rightBottom = -1
    peaks = []
    for i in range(0, len(points)):
       # find point which is higher than the next point
       if i > 0 and checkTip(i, points) and i >= rightBottom:
          # go back find the lowest point
          firstPeak = i
          leftBottom = -1
          found = False
#          if i > 650:
#            print "p=%d r=%d" % (i, rightBottom)
          for j in reversed(range(i-20, i-1)):
#             if j > 0 and checkBottom(j, points, True, rightBottom-1) and points[firstPeak]-points[j] > 2 and j >= rightBottom:
             if j > 0 and checkBottom(j, points, True, rightBottom) and points[firstPeak]-points[j] > 1 and j >= rightBottom:
                leftBottom = j
#                if j > 650:
#                  print "l=%d" % (j)
                for jj in range(i+1, i+20):
#                   if jj < len(points) and checkBottom(jj, points, False, firstPeak):
#                      print "%f %f" % ((points[firstPeak]-points[jj]), (points[firstPeak]-points[j]))
                   if jj < len(points) and checkBottom(jj, points, False, firstPeak) and (points[firstPeak]-points[jj] > 2.5 or points[firstPeak]-points[j] > 2.5):
                      rightBottom = jj
#                      print "%d %d %d (%f %f %f)" % (leftBottom, firstPeak, rightBottom, points[leftBottom], points[firstPeak], points[rightBottom])
                      peaks.append([leftBottom, firstPeak, rightBottom, points[leftBottom], points[firstPeak], points[rightBottom]])
                      found = True
                      break
             if found:
               break
    return peaks

def getPeaks(file):
  points = []
  fl = open(file, 'r')
  lines = fl.readlines()
  for line in lines:
    fields = line.split("|")
    points.append(float(fields[2]))
  fl.close()
  return detectPeaks(points)

def savePeaks():
  files = listdir_fullpath("pieces")
  for file in files:
    if re.search(".points", file) is None:
      print file
      peaks = getPeaks(file)

      w = open("%s.points" % (file), "w")
      for i in range(1, len(peaks)-1):
        if peaks[i-1][4] > peaks[i][4] and peaks[i][1]-peaks[i-1][1] < 20:
          w.write("%d %f\n" % (peaks[i][0], peaks[i][3]))
          w.write("%d %f\n" % (peaks[i][1], peaks[i][4]))
          w.write("%d %f\n" % (peaks[i][2], peaks[i][5]))
      w.close()

def getPeakMatrix():
  arr = {}
  dirs = listdir_fullpath("pieces2")
  for dir in dirs:
    if re.search("adv-", dir) or re.search("int-", dir):
      d = re.sub("pieces2/", "", dir);
      ff = d.split('-')
      level = ff[0]
      gender = ff[1]

      if level not in arr:
        arr[level] = {}
      if gender not in arr[level]:
        arr[level][gender] = {}
      
      files = listdir_fullpath(dir)
      for fl in files:
        fff = re.sub("%s/" % dir, "", fl)
        dancerIndex = fff.split('.')[0]
        pieceIndex = fl.split('-')[2]
        peaks = getPeaks(fl)

        if pieceIndex not in arr[level][gender]:
          arr[level][gender][pieceIndex] = {}

        count = 0
        for i in range(1, len(peaks)-1):
          if peaks[i-1][4] > peaks[i][4] and peaks[i][1]-peaks[i-1][1] < 20:
            count = count+1
        arr[level][gender][pieceIndex][dancerIndex] = count

  for level in arr:
    print "%s" % level
    for gender in arr[level]:
      print "   %s" % gender
      for pieceIndex in arr[level][gender]:
        print "      Song %s" % pieceIndex
        for dancerIndex in arr[level][gender][pieceIndex]:
           print "         %s\t%d" % (dancerIndex, arr[level][gender][pieceIndex][dancerIndex])

#getPeakMatrix()
savePeaks()
