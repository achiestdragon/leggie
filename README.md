# leggie

a hexapod robot

.    still work in progress not all code completed yet 

.    major hardware design change update in progress 

# progress:-

hardware build and 3d printed parts :-

.    scad & stl files for 3d printed parts  !! major rework in progress

.    changing drives from mg996r servos to rs775 dc motors as the servos are under powered 

.    see README.txt for hardware and printing progress status and notes

![pic1](https://lh3.googleusercontent.com/-5JN2nPmkK0I/WoS32gn13_I/AAAAAAAABls/yhc50X_s0GkQThyo7ScWCl8HOlUzFeV-QCL0BGAs/w530-d-h298-n-rw/20180210_155444.jpeg)

# code status :-

arduino nano  joystick code :-             USBjoystick1.ino       (c++)= v 1.1b  release

arduino nano  leg drive control code :-    leggie_arduino_pid.ino (c++)= v 1.0a  alpha in progress

..   rewrite pending for dc motor drive rather than pwm servo (will keep this file and add a seperate one

..   for dc motor drive pid   leggie_dc_drive.ini  (c++) = 'pending todo update'


rpi3 serial concurrent test read script :- srlpy.py (python) v 1.0a  a rough but working alpha

raspberry pi3  main control code  :-      main.py (python) v 0.9 in progress not complete

..   basic test code moves legs by joystick and a couple of preprogrammed sequences

see config_guide.txt for software setup and configuration notes
