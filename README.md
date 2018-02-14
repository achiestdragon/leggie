# leggie

a hexapod robot

.    still work in progress not all code completed yet 

# progress:-


hardware build and 3d printed parts :-

.    scad & stl files for 3d printed parts printed =version 1.0a not yet final

.    see README.txt for hardware and printing progress status and notes


# code status :-

arduino nano  joystick code :-            (c++)

.    done tested and working

.    USBjoystick1.ino       = version 1.1b  release

... changed -  only outputs on new stick positions or button changes

... responds to # over serial with #[joystick] for identification

... response times is faster and less serial traffic 

arduino nano  leg drive control code :-   (c++)

.   work in progress

.   leggie_arduino_pid.ino = version 1.0a  alpha not final

.   partialy functional 


raspberry pi3  main control code  :-      (python)

.   work in progress 

.   only serial test script currently 

see config_guide.txt for software setup and configuration notes
