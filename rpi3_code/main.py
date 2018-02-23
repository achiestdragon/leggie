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
#   1. add support for remote joystick serial connection over 
#        a:-  serial over ip (wifi/ethernet) 
#        b:-  bluetooth
#        c:-  where the joystick has bluetooth dongle fitted
#
#   2. debug code (not all for inclusion in final version but for testing during
#      writing the code) mainly direct servo positon  in relation to joystick
#      position , this code is to be made selectable on the command line >>>
#
#      add the following command line options 
#      >>> j       joystick moves servos directly  (debug code only)
#      >>> v       toggle verbose joystick position data
#      >>> s       toggle verbose serial tx data stream 
#      >>> r       toggle verbose recive serial data
#      >>> d       full leg status for all legs 
#      >>> h       home all legs
#
#   3. add code for calculating direction movements to new footing
#      positions and calculate the walking gate sequence from 
#      direction inputs to feed into the walking sequence buffers
#
#   4. fixed sequence movements and other sequencing code    
#
#   5. ...all the other things 
#
#   6. a gui control interface ? (maybe someday)
#
# FIXME:- 
#
#   1. speed up serial protocol used for servo control (also arduino needs 
#      changing to match ) including:-
#      major changes needed to make the protocol faster
#      changes needed for command responses
#      minor changes to routing  and serial buffering 
#
#      notable changes ,  short messages for quicker tx/rx time
#      no ack messages unless status data is needed
#      removed current/new data buffer  all data is conciddered new on arrival
#      sync is by command arrival and out queue sync
#      make tx multithread on pi for this
#      change foot down detect/stop to seperate instruction to move instruction
#      add move instruction that informs if loss of footing  
#      
#
#   2. should exit if leg ports are not configured 
#

#
# ****************************************************************************
# *                               imports                                    *
# ****************************************************************************
#

import sys
import tty
import termios
import threading
import time
import serial
import Queue

#
# ****************************************************************************
# *                         serial read worker                               *
# ****************************************************************************
#

