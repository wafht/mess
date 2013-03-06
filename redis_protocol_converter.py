#!/usr/bin/env python
#-*- coding: utf8 -*

import sys
import re 

for line in sys.stdin:
    line = line.strip()
    protocol ="*" 
    args = re.split(r'\s+', line)
    protocol+= str(len(args)) + '\r\n'
    for arg in args:
        protocol += "$" + str(len(arg.decode('utf-8').encode("utf-8"))) + '\r\n' + arg + '\r\n'

    sys.stdout.write(protocol)
