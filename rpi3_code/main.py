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
#  WORK IN PROGRESS NOT YET FUNCTIONAL 
#
# TODO:-   almost everything
#
#   
#   1. add code for leg position data ie current positions and
#      next position walking sequence buffers and movement exception handlers
#
#   2. add code for calculating direction movements to new footing
#      positions and calculate the walking gate sequence from 
#      direction inputs to feed into the walking sequence buffers
#
#   3. fixed sequence movements and other sequencing code    
#
#   4. ...all the other things 
#
# FIXME:- 
#
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
                if x0 != '':                # ** if not empty line ?
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
                if x0 != '':                # ** if not empty line ?
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
                if x0 != '':                # ** if not empty line ?
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
                if x0 != '':                # ** if not empty line ?
                    srl_in_q.put(x0)
        else:
            slr_in_q.put('E[ser3]')                
        return    

#
# ****************************************************************************
# *                           direct raw serial write                        *
# ****************************************************************************
# 
# used for initial port setup

def srl_write(portnos,data):
    if portnos ==0 :
        data=data + chr(10)        
        ser0.write(data)
        
    if portnos ==1 :
        data=data + chr(10)
        ser1.write(data)
                
    if portnos ==2 :
        data=data + chr(10)
        ser2.write(data)

    if portnos ==3 :       
        data=data + chr(10)
        ser3.write(data)        

    
    
#
# ****************************************************************************
# *                     serial write command queue router                    *
# ****************************************************************************
#
def srl_write_queue_worker( srl_out_q ):
    while 1 :
        d = srl_out_q.get()
        d = d + chr(10)
        if d.startswith('#0')==True :
               
