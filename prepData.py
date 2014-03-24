#!/usr/bin/python

import traceback, sys, re

logs = {}
i = 0
seen = False
f = open("log.txt", 'r')
lines = f.readlines()
for line in lines:
  if seen:
    line = re.sub("\n", "", line)
    fields = line.split("|")
    dataType = fields[0]+"."+re.sub(" ", "_", fields[1])
    fields[2] = re.sub(",", "|", fields[2])
    data = fields[1]+"|"+fields[2]+"|"+fields[3]
    data = re.sub(r"[\[\]]", "", data)
    if dataType not in logs:
       logs[dataType] = []
    logs[dataType].append(data)    
  if re.search("sensorName", line):
    seen = True

  i = i+1

for dataType in logs:
   f = open(dataType+".log", "w")
   for log in logs[dataType]:
     f.write(log+"\n")
   f.close()
