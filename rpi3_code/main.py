#!/usr/bin/env python
#
# ****************************************************************************
# * main.py    main robot control program for leggie hexapod                 *
# ****************************************************************************
# * version  1.0b                                              15th feb 2018 *
# ****************************************************************************
# *      (c)2018 & written by  David Powell  (A.K.A AchiestDragon)           *
# ****************************************************************************
#  license  GPL v3 
#
# description :-
#
#  WORK IN PROGRESS NOT YET FUNCIONAL OR COMPLEATE 
#
# TODO:-   almost everything
#
# FIXME:- 
#   1. get ardruino nanos to respond to #n commands from this code
#      the joystick responds but they dont 
#

import threading
import time
import serial
import Queue

def worker(num , srl_in_q ):
    if num == 0:
        print 'Started Serial Read Worker:1 on port : /dev/ttyUSB0'
        counter0=0
        if ser0.isOpen():
            while 1:
                x0=ser0.readline()
                srl_in_q.put(x0)
        else:
            slr_in_q.put('E[ser0]')
        return 
    if num == 1:
        print 'Started Serial Read Worker:2 on port : /dev/ttyUSB1'
        counter1=0
        if ser1.isOpen():
            while 1:
                x1=ser1.readline()
                srl_in_q.put(x1)
        else:
            slr_in_q.put('E[ser1]')                
        return
    if num == 2:
        print 'Started Serial Read Worker:3 on port : /dev/ttyUSB2'
        counter=0
        if ser2.isOpen():
            while 1:
                x2=ser2.readline()
                srl_in_q.put(x2)
        else:
            slr_in_q.put('E[ser0]')                
        return
    if num == 3:
        print 'Started Serial Read Worker:4 on port : /dev/ttyUSB3'
        counter=0
        if ser3.isOpen():
            while 1:
                x3=ser3.readline()
                srl_in_q.put(x0)
        else:
            slr_in_q.put('E[ser3]')                
        return    

def srl_write(portnos,data):
    if portnos ==0 :
        ser0.write('/n')        
        ser0.write(data)
        ser0.write('/n')
    if portnos ==1 :
        ser1.write('/n')
        ser1.write(data)
        ser1.write('/n')        
    if portnos ==2 :
        ser2.write('/n')
        ser2.write(data)
        ser2.write('/n')
    #if portnos ==3 :
    #    ser3.write(data)        
    
def Main():
    global ser0
    global ser1
    global ser2
    global ser3
    ser0 = serial.Serial(
        port='/dev/ttyUSB0',
        baudrate = 9600,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        bytesize=serial.EIGHTBITS,
        timeout=1000
    )
    ser1 = serial.Serial(
        port='/dev/ttyUSB1',
        baudrate = 9600,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        bytesize=serial.EIGHTBITS,
        timeout=1000
    )

    ser2 = serial.Serial(
        port='/dev/ttyUSB2',
        baudrate = 9600,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        bytesize=serial.EIGHTBITS,
        timeout=1000
    )
    """
    ser3 = serial.Serial(
        port='/dev/ttyUSB3',
        baudrate = 9600,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        bytesize=serial.EIGHTBITS,
        timeout=1000
    )"""               
    srl_in_q = Queue.Queue()
    threads = []
    for i in range(3):
        t = threading.Thread(target=worker, args=(i,srl_in_q))
        threads.append(t)
        t.start()
    portnos=0 
    data= "#9"
    srl_write(portnos,data)
    portnos=1 
    data= "#9"
    srl_write(portnos,data)
    portnos=2 
    data= "#9"
    srl_write(portnos,data)
    portnos=3 
    data= "#9"
    srl_write(portnos,data)
    while 1:    
        print srl_in_q.get()
    return

Main()