def srl_worker(num , srl_in_q , ):
    if num == 0:
        print 'Started Serial Read Worker:1 on port : /dev/ttyUSB0'
        counter0=0
        if ser0.isOpen():
            while exit != 1 :
                x0=ser0.readline()
                x0=x0.strip('\r\n')
                if x0 != '':               
                    if x0.startswith('E[1')==True : 
                        print "CRITICAL serial com sync error, from :- /dev/ttyUSB0 with :-",x0 
                        print "program EXIT forced "
                        Exit(1)
                    if x0.startswith('E[2')==True :
                        print "CRITICAL serial com buffer overrun , from :-/dev/ttyUSB0 with :-",x0
                        print "program EXIT forced "
                        Exit(1)
                    if x0.startswith('E[W')==True :
                        print "CRITICAL WTF error , from :-/dev/ttyUSB0 with:-" , x0
                        print "program EXIT forced "
                        Exit(1)
                    if x0.startswith('E[3,')==True :
                        print "ERROR pwm pll lock loss , from :- /dev/ttyUSB0 with :-" , x0
                        srl_in_q.put(x0)
                    if x0.startswith('k')== True :
                        srl_in_q.put(x0)
                    if x0.startswith('f[')== True :
                        srl_in_q.put(x0)
                    if x0.startswith('l[')== True :
                        srl_in_q.put(x0)
                    if x0.startswith('&')== True :
                        print "CRITICAL device in calibration mode from :-/dev/ttyUSB0 "
                        print "with:-" , x0
                        print "program EXIT forced "
                        Exit(1)
                    if x0.startswith('[')== True :  
                        srl_in_q.put(x0)
                    
            print 'Serial Read Worker:1 exit'
        else:
            slr_in_q.put('E[ser0]')
        return 
    if num == 1:
        print 'Started Serial Read Worker:2 on port : /dev/ttyUSB1'
        counter1=0
        if ser1.isOpen():
            while exit != 1 :
                x1=ser1.readline()
                x1=x1.strip('\r\n')
                if x1 != '':               
                    if x1.startswith('E[1')==True :
                        print "CRITICAL serial com sync error, from :- /dev/ttyUSB1 with:-",x1
                        print "program EXIT forced "
                        Exit(1)
                    if x1.startswith('E[2')==True :
                        print "CRITICAL serial com buffer overrun , from :-/dev/ttyUSB1 with:-",x1
                        print "program EXIT forced "
                        Exit(1)
                    if x1.startswith('E[W')==True :
                        print "CRITICAL WTF error , from :-/dev/ttyUSB1 with:-" , x1
                        print "program EXIT forced "
                        Exit(1)
                    if x1.startswith('E[3,')==True :
                        print "ERROR pwm pll lock loss , from :- /dev/ttyUSB1 with :-" , x1
                        srl_in_q.put(x1)
                    if x1.startswith('k')== True :
                        srl_in_q.put(x1)
                    if x1.startswith('f[')== True :
                        srl_in_q.put(x1)
                    if x1.startswith('l[')== True :
                        srl_in_q.put(x1)
                    if x1.startswith('&')== True :
                        print "CRITICAL device in calibration mode from :-/dev/ttyUSB1 "
                        print "with:-" , x1
                        print "program EXIT forced "
                        Exit(1)
                    if x1.startswith('[')== True : 
                        srl_in_q.put(x1)                    

            print 'Serial Read Worker:2 exit'        
        else:
            slr_in_q.put('E[ser1]')                
        return
    if num == 2:
        print 'Started Serial Read Worker:3 on port : /dev/ttyUSB2'
        counter=0
        if ser2.isOpen():
            while exit != 1 :
                x2=ser2.readline()
                x2=x2.strip('\r\n')
                if x2 != '':                
                    if x2.startswith('E[1')==True :
                        print "CRITICAL serial com sync error, from :- /dev/ttyUSB2 with:-",x2
                        print "program EXIT forced "
                        Exit(1)
                    if x2.startswith('E[2')==True :
                        print "CRITICAL serial com buffer overrun , from :-/dev/ttyUSB2 with:-",x2
                        print "program EXIT forced "
                        Exit(1)
                    if x2.startswith('E[W')==True :
                        print "CRITICAL WTF error , from :-/dev/ttyUSB2 with:-" , x2
                        print "program EXIT forced "
                        Exit(1)
                    if x2.startswith('E[3,')==True :
                        print "ERROR pwm pll lock loss , from :- /dev/ttyUSB2 with :-" , x2
                        srl_in_q.put(x2)
                    if x2.startswith('k')== True :
                        srl_in_q.put(x2)
                    if x2.startswith('f[')== True :
                        srl_in_q.put(x2)
                    if x2.startswith('l[')== True :
                        srl_in_q.put(x2)
                    if x2.startswith('&')== True :
                        print "CRITICAL device in calibration mode from :-/dev/ttyUSB2 "
                        print "with :- " , x2
                        print "program EXIT forced "
                        Exit(1)
                    if x2.startswith('[')== True : 
                        srl_in_q.put(x2)                    

            print 'Serial Read Worker:3 exit'
        else:
            slr_in_q.put('E[ser0]')                
        return
    if num == 3:
        print 'Started Serial Read Worker:4 on port : /dev/ttyUSB3'
        counter=0
        if ser3.isOpen():
            while exit != 1 :
                x3=ser3.readline()
                x3=x3.strip('\r\n')
                if x3 != '':                
                    if x3.startswith('E[1')==True :
                        print "CRITICAL serial com sync error, from :- /dev/ttyUSB3 with:-",x3
                        print "program EXIT forced "
                        Exit(1)
                    if x3.startswith('E[2')==True :
                        print "CRITICAL serial com buffer overrun , from :-/dev/ttyUSB3 with:-",x3
                        print "program EXIT forced "
                        Exit(1)
                    if x3.startswith('E[W')==True :
                        print "CRITICAL WTF error , from :-/dev/ttyUSB3 with:-" , x3
                        print "program EXIT forced "
                        Exit(1)
                    if x3.startswith('E[3,')==True :
                        print "ERROR pwm pll lock loss , from :- /dev/ttyUSB3 with :-" , x3
                        srl_in_q.put(x3)
                    if x3.startswith('k')== True :
                        srl_in_q.put(x3)
                    if x3.startswith('f[')== True :
                        srl_in_q.put(x3)
                    if x3.startswith('l[')== True :
                        srl_in_q.put(x3)
                    if x3.startswith('&')== True :
                        print "CRITICAL device in calibration mode from :-/dev/ttyUSB3 "
                        print "with:-" , x3
                        print "program EXIT forced "
                        Exit(1)
                    if x3.startswith('[')== True : 
                        srl_in_q.put(x3)

            print 'Serial Read Worker:4 exit'
        else:
            slr_in_q.put('E[ser3]')                
        return    

