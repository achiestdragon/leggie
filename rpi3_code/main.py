#!/usr/bin/env python
#
# ****************************************************************************
# * main.py      main robot control program for leggie hexapod               *
# ****************************************************************************
# * version  1.0a                                              15th feb 2018 *
# ****************************************************************************
# *      (c)2018 & written by  David Powell  (A.K.A AchiestDragon)           *
# ****************************************************************************
#  license  GPL v3 
#
#     !!!!!!!!!!!!!!! THIS IS ALPHA CODE AND NOT COMPLETE !!!!!!!!!!!!!!!!
#
# description :-
#
#  WORK IN PROGRESS NOT YET FUNCIONAL 
#
# TODO:-   almost everything
#
#   1. add serial stream decode check and code to sort out whats
#      on what port  
#   
#   2. add code for leg position data ie current positions and
#      next position walking sequence buffers and exceptions
#
#   3. add code for calculating direction movements to new footing
#      positions and calculate the walking gate sequence from 
#      direction inputs to feed into the walking sequence buffers
#
#   4. fixed sequence movements and other sequencing code    
#
#   5. ...all the other things 
#
# FIXME:- 
#
#   1. get arduino nanos to respond to #n commands from this code
#      the joystick responds but they are not doing 
#
#   2. seems the attempt to trap port not found fails to trap and
#      the program errors out 
#
#   
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
    
    #
    # config serial ports
    #
    
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
    
    #
    # start serial read threads 
    #
    
    srl_in_q = Queue.Queue()
    threads = []
    for i in range(3):
        t = threading.Thread(target=worker, args=(i,srl_in_q))
        threads.append(t)
        t.start()
        
    #
    # serial write #9 to get status of each device attached
    #
    
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
        # just output serial messages here for now while testing this bit
        print srl_in_q.get()
    return
# ****************************************************************************
#
# code starts running here 
#

Main()

#
# end of file
#
# ****************************************************************************
