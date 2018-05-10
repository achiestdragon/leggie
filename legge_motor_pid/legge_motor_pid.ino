// **********************************************************************
// * leggie arduino dc motor control    version 1.0a alpha   6 feb 2018 *
// **********************************************************************
// *      (c) 2018 & written by david powell (aka AchiestDragon)        *
// **********************************************************************
//   licence :-    GPL V3
/*

discription:-

  pid type motor control for leggie6 robot

program opperation 

this code drives the motors on 2 legs 3 motors per leg 

  the code waits for a motor step start pulse on the new input pin from 
  the control logic

  when it resets and starts the motor run timer
  it then reads the analog motor positions for each motor and on a position
  change of one step detected stops that motor
  when all running motors have moved the code outputs a done signal 
  (by checking the motor run state)

  if one or more motors are still running at the defined motor run time
  it will stop them and report a jam condition 

  when ready it outputs the position data for all motors via serial usb

arduino nano pinouts 
--------------------

              usb connector 
d13  run out         hip1 clr out  d12
3v3                  leg1 clr out  d11/pwm
ref                  knee1 clr out d10/pwm
a0   hip1_pot        a off in      d9 /pwm
a1   leg1_pot        new step in   d8
a2   knee1_pot       done out      d7
a3   foot_1          jam out       d6 /pwm
a4   hip2_pot        b off in      d5 /pwm
a5   leg2_pot        hip2 clr out  d4
a6   knee2_pot       leg2 clr out  d3 /pwm
a7   foot_2          knee2 clr out d2
5v                                 gnd
rst                                rst
gnd                  srl tx data   rx0
vin                  srl rx data   tx1
         6 pin isp connector
*/
  
// TODO:-  write code for this
// work in progress not functional yet 
  
   
void setup() {
  // put your setup code here, to run once:

}

void loop() {
  // put your main code here, to run repeatedly:

}
