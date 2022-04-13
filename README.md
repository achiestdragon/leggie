# leggie

a hexapod robot

.    still work in progress not all code completed yet 

.    project suspended , the joystick code works well so is left here for others to use 
      had issues with 3d printed parts snapping , not found a good solution to this 
      so have given up on the project , as well as some other health reasons 
      

# progress:-

hardware build and 3d printed parts :-

.    see README.txt for hardware and printing progress status and notes

.    dc motor version ( current work in progress )

.    3d printing parts of parts 400 hrs total so far 

.    current progress (assembling)

.    TODO:- lots  , add scad/stl parts for upper body&arms

![pic1](https://github.com/achiestdragon/leggie/blob/master/IMG_20180509_050946.jpg)


# code status :-

arduino nano  joystick code :-             USBjoystick1.ino       (c++)= v 1.1b  release

arduino nano  leg drive control code :-    leggie_arduino_pid.ino (c++)= v 1.0a  alpha in progress

..   rewrite pending for dc motor drive rather than pwm servo (will keep this file and add a seperate one

..   for dc motor drive pid   leggie_dc_drive.ini  (c++) = 'pending todo update'


rpi3 serial concurrent test read script :- srlpy.py (python) v 1.0a  a rough but working alpha

raspberry pi3  main control code  :-      main.py (python) v 0.9 in progress not complete

..   basic test code moves legs by joystick and a couple of preprogrammed sequences

see config_guide.txt for software setup and configuration notes