#
# ****************************************************************************
# *                           direct raw serial write                        *
# ****************************************************************************
# 
# used for initial port routing setup only
# sends data to port portnos

def srl_write(portnos,data):
    if portnos ==0 :
        data=data + chr(10)   
        try :
            ser0.write(data)
        except Exception ,e:
            print'port write to /dev/ttyUSB0 device not present'
    if portnos ==1 :
        data=data + chr(10)
        try :
            ser1.write(data)
        except Exception ,e:
            print'port write to /dev/ttyUSB1 device not present'
    if portnos ==2 :
        data=data + chr(10)
        try :
            ser2.write(data)
        except Exception ,e:
            print'port write to /dev/ttyUSB2 device not present'
    if portnos ==3 :       
        data=data + chr(10)
        try :
            ser3.write(data)
        except Exception ,e:
            print'port write to /dev/ttyUSB3 device not present'        

    
    
#
# ****************************************************************************
# *                   serial write command queue and router                  *
# ****************************************************************************
#

# reads command queue , and directs data to appropriate port

def srl_write_queue_worker( srl_out_q, ):
    print 'serial write router Worker : startup'
    while exit != 1 :
        d = srl_out_q.get()
        wp1 = 99
        wp2 = 99
        wp3 = 99
        if d != '' :
            d = d + chr(10)
            if d.startswith('#,')==True :   # data to all leg ports
                # patched in so writes position data to all ports 
                wp1 = leg1_port             # also  leg2_port
                wp2 = leg3_port             # also  leg4_port
                wp3 = leg5_port             # also  leg6_port
            
            # code below other than #9 redundant (protocol change)
            if d.startswith('#1')==True :   # data to individual leg port
                if d.startswith('#1[1'):
                    wp1 = leg1_port
                if d.startswith('#1[2'):
                    wp1 = leg2_port
                if d.startswith('#1[3'):
                    wp1 = leg3_port
                if d.startswith('#1[4'):
                    wp1 = leg4_port
                if d.startswith('#1[5'):
                    wp1 = leg5_port
                if d.startswith('#1[6'):
                    wp1 = leg6_port
            if d.startswith('#2')==True :   # data to all leg ports
                wp1 = leg1_port             # also  leg2_port
                wp2 = leg3_port             # also  leg4_port
                wp3 = leg5_port             # also  leg6_port
            if d.startswith('#3')==True :   # data to all leg ports
                wp1 = leg1_port             # also  leg2_port
                wp2 = leg3_port             # also  leg4_port
                wp3 = leg5_port             # also  leg6_port
            if d.startswith('#4')==True :   # data to all odd leg ports
                wp1 = leg1_port
                wp2 = leg3_port
                wp3 = leg5_port
            if d.startswith('#5')==True :   # data to all even leg ports
                wp1 = leg2_port
                wp2 = leg4_port
                wp3 = leg6_port
            if d.startswith('#6')==True :   # data to individual leg port
                if d.startswith('#1[1'):
                    wp1 = leg1_port
                if d.startswith('#1[2'):
                    wp1 = leg2_port
                if d.startswith('#1[3'):
                    wp1 = leg3_port
                if d.startswith('#1[4'):
                    wp1 = leg4_port
                if d.startswith('#1[5'):
                    wp1 = leg5_port
                if d.startswith('#1[6'):
                    wp1 = leg6_port                
            if d.startswith('#7')==True :   # data to all leg ports
                wp1 = leg1_port             # also  leg2_port
                wp2 = leg3_port             # also  leg4_port
                wp3 = leg5_port             # also  leg6_port
            if d.startswith('#8')==True :   # data to all leg ports
                wp1 = leg1_port             # also  leg2_port
                wp2 = leg3_port             # also  leg4_port
                wp3 = leg5_port             # also  leg6_port
            if d.startswith('#9')==True :   # data to all leg ports
                wp1 = leg1_port             # also  leg2_port
                wp2 = leg3_port             # also  leg4_port
                wp3 = leg5_port             # also  leg6_port

            if wp1 == 0  or wp2 == 0 or wp3 == 0 : # if data for /dev/ttyUSB0
                ser0.write(d)
            if wp1 == 1  or wp2 == 1 or wp3 == 1 : # if data for /dev/ttyUSB1
                ser1.write(d)
            if wp1 == 2  or wp2 == 2 or wp3 == 2 : # if data for /dev/ttyUSB2
                ser2.write(d)
            if wp1 == 3  or wp2 == 3 or wp3 == 3 : # if data for /dev/ttyUSB3
                ser3.write(d)
    print 'Serial write router Worker: exit'
    
