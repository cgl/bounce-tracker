#!/usr/bin/python

import traceback, sys, re, getopt, datetime, os

def prepare_data(infile):
    timestamp = datetime.datetime.now().strftime("%Y%m%d-%H%M")
    path = "data/"+timestamp+"-"+infile.split(".")[0]+"/"
    os.makedirs(path)
    logs = {}
    i = 0
    seen = False
    myfile = open(infile, 'r')
    lines = myfile.readlines()
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
      print dataType
      f = open(path+dataType+".log", "w")
      for log in logs[dataType]:
        f.write(log+"\n")
      f.close()

def main(argv):
    infile = "log.txt"
    try:
        opts, args = getopt.getopt(argv,"hi:",["infile="])
    except getopt.GetoptError:
        print 'prepData.py -i <inputfile>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'prepData.py -i <inputfile>'
            print ''
            sys.exit(1)
        elif opt in ("-i", "--ifile"):
            infile = arg
    prepare_data(infile)

if __name__ == "__main__":
  main(sys.argv[1:])
