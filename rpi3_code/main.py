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
# ****************************************************************************
# *                               imports                                    *
# ****************************************************************************
#

import threading
import time
import serial
import Queue

#
# ****************************************************************************
# *                         serial read worker                               *
# ****************************************************************************
#
def srl_worker(num , srl_in_q ):
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

#
# ****************************************************************************
# *                               serial write                               *
# ****************************************************************************
#
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
    #if portnos ==3 :       # commented out as no device causes error
    #    ser3.write('/n')
    #    ser3.write(data)        
    #    ser3.write('/n')
    
    
#
# ****************************************************************************
# *                                                                          *
# ****************************************************************************
#
 
#
# ****************************************************************************
# *                           Main program startup                           *
# ****************************************************************************
# 
def Main():
    global ser0
    global ser1
    global ser2
    global ser3

    # config serial ports
 
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
    """  # commented out as theres nothing on this port  
    #    # as the joystick is not connected on the test robot
    #    # and the in program error handler fails to catch it
    #    # so the program quits
    ser3 = serial.Serial(
        port='/dev/ttyUSB3',
        baudrate = 9600,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        bytesize=serial.EIGHTBITS,
        timeout=1000
    )
    """ #**************************
    
    # start serial read threads 
  
    srl_in_q = Queue.Queue()
    threads = []
    for i in range(3):    # this should be set to 4 if joystick used 
        t = threading.Thread(target=srl_worker, args=(i,srl_in_q))
        threads.append(t)
        t.start()

    # serial write #9 to each port for status of each serial device 
    # ports /dev/ttyUSB0 to 3 and set the leg<n>_port address varibles
    # it also sets the joystick_port varible 
    
    config = 0
    while config == 0 :
        i = 0
        while i <= 4 :
            portnos=0 
            data= "#9"
            srl_write(portnos,data)
            srl_data_in = srl_in_q.get()
            if srl_data_in.startswith('k[#9,[1')==true :  
                leg1_port = 0
                leg2_port = 0
                config = 1
                i = 4
            if srl_data_in.startswith('k[#9,[3')==true :                 
                leg3_port = 0
                leg4_port = 0
                config = 1
                i = 4
            if srl_data_in.startswith('k[#9,[5')==true :    
                leg5_port = 0
                leg6_port = 0
                config = 1
                i = 4
            if srl_data_in.startswith('k[joystick]')==true :
                joystick_port = 0
                config = 1
                i = 4
            i = i + 1
            
    config = 0
    while config == 0 :
        i = 0
        while i <= 4 :
            portnos=1 
            data= "#9"
            srl_write(portnos,data)
            srl_data_in = srl_in_q.get()
            if srl_data_in.startswith('k[#9,[1')==true :
                leg1_port = 1
                leg2_port = 1
                config = 1
                i = 4
            if srl_data_in.startswith('k[#9,[3')==true :              
                leg3_port = 1
                leg4_port = 1
                config = 1
                i = 4
            if srl_data_in.startswith('k[#9,[5')==true :
                leg5_port = 1
                leg6_port = 1
                config = 1
                i = 4
            if srl_data_in.startswith('k[joystick]')==true :
                joystick_port = 1
                config = 1
                i = 4 
            i = i + 1
            
    config = 0
    while config == 0 :
        i = 0
        while i <= 4 :
            portnos=2 
            data= "#9"
            srl_write(portnos,data)
            srl_data_in = srl_in_q.get()
            if srl_data_in.startswith('k[#9,[1')==true :
                leg1_port = 2
                leg2_port = 2
                config = 1
                i = 4
            if srl_data_in.startswith('k[#9,[3')==true :            
                leg3_port = 2
                leg4_port = 2
                config = 1
                i = 4
            if srl_data_in.startswith('k[#9,[5')==true :
                leg5_port = 2
                leg6_port = 2
                config = 1
                i = 4
            if srl_data_in.startswith('k[joystick]')==true :
                joystick_port = 2
                config = 1
                i = 4
            i = i + 1
            
    config = 0
    while config == 0 :
        i = 0
        while i <= 4 :
            portnos=3 
            data= "#9"
            srl_write(portnos,data)
            srl_data_in = srl_in_q.get()
            if srl_data_in.startswith('k[#9,[1')==true :
                leg1_port = 3
                leg2_port = 3
                config = 1
                i = 4
            if srl_data_in.startswith('k[#9,[3')==true :             
                leg3_port = 3
                leg4_port = 3
                config = 1
                i = 4
            if srl_data_in.startswith('k[#9,[5')==true :
                leg5_port = 3
                leg6_port = 3
                config = 1
                i = 4
            if srl_data_in.startswith('k[joystick]')==true :
                joystick_port = 3
                config = 1
                i = 4                
            i = i + 1
            
    
    # just output serial messages here and loop ,while testing the code 
    #while 1:    
    #    print srl_in_q.get()
    
    print 'leg1 port = ',leg1_port,'/n'
    print 'leg2 port = ',leg2_port,'/n/n'
    print 'leg3 port = ',leg3_port,'/n'
    print 'leg4 port = ',leg4_port,'/n/n'  
    print 'leg5 port = ',leg5_port,'/n'
    print 'leg6 port = ',leg6_port,'/n/n'
    print 'joystick port = ',joystick_port,'/n'
    
    
    
    
    # should have responce from serial devices and the ports should be set
    # so check there correct or rather fix above so they cannot be incorrect
    # ie cant have 2 legs  0&1 etc
    #  
    # so we need to setup the serial write threads to read the leg<N>.Queue
    # appropriate to whats connected
    
        
        
        
    return

#
# ****************************************************************************
# *                       code starts running here                           *
# ****************************************************************************
#

Main()

#
# ****************************************************************************
# *                              end of file                                 *
# ****************************************************************************