#
# ****************************************************************************
# *                          walk main worker thread                         *
# ****************************************************************************
# 

def walk_main_worker(srl_out_q,srl_in_q):
    rdy1 = 1
    rdy2 = 1
    rdy3 = 1
    rdy4 = 1            
    rdy5 = 1
    rdy6 = 1 
    newj = 0
    print 'main walk Worker: startup'
    while exit != 1 :
        # decode input data queue  
        srl_data_in = srl_in_q.get()
        if srl_data_in.startswith("[") == True:
            # joystick data decode
            # format [n,n,n],[n,n,n],[............]
            stsplit = srl_data_in.split('],[')
            sp1 = stsplit[0].strip('[')
            sp2 = stsplit[1].strip(']')
            sbl = stsplit[2].strip(']')
            j1x = int(sp1[0])
            j1y = int(sp1[2])
            j1z = int(sp1[4])
            #  for future use j1t  ** not yet implimented       
            j2x = int(sp2[0])
            j2y = int(sp2[2])
            j2z = int(sp2[4])
            #  for future use j2t  ** not yet implimented
            if sbl.startswith('X'):
                js1b = 1
            else:
                js1b = 0
            sbl = sbl[1:]
            if sbl.startswith('X'):
                js2b = 1
            else:
                js2b = 0
            sbl = sbl[1:]
            if sbl.startswith('X'):
                button1 = 1
            else:
                button1 = 0
            sbl = sbl[1:]
            if sbl.startswith('X'):
                button2 = 1
            else:
                button2 = 0
            sbl = sbl[1:]
            if sbl.startswith('X'):
                button3 = 1
            else:
                button3 = 0
            sbl = sbl[1:]
            if sbl.startswith('X'):
                button4 = 1
            else:
                button4 = 0
            sbl = sbl[1:]
            if sbl.startswith('X'):
                button5 = 1
            else:
                button5 = 0
            sbl = sbl[1:]
            if sbl.startswith('X'):
                button6 = 1
            else:
                button6 = 0
            sbl = sbl[1:]
            if sbl.startswith('X'):
                button7 = 1
            else:
                button7 = 0
            sbl = sbl[1:]
            if sbl.startswith('X'):
                button8 = 1
            else:
                button8 = 0
            sbl = sbl[1:]
            if sbl.startswith('X'):
                button9 = 1
            else:
                button9 = 0
            sbl = sbl[1:]
            if sbl.startswith('X'):
                button10 = 1
            else:
                button10 = 0
            newj = 1    
            #
            #*****************************************************************
            #         debug code  
            #
            # joystick x1 = hip servos
            # joystick y1 = leg servos
            # joystick x2 = knee servos
            # move hip, leg and knee servos to joystick position 
            #
            #if rdy1==1 and rdy2==1 and rdy3==1 and rdy4==1 and rdy5==1 and rdy6==1 and newj==1:
            #if newj == 1:    
            #test print of joystick decoded values
            #print 'x1=',j1x,'y1=',j1y,'z1=',j1z,'; x2=',j2x,'y2=',j2y,'z2=',j2z,'sbl =',js1b , js2b , button1,button2,button3,button4,button5,button6,button7,button8,button9,button10
 
            # servo movement, joystick to servo movement command string encode
            # #1[n,t,hhh,lll,kkk] command string encode
            # scale joystick input data 
            if j1z == 0:
                hhh = "010"
            if j1z == 1:
                hhh = "020"
            if j1z == 2:
                hhh = "040"
            if j1z == 3:
                hhh = "060"
            if j1z == 4:
                hhh = "080"
            if j1z == 5:
                hhh = "110"
            if j1z == 6:
                hhh = "130"
            if j1z == 7:
                hhh = "160"
            if j1z == 8:
                hhh = "170"

            if j1y == 0:
                lll = "010"
            if j1y == 1:
                lll = "020"
            if j1y == 2:
                lll = "040"
            if j1y == 3:
                lll = "060"
            if j1y == 4:
                lll = "080"
            if j1y == 5:
                lll = "110"
            if j1y == 6:
                lll = "130"
            if j1y == 7:
                lll = "160"
            if j1y == 8:
                lll = "170"

            if j1x == 0:
                kkk = "010"
            if j1x == 1:
                kkk = "020"
            if j1x == 2:
                kkk = "040"
            if j1x == 3:
                kkk = "060"
            if j1x == 4:
                kkk = "080"
            if j1x == 5:
                kkk = "110"
            if j1x == 6:
                kkk = "130"
            if j1x == 7:
                kkk = "160"
            if j1x == 8:
                kkk = "170"
            #hhh = '0'+str(j1z)+'0'
            #hhh = hhh.strip(' ')
            #lll = '0'+str(j1y)+'0'
            #lll = lll.strip(' ')
            #kkk = '0'+str(j1x)+'0'
            #kkk = kkk.strip(' ')
            # send to all legs
            #  "#,hhh,lll,kkk,hhh,lll,kkk,"
            outstr = '#,'+hhh+','+lll+','+kkk+','+hhh+','+lll+','+kkk+','
            srl_out_q.put(outstr)
            newj = 0
            
        #           end of debug code
        #*****************************************************************
        #
            
        #if srl_data_in.startswith('E[3'): # error leg pwm pll loss exception
            
            #TODO:- 
            #ok so decode and set appropriate data and update exception status
            # in this case a leg servo has moved out of its hold range so 
            # something needs to be done to keep the robot balanced and stable
            
        #if srl_data_in.startswith('f['):  # footing state change update
            
            #TODO:-
            # determine if foot up or down
            #if down then theres extra data depending on if the tag value is 
            #  >= or < 5  if greater then the leg will keep moving to the
            # given position if less then a #3 stop command needs to be sent
            # followed by a #9 position status
            # the next positions can be calculated and updated so the robot 
            # can continue but remember that the robot will try to lift
            # idealy the command seq should be down till footing then stop 
            # wait for all legs in that seq to get footing then down till needed
            # lift height so the robot remains level  

            #if up then it needs to check that a foot thats supposed to be 
            # down has not slipped and lost its footing
            # if so then this needs new sequence data to compensate
            
        #if srl_data_in.startswith('l[1'):  # leg1 moved and ready
            #rdy1 = 1
        #if srl_data_in.startswith('l[2'):  # leg2 moved and ready
            #rdy2 = 1            
        #if srl_data_in.startswith('l[3'):  # leg3 moved and ready
            #rdy3 = 1 
        #if srl_data_in.startswith('l[4'):  # leg4 moved and ready
            #rdy4 = 1
        #if srl_data_in.startswith('l[5'):  # leg5 moved and ready
            #rdy5 = 1            
        #if srl_data_in.startswith('l[6'):  # leg6 moved and ready
            #rdy6 = 1
            
            #TODO:-
            # decode the leg , if all legs in that sequence are ready then
            # issue a #2 followed by a preload for next position
            
        #if srl_data_in.startswith('k[#'): # command ack
            
            #TODO:-
            # flag appropriate sequence pipe task state 
            
            
    print 'main walk Worker: exit'

