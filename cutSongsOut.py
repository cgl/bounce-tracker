#!/usr/bin/python

import traceback, sys, re
import datetime, time, os
from math import sqrt

def listdir_fullpath(d):
    return [os.path.join(d, f) for f in os.listdir(d)]

def maxminDiff(list):
  max = -100000
  min = 100000
  for num in list:
    if num > max:
      max = num
    if num < min:
      min = num
  return max-min

windowSize = 50

dirs = listdir_fullpath("data")
for dir in dirs:
  if re.search("set$", dir):
    files = listdir_fullpath(dir)
    for file in files:
#      if re.search("3-axis_Acce", file):
      if re.search("Linear_Acceleration", file):
        last = []
        lines = []
        print file
        ff = file
        ff = re.sub(dir, "", ff)
        pieceIndex = 1
        f = open(file, 'r')
        for line in f.readlines():
          toks = line.split('|')
          last.append(float(toks[1]))
          lines.append(line)
          if len(last) > windowSize:
            last.pop(0)
            std = maxminDiff(last)
            if std < 1 and len(lines) > 4000:
                q = open("pieces/%s.piece-%d" % (ff, pieceIndex), 'w')
                for l in lines:
                    q.write("%s" % l)
                q.close()
                pieceIndex = pieceIndex+1
                lines = []
            elif std < 1 and pieceIndex == 1 and len(lines) < 1000:
                lines = []
            elif std < 1 and len(lines) < 10:
                lines = []
            #print std
        f.close()

        if len(lines) > 4000:
            q = open("pieces/%s.piece-%d" % (ff, pieceIndex), 'w')
            for l in lines:
                q.write("%s" % l)
            q.close()
            pieceIndex = pieceIndex+1
            lines = []
        print "%d pieces (%d leftovers)" % (pieceIndex-1, len(lines))
        #print "-----"
        #sys.exit()