#
# ****************************************************************************
# *                           Main program startup                           *
# ****************************************************************************
# 
def Main():
    
    # ok so there be global's here
    
    global ser0
    global ser1
    global ser2
    global ser3
    global ser0_av 
    global ser1_av 
    global ser2_av 
    global ser3_av 
    global leg1_port
    global leg2_port
    global leg3_port
    global leg4_port
    global leg5_port
    global leg6_port
    global joystick_port

    ser0_av =0
    ser1_av =0
    ser2_av =0
    ser3_av =0    
    
    # configure serial ports
    
    try:
        ser0 = serial.Serial(
            port='/dev/ttyUSB0',
            baudrate = 9600,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS,
            timeout=1000
        )
        ser0_av=1
    except Exception, e:
        print '/dev/ttyUSB0  not found '
    try:
        ser1 = serial.Serial(
            port='/dev/ttyUSB1',
            baudrate = 9600,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS,
            timeout=1000
        )
        ser1_av=1
    except Exception, e:
        print '/dev/ttyUSB1  not found '
    try:
        ser2 = serial.Serial(
            port='/dev/ttyUSB2',
            baudrate = 9600,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS,
            timeout=1000
        )
        ser2_av=1
    except Exception, e:
        print '/dev/ttyUSB2  not found '
    try:
        ser3 = serial.Serial(
            port='/dev/ttyUSB3',
            baudrate = 9600,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS,
            timeout=1000
        )
        ser3_av=1
    except Exception, e:
        print '/dev/ttyUSB3  not found '
    
    # start serial read threads 
  
    srl_in_q = Queue.Queue()
    threads = []
    for i in range(3):    
        t = threading.Thread(target=srl_worker, args=(i,srl_in_q))
        threads.append(t)
        t.start()

    # serial write #9 to each port for status of each serial device 
    # ports /dev/ttyUSB0 to 3, set the leg<n>_port address variables
    # also set the joystick_port variable 
    
    # default values for ports not configured
    
    leg1_port = 99
    leg2_port = 99
    leg3_port = 99
    leg4_port = 99
    leg5_port = 99
    leg6_port = 99
    joystick_port = 99

    if ser0_av==1:    
        config = 0
        while config == 0 :
            i = 0
            while i <= 4 :
                portnos=0 
                data= "#9"
                srl_write(portnos,data)
                srl_data_in = srl_in_q.get()
                print 'port0 #9 response =',srl_data_in
                if srl_data_in.startswith('k[#9,[1')==True :  
                    leg1_port = 0
                    leg2_port = 0
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[#9,[3')==True :                 
                    leg3_port = 0
                    leg4_port = 0
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[#9,[5')==True :    
                    leg5_port = 0
                    leg6_port = 0
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[joystick]')==True :
                    joystick_port = 0
                    config = 1
                    i = 4
                i = i + 1
    if ser1_av==1:            
        config = 0
        while config == 0 :
            i = 0
            while i <= 4 :
                portnos=1 
                data= "#9"
                srl_write(portnos,data)
                srl_data_in = srl_in_q.get()
                print 'port1 #9 response =',srl_data_in
                if srl_data_in.startswith('k[#9,[1')==True :
                    leg1_port = 1
                    leg2_port = 1
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[#9,[3')==True :              
                    leg3_port = 1
                    leg4_port = 1
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[#9,[5')==True :
                    leg5_port = 1
                    leg6_port = 1
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[joystick]')==True :
                    joystick_port = 1
                    config = 1
                    i = 4 
                i = i + 1
    if ser2_av==1:            
        config = 0
        while config == 0 :
            i = 0
            while i <= 4 :
                portnos=2 
                data= "#9"
                srl_write(portnos,data)
                srl_data_in = srl_in_q.get()
                print 'port2 #9 response =',srl_data_in
                if srl_data_in.startswith('k[#9,[1')==True :
                    leg1_port = 2
                    leg2_port = 2
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[#9,[3')==True :            
                    leg3_port = 2
                    leg4_port = 2
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[#9,[5')==True :
                    leg5_port = 2
                    leg6_port = 2
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[joystick]')==True :
                    joystick_port = 2
                    config = 1
                    i = 4
                i = i + 1
    if ser3_av==1:            
        config = 0
        while config == 0 :
            i = 0
            while i <= 4 :
                portnos=3     # need to check if ports available
                data= "#9"
                srl_write(portnos,data)
                srl_data_in = srl_in_q.get()
                print 'port3 #9  response =',srl_data_in
                if srl_data_in.startswith('k[#9,[1')==True :
                    leg1_port = 3
                    leg2_port = 3
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[#9,[3')==True :             
                    leg3_port = 3
                    leg4_port = 3
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[#9,[5')==True :
                    leg5_port = 3
                    leg6_port = 3
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[joystick]')==True :
                    joystick_port = 3
                    config = 1
                    i = 4                
                i = i + 1
                
    #print results  ****  for debug
    print 'leg1 port = ',leg1_port
    print 'leg2 port = ',leg2_port
    print 'leg3 port = ',leg3_port
    print 'leg4 port = ',leg4_port  
    print 'leg5 port = ',leg5_port
    print 'leg6 port = ',leg6_port
    print 'joystick port = ',joystick_port
 
    # should now have response from serial devices and the ports should be set
    # so check there correct
    
    config = 0
    if leg1_port = 99
        print 'ERROR :- leg1 & 2 arduino not found'
    if leg1_port = 99
        print 'ERROR :- leg3 & 4 arduino not found'        
    if leg1_port = 99
        print 'ERROR :- leg5 & 6 arduino not found'
    if leg1_port < 50 and leg3_port < 50 and leg5_port :
        config = 1
        if joystick_port < 50 :
            print 'leg configuration ok , no local serial joystick'
        else :
            print 'leg configuration ok '
            print 'serial joystick connected ok'

            
    
    #  
    # so we need to setup the serial write threads to read the leg<N>.Queue
    # appropriate to whats connected
    
    srl_out_q = Queue.Queue()  

    # for now just output serial messages here and loop ,while testing the code 
    
    while 1 :
        print srl_in_q.get() 
        # but main loop should be here       
        
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