#
# ****************************************************************************
# *                           error global update                            *
# ****************************************************************************
# 
def Exit(exit_val):
    global exit
    exit = exit_val
#
# ****************************************************************************
# *                           Main program startup                           *
# ****************************************************************************
# 
def Main():
    
    # global's
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

    # global joystick data values
    global j1x 
    global j1y 
    global j1z 
    #global j1t  # reserved for future use not yet implimented
    global j2x 
    global j2y 
    global j2z 
    #global j2t  # reserved for future use not yet implimented
    global js1b 
    global js2b 
    global button1 
    global button2 
    global button3 
    global button4 
    global button5 
    global button6 
    global button7 
    global button8 
    global button9 
    global button10
    
    #global rdy1
    #global rdy2
    #global rdy3
    #global rdy4
    #global rdy5
    #global rdy6
    
    Exit(0)
    ser0_av =0
    ser1_av =0
    ser2_av =0
    ser3_av =0    
 
    print '******************************************************************'
    print '*                          L E G G I E                           *'
    print '******************************************************************'
    print '* Main control       written by David Powell A.k.a AchiestDragon *'
    print '* version 1.0 alpha               revision date date 20 feb 2018 *'
    print '******************************************************************'
    print 'run time commands :-'
    print '     q  = quit '
    print ' ----------------------------------------------------------------'
    print '\nserial port configure :-'

    
    # configure serial ports
    
    try:
        ser0 = serial.Serial(
            port='/dev/ttyUSB0',
            baudrate = 115200,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS,
            timeout=2
        )
        ser0_av=1
    except Exception, e:
        print '/dev/ttyUSB0  not found '
    try:
        ser1 = serial.Serial(
            port='/dev/ttyUSB1',
            baudrate = 115200,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS,
            timeout=2
        )
        ser1_av=1
    except Exception, e:
        print '/dev/ttyUSB1  not found '
    try:
        ser2 = serial.Serial(
            port='/dev/ttyUSB2',
            baudrate = 115200,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS,
            timeout=2
        )
        ser2_av=1
    except Exception, e:
        print '/dev/ttyUSB2  not found '
    try:
        ser3 = serial.Serial(
            port='/dev/ttyUSB3',
            baudrate = 115200,
            parity=serial.PARITY_NONE,
            stopbits=serial.STOPBITS_ONE,
            bytesize=serial.EIGHTBITS,
            timeout=2
        )
        ser3_av=1
    except Exception, e:
        print '/dev/ttyUSB3  not found '
    
    # start serial read threads 
  
    srl_in_q = Queue.Queue()
    threads = []
    for i in range(4):    
        t = threading.Thread(target=srl_worker, args=(i,srl_in_q,))
        threads.append(t)
        t.start()

    # setup serial routing and leg port allocations
    
    # serial write #9 to each port for status of each serial device 
    # ports /dev/ttyUSB0 to 3, set the leg<n>_port address variables
    # also set the joystick_port variable 
    
    # initial values for ports not configured
    
    leg1_port = 99
    leg2_port = 99
    leg3_port = 99
    leg4_port = 99
    leg5_port = 99
    leg6_port = 99
    joystick_port = 99

    print '\ninitializing arduino nano leg control devices :-\n'
    # wait 1 second
    old_time = time.time()
    waiting = 1
    while waiting == 1:
        if time.time() - old_time > 1:
            old_time = time.time()
            waiting = 0     
    # configure whats on port dev/ttyUSB0
    while not srl_in_q.empty():
        try:
            srl_in_q.get(False)
        except Empty:
            continue
        srl_in_q.task_done()
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
                if srl_data_in.startswith('k#9,[1')==True :  
                    leg1_port = 0
                    leg2_port = 0
                    config = 1
                    i = 4
                if srl_data_in.startswith('k#9,[3')==True :                 
                    leg3_port = 0
                    leg4_port = 0
                    config = 1
                    i = 4
                if srl_data_in.startswith('k#9,[5')==True :    
                    leg5_port = 0
                    leg6_port = 0
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[joystick]')==True :
                    joystick_port = 0
                    config = 1
                    i = 4
                i = i + 1
            if config == 0 :
                print "/dev/ttyUSB0 device not configured (got bad/no response)"
                config = 1

    # wait 1 second
    old_time = time.time()
    waiting = 1
    while waiting == 1:
        if time.time() - old_time > 1:
            old_time = time.time()
            waiting = 0 
 
    # configure whats on port dev/ttyUSB1
    
    while not srl_in_q.empty():
        try:
            srl_in_q.get(False)
        except Empty:
            continue
        srl_in_q.task_done()    
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
                if srl_data_in.startswith('k#9,[1')==True :
                    leg1_port = 1
                    leg2_port = 1
                    config = 1
                    i = 4
                if srl_data_in.startswith('k#9,[3')==True :              
                    leg3_port = 1
                    leg4_port = 1
                    config = 1
                    i = 4
                if srl_data_in.startswith('k#9,[5')==True :
                    leg5_port = 1
                    leg6_port = 1
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[joystick]')==True :
                    joystick_port = 1
                    config = 1
                    i = 4 
                i = i + 1
            if config == 0 :
                print "/dev/ttyUSB1 device not configured (got bad/no response)"
                config = 1

    # wait 1 second
    old_time = time.time()
    waiting = 1
    while waiting == 1:
        if time.time() - old_time > 1:
            old_time = time.time()
            waiting = 0 
            
    # configure whats on port dev/ttyUSB2
    
    while not srl_in_q.empty():
        try:
            srl_in_q.get(False)
        except Empty:
            continue
        srl_in_q.task_done()    
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
                if srl_data_in.startswith('k#9,[1')==True :
                    leg1_port = 2
                    leg2_port = 2
                    config = 1
                    i = 4
                if srl_data_in.startswith('k#9,[3')==True :            
                    leg3_port = 2
                    leg4_port = 2
                    config = 1
                    i = 4
                if srl_data_in.startswith('k#9,[5')==True :
                    leg5_port = 2
                    leg6_port = 2
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[joystick]')==True :
                    joystick_port = 2
                    config = 1
                    i = 4
                i = i + 1
            if config == 0 :
                print "/dev/ttyUSB2 device not configured (got bad/no response)"
                config = 1 
                
    # wait 1 second
    old_time = time.time()
    waiting = 1
    while waiting == 1:
        if time.time() - old_time > 1:
            old_time = time.time()
            waiting = 0  
            
    # configure whats on port dev/ttyUSB3
    
    while not srl_in_q.empty():
        try:
            srl_in_q.get(False)
        except Empty:
            continue
        srl_in_q.task_done()   
    if ser3_av==1:
        config = 0
        while config == 0 :
            i = 0
            while i <= 4 :
                portnos=3 
                data= "#9"
                srl_write(portnos,data)
                srl_data_in = srl_in_q.get()
                print 'port3 #9  response =',srl_data_in
                if srl_data_in.startswith('k#9,[1')==True :
                    leg1_port = 3
                    leg2_port = 3
                    config = 1
                    i = 4
                if srl_data_in.startswith('k#9,[3')==True :             
                    leg3_port = 3
                    leg4_port = 3
                    config = 1
                    i = 4
                if srl_data_in.startswith('k#9,[5')==True :
                    leg5_port = 3
                    leg6_port = 3
                    config = 1
                    i = 4
                if srl_data_in.startswith('k[joystick]')==True :
                    joystick_port = 3
                    config = 1
                    i = 4                
                i = i + 1
            if config == 0 :
                print "/dev/ttyUSB3 device not configured (got bad/no response)"
                config = 1                
    # print status for serial devices found

    print '\nconfigure device data routing :-'
    config = 0
    if leg1_port == 99 :
        print 'ERROR :- leg1 & 2 arduino not found'   # FIXME :- add force exit gracefully for this
        Exit(1)
    if leg3_port == 99 :
        print 'ERROR :- leg3 & 4 arduino not found'   # FIXME :- add force exit gracefully for this 
        Exit(1)
    if leg5_port == 99 :
        print 'ERROR :- leg5 & 6 arduino not found'   # FIXME :- add force exit gracefully for this
        Exit(1)
    if leg1_port < 6 and leg3_port < 6 and leg5_port < 6:
        config = 1
        if joystick_port == 99 :
            print 'leg configuration ok ' 
            print 'no local serial joystick found'
        else :
            print 'leg configuration ok '
            print 'serial joystick connected ok'
    
     
    # wait 1 second for serial queue to settle 
    
    old_time = time.time()
    waiting = 1
    while waiting == 1:
        if time.time() - old_time > 1:
            old_time = time.time()
            waiting = 0
            
    # clear srl_in_q
    
    while not srl_in_q.empty():
        try:
            srl_data_in = srl_in_q.get(False)
            #print "rx buffer data dumping ",srl_data_in
        except Empty:
            continue
        srl_in_q.task_done()
        
    # print leg port configuration
    
    print '\ndevice routing patch allocations :-\n'
    print "leg 1    routed to port  /dev/ttyUSB", leg1_port 
    print "leg 2    routed to port  /dev/ttyUSB", leg2_port
    print "leg 3    routed to port  /dev/ttyUSB", leg3_port
    print "leg 4    routed to port  /dev/ttyUSB", leg4_port
    print "leg 5    routed to port  /dev/ttyUSB", leg5_port
    print "leg 6    routed to port  /dev/ttyUSB", leg6_port
    print "joystick routed to port  /dev/ttyUSB", joystick_port
    print ''
    # start the serial write thread 
    
    srl_out_q = Queue.Queue()  
    t = threading.Thread(target=srl_write_queue_worker, args=(srl_out_q,))
    threads.append(t)
    t.start()
    
    # wait for thread to start cleanly
    old_time = time.time()
    waiting = 1
    while waiting == 1:
        if time.time() - old_time > 1:
            old_time = time.time()
            waiting = 0

    # initalize robot to known positions
    
    print '\ninitializing all legs to home positions'
    init_data_command ="#,090,010,010,090,010,010,"
    srl_out_q.put(init_data_command)
    old_time = time.time()
    for c in range(3): # do this with 1 second delay between each 
        waiting = 1
        while waiting == 1:
            if time.time() - old_time > 1:
                old_time = time.time()
                dd = ''
                for cc in range(3):
                   if cc <= c :
                       dd = dd +'###'
                   else :
                       dd = dd +'...'
                progress = '\rprogress =['+dd+']'
                sys.stdout.write( progress )
                sys.stdout.flush()
                waiting = 0
    
    # all robots legs should now be in home position
    
    print '\nDone:- all robot legs should now be in home position\n'
    
    # wait 1 second for serial queue to settle 
    
    old_time = time.time()
    waiting = 1
    while waiting == 1:
        if time.time() - old_time > 1:
            old_time = time.time()
            waiting = 0
    # clear srl_in_q
    
    while not srl_in_q.empty():
        try:
            srl_data_in = srl_in_q.get(False)
            #print "rx buffer data dumping ",srl_data_in
        except Empty:
            continue
        srl_in_q.task_done() 
        
    # start walk main thread 
    
    t = threading.Thread(target=walk_main_worker, args=(srl_out_q,srl_in_q))
    threads.append(t)
    t.start() 
    #


    # console commands just get put into srl_out_q and may clash with 
    # the main walking sequence by joystick control 
    # there provided for debug where the joystick is not connected
    # should fix this 
    
    print '\nrobot startup complete and robot is now active :-\n'
   
    while exit != 1 :
        # main console loop 
        kbd_in = raw_input(">>>")
        if kbd_in == 'q':
            print 'USER COMMAND EXIT ENTERED :- robot shutdown , threads closing '
            Exit(1)

    
    print 'remember to turn off robot servo power '
    # exit program properly   
    
    # send data to sleeping buffers to wake them and let them exit
    
    srl_out_q.put('exit') #send to write queue to get exit from write worker
    srl_in_q.put('exit') # get walker worker to exit 
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
