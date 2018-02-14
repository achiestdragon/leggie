#!/usr/bin/env python

# ****************************************************************************
# * srlpy.py test python script to read from all usb connected arduino nanos *
# ****************************************************************************
# *      (c)2018 & written by  David Powell  (A.K.A AchiestDragon)           *
# ****************************************************************************
#  license  GPL v3 
#
# description :-
#
# a test python script for calibration and diagnostics of the serial data
# from multiple arduino nano's connected on separate usb ports 
#
# concurrent read lines from serial ports:-
#   /dev/ttyUSB0
#   /dev/ttyUSB1
#   /dev/ttyUSB2
#   /dev/ttyUSB3
#
# and prints them to the console 
#
# notes :- 
#
#  if a serial port is not available that thread will exit with an error
#  but the other threads will continue to run regardless 
#  ctrl+z to exit 
#

import threading
import time
import serial


def worker(num):
    if num == 0:
        print 'Serial Read Worker: 1 port = /dev/ttyUSB0'
        ser0 = serial.Serial(
         port='/dev/ttyUSB0',
         baudrate = 9600,
         parity=serial.PARITY_NONE,
         stopbits=serial.STOPBITS_ONE,
         bytesize=serial.EIGHTBITS,
         timeout=1
        )
        counter0=0
        while 1:
          x0=ser0.readline()
          print x0  
        return
    if num == 1:
        print 'Serial Read Worker: 2 port = /dev/ttyUSB1'
        ser1 = serial.Serial(
         port='/dev/ttyUSB1',
         baudrate = 9600,
         parity=serial.PARITY_NONE,
         stopbits=serial.STOPBITS_ONE,
         bytesize=serial.EIGHTBITS,
         timeout=1
        )
        counter1=0
        while 1:
          x1=ser1.readline()
          print x1  
        return
    if num == 2:
        print 'Serial Read Worker: 3 port = /dev/ttyUSB2'
        ser2 = serial.Serial(
         port='/dev/ttyUSB2',
         baudrate = 9600,
         parity=serial.PARITY_NONE,
         stopbits=serial.STOPBITS_ONE,
         bytesize=serial.EIGHTBITS,
         timeout=1
        )
        counter=0
        while 1:
          x2=ser2.readline()
          print x2  
        return
    if num == 3:
        print 'Serial Read Worker: 4 port = /dev/ttyUSB3'
        ser3 = serial.Serial(
         port='/dev/ttyUSB3',
         baudrate = 9600,
         parity=serial.PARITY_NONE,
         stopbits=serial.STOPBITS_ONE,
         bytesize=serial.EIGHTBITS,
         timeout=1
        )
        counter=0
        while 1:
          x3=ser3.readline()
          print x3  
        return    
 
 
threads = []
for i in range(4):
    t = threading.Thread(target=worker, args=(i,))
    threads.append(t)
    t.start()
