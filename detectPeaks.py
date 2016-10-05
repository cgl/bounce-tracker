#!/usr/bin/python

import traceback, sys, re, getopt, datetime, os
from math import sqrt

def listdir_fullpath(d):
    return [os.path.join(d, f) for f in os.listdir(d)]

def checkTip(pos, points):
    # check next 5 points
    for i in range(pos+1, pos+5):
       # if one of them is higher than this(pos), then it is not a tip
       if i < len(points) and points[pos][0] < points[i][0]:
          return False
    return True

def checkBottom(pos, points, first, last):
    # if prev point is lower than this point, then this is not a bottom
    if first:
      # check prev 10 points
      for i in reversed(range(pos-10, pos-1)):
         # if one of them is lower than this(pos), then it is not a bottom
         if i < len(points) and points[pos][0] > points[i][0] and i >= last:
#            if i > 650:
#              print "%d %d %f > %f (l=%d)" % (pos, i, points[pos][0], points[i][0], last)
            return False
    else:
      for i in range(1, 5):
        if pos+i < len(points) and points[pos+i][0] < points[pos][0]:
          return False
    return True

def getMag(points):
  total = points[0]*points[0] + points[1]*points[1] + points[2]*points[2]
  return sqrt(total)

def detectPeaks(points):
    rightBottom = -1
    peaks = []
    p = 0
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
#             if j > 0 and checkBottom(j, points, True, rightBottom-1) and points[firstPeak][p]-points[j][p] > 2 and j >= rightBottom:
             if j > 0 and checkBottom(j, points, True, rightBottom) and points[firstPeak][p]-points[j][p] > 1 and j >= rightBottom:
                leftBottom = j
#                if j > 650:
#                  print "l=%d" % (j)
                for jj in range(i+1, i+20):
#                   if jj < len(points) and checkBottom(jj, points, False, firstPeak):
#                      print "%f %f" % ((points[firstPeak][p]-points[jj][p]), (points[firstPeak][p]-points[j][p]))
                   if jj < len(points) and checkBottom(jj, points, False, firstPeak) and (points[firstPeak][p]-points[jj][p] > 2.5 or points[firstPeak][p]-points[j][p] > 2.5) and points[firstPeak][p] > points[rightBottom][p]:
                      rightBottom = jj
#                      print "%d %d %d (%f %f %f)" % (leftBottom, firstPeak, rightBottom, points[leftBottom][p], points[firstPeak][p], points[rightBottom][p])
                      peaks.append([leftBottom, firstPeak, rightBottom, points[leftBottom][p], points[firstPeak][p], points[rightBottom][p], points[leftBottom][1], points[firstPeak][1], points[rightBottom][1]])
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
    points.append([float(fields[2]), getMag([float(fields[1]), float(fields[2]), float(fields[3])])])
  fl.close()
  if len(points) > 8000:
    m = (len(points)-8000)/2
    center_points = points[m:(m+8000)]
  else:
    m = (len(points)-4000)/2
    center_points = points[m:(m+4000)]
  return (detectPeaks(center_points), len(center_points))

def savePeaks():
  files = listdir_fullpath("pieces")
  for file in files:
    if re.search(".points", file) is None:
      print file
      (peaks, pC) = getPeaks(file)

      w = open("%s.fpoints" % (file), "w")
      lastI = -1
      for i in range(1, len(peaks)-1):
        if peaks[i-1][4] > peaks[i][4] and peaks[i][1]-peaks[i-1][1] < 20 and i-1 != lastI and peaks[i-1][4] != 0:
          w.write("%d %f\n" % (peaks[i-1][0], peaks[i-1][3]))
          w.write("%d %f\n" % (peaks[i-1][1], peaks[i-1][4]))
          w.write("%d %f\n" % (peaks[i-1][2], peaks[i-1][5]))
          lastI = i;
      w.close()

      w = open("%s.spoints" % (file), "w")
      lastI = -1
      for i in range(1, len(peaks)-1):
        if peaks[i-1][4] > peaks[i][4] and peaks[i][1]-peaks[i-1][1] < 20 and i-1 != lastI and peaks[i-1][4] != 0:
          w.write("%d %f\n" % (peaks[i][0], peaks[i][3]))
          w.write("%d %f\n" % (peaks[i][1], peaks[i][4]))
          w.write("%d %f\n" % (peaks[i][2], peaks[i][5]))
          lastI = i
      w.close()

def printBySong(arr, index):
    w = open("song%s.r" % (index), "w")
    for level in arr:
      for gender in arr[level]:
        for pieceIndex in arr[level][gender]:
          if pieceIndex == index:
            for dancerIndex in arr[level][gender][pieceIndex]:
              w.write("%d\n" % (arr[level][gender][pieceIndex][dancerIndex]))
    w.close()

def printByLevel(arr, lvl):
    w = open("%s.r" % (lvl), "w")
    for level in arr:
      if level == lvl:
        for gender in arr[level]:
          for pieceIndex in arr[level][gender]:
            for dancerIndex in arr[level][gender][pieceIndex]:
              w.write("%d\n" % (arr[level][gender][pieceIndex][dancerIndex]))
    w.close()

def getPeakMatrix(r):
  arr = {}
  pCs = {}
  ds = {}
  bs = {}
  dirs = listdir_fullpath("pieces2")
  for dir in dirs:
#    if re.search("adv-", dir):
    if re.search("adv-", dir) or re.search("int-", dir):
      d = re.sub("pieces2/", "", dir);
      ff = d.split('-')
      level = ff[0]
      gender = ff[1]

      if level not in arr:
        arr[level] = {}
        pCs[level] = {}
        ds[level] = {}
        bs[level] = {}
      if gender not in arr[level]:
        arr[level][gender] = {}
        pCs[level][gender] = {}
        ds[level][gender] = {}
        bs[level][gender] = {}
      
      files = listdir_fullpath(dir)
      for fl in files:
#        if 1 or re.search("piece-1", fl):
         if re.search("3-axis", fl):
          fff = re.sub("%s/" % dir, "", fl)
          dancerIndex = fff.split('.')[0]
          pieceIndex = fl.split('-')[3]
          (peaks, pC) = getPeaks(fl)

          if pieceIndex not in arr[level][gender]:
            arr[level][gender][pieceIndex] = {}
            pCs[level][gender][pieceIndex] = {}
            ds[level][gender][pieceIndex] = {}
            bs[level][gender][pieceIndex] = {}
          if dancerIndex not in bs[level][gender][pieceIndex]:
#            ds[level][gender][pieceIndex][dancerIndex] = []
            bs[level][gender][pieceIndex][dancerIndex] = []

          count = 0
          lastI = -1
          winlen = pC/10
          blocks = []

          lastBlockIndex = 0
          for i in range(1, len(peaks)-1):
            if peaks[i-1][4] > peaks[i][4] and peaks[i][1]-peaks[i-1][1] < 20 and i-1 != lastI:
              fdiff = peaks[i-1][4]-peaks[i-1][5]
              sdiff = peaks[i][4]-peaks[i][3]
#              if sdiff/fdiff < 0.5:
              count = count+1
#              ds[level][gender][pieceIndex][dancerIndex].append(sdiff/fdiff)
              if int(peaks[i][1]/winlen) != lastBlockIndex:
                lastBlockIndex = int(peaks[i][1]/winlen)
                blocks.append(str(count))
#                count = 0

              if dancerIndex not in ds[level][gender][pieceIndex]:
                ds[level][gender][pieceIndex][dancerIndex] = sdiff/fdiff
              else:
                ds[level][gender][pieceIndex][dancerIndex] = ds[level][gender][pieceIndex][dancerIndex] + sdiff/fdiff
             
              lastI = i

          blocks.append(str(count))
          
          arr[level][gender][pieceIndex][dancerIndex] = count
          pCs[level][gender][pieceIndex][dancerIndex] = pC
          bs[level][gender][pieceIndex][dancerIndex] = blocks
          if count > 0:
            ds[level][gender][pieceIndex][dancerIndex] = ds[level][gender][pieceIndex][dancerIndex]/float(count)
          else:
            ds[level][gender][pieceIndex][dancerIndex] = 0


  if r:
    printBySong(arr, "1")
    printBySong(arr, "2")
    printBySong(arr, "3")

    printByLevel(arr, "adv")
    printByLevel(arr, "int")
  else:
    '''
    for level in arr:
      for gender in arr[level]:
        for song in arr[level][gender]:
          w = open("ds/%s-%s-p%s.d" % (level, gender, song), "w")
          for dancerIndex in arr[level][gender][song]:
            if dancerIndex != "9" and dancerIndex != "8":
              for b in ds[level][gender][song][dancerIndex]:
                w.write("%f\n" % b)
          w.close()
    '''
    for level in arr:
      print "%s" % level
      for gender in arr[level]:
        print "   %s" % gender
        for pieceIndex in arr[level][gender]:
          print "      Song %s" % pieceIndex
          for dancerIndex in arr[level][gender][pieceIndex]:
             print "         %s\t%d\t%d\t%f" % (dancerIndex, arr[level][gender][pieceIndex][dancerIndex], pCs[level][gender][pieceIndex][dancerIndex], float(arr[level][gender][pieceIndex][dancerIndex])/float(pCs[level][gender][pieceIndex][dancerIndex]))
#             print "%f" % (float(arr[level][gender][pieceIndex][dancerIndex]*100)/float(pCs[level][gender][pieceIndex][dancerIndex]))
#             print "          %s\t%f" % (dancerIndex, ds[level][gender][pieceIndex][dancerIndex])
#             print "      %s\t%s" % (dancerIndex, ' '.join(bs[level][gender][pieceIndex][dancerIndex]))
#    '''
#getPeakMatrix(False)
savePeaks()

'''
(peaks, pC) = getPeaks("pieces/11.Panasonic_Linear_Acceleration.log.piece-2")

w = open("points", "w")
for i in range(0, len(peaks)-1):
  w.write("%d %f\n" % (peaks[i][0], peaks[i][3]))
  w.write("%d %f\n" % (peaks[i][1], peaks[i][4]))
  w.write("%d %f\n" % (peaks[i][2], peaks[i][5]))
w.close()
'''
