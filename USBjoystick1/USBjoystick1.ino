
// **********************************************************************
// * leggie  dual USB joystick hexapod robot controler (ardunio nano)   *
// **********************************************************************
// * version 1.1b                                    date  3 feb 2018   *
// **********************************************************************
// *        (c) 2018 by david powell  (aka AchiestDragon)               *
// **********************************************************************
//   licence :-  GPL v3.  
//
//  change notes :-
//
//    13 feb 2018 - version number bumped up from 1.0a to 1.0b
//                  first release 
//
//    14 feb 2018 - updated - only output data when new states detected
//                  added - responce to #/n input over serial 
/*
discription :-

 ardunio nano code for the dual USB joystick control pad for the leggie
 hexapod robot project 

 the controler consists of 2 joysticks 
 each (3axis up/down , left/right and turn clockwize/anticlockwise analog
 with a top button) 
 and 10 individual push buttons (momentory push to make)
 provision is provided for 2 optional analog pots , but commented out
 in the code as there currently not implimented by the host software

 the analog values are scailed to the range  0 to 8 with 4 beeing center 
 0 =  -4
 1 =  -3
 2 =  -2
 3 =  -1
 4 =  0
 5 =  +1
 6 =  +2
 7 =  +3
 8 =  +4

 the code outputs :-
 
"[x1p,y1p,z1p],[x2p,y2p,z2p],[js1,js2,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10]/nl"
 
 over usb serial in ascii text at 9600 baud approximatly every 50 ms
 if the state of the inputs have changed
 ie:-
 [4,4,4],[4,4,4],[............]
 
 analog values in range 0 to 8 with 4 beening the normal center position
 switch states . = off   X = on
 
 optionaly if pots for t1 and t2 are used (commented out in the code)
 the ouput data can be in the form :-  
 "[x1p,y1p,z1p],[t1p],[x2p,y2p,z2p],[t2p],[js1,js2,b1,b2,b3,b4,b5,b6,b7,
 b8,b9,b10]/nl"
   ie:-
 [4,4,4],[4],[4,4,4],[4],[............]))

 NOTE this extended format allows for an extra axis or 2 extra analog
 pots , there function is not defined in the current leggie rpi code 

the joysticks are configured as follows in the leggie rpi3 code

left stick :-  
    xy          =   main body tilt 
    z           =   body height
    top button  =   set level ** 

    ** note :-
         sets current xy body tilt as ref level center  
         this function also issues a #9 read status for all legs
         that is echoed to the console for calibration & diagnostics 

right stick :-
    xy          =   walk direction 
    z           =   turn (rotate body)
    top button  =   button function shift 

buttons :-
    1   =   stance normal  
    2   =   stance narrow (crab) leg 1,4 front/back
    3   =   stance narrow (crab) leg 2,5 front/back
    4   =   stance narrow (crab) leg 3,6 front/back
    5   =   home , move legs to home position 
    6   =   curl up , as home but legs folded in on hips
    7   =   highest standing, max height hold position  
    8   =   high walking
    9   =   normal  walking 
    10  =   wide and low (fastest walking position)

    buttons function shift 
    1   =   foot lift height low  ( for flat ground ) 50mm leg lift
    2   =   foot lift height mid  ( for garden lawns ) 150 mm leg lift
    3   =   foot lift height high  ( for rough ground ) 250 mm leg lift 
    4   =   foot lift height extreme ( stair climb mode ) 350mm leg lift
    5   =   seq shy pose
    6   =   seq pull back  wave legs 1&2
    7   =   seq wave odd legs  
    8   =   seq wave even legs
    9   =   seq bob side to side 
    10  =   seq wave leg 6

    optional
    pot 1 /js1t  =  undefined / not currently implimented
    pot 2 /js2t  =  undefined / not currently implimented

if a "#" is recived over serial it will respond with :- "k[joystick]"
other rx data over serial from the rpi is disregarded 


  arduino nano pinouts
------------------------

          usb connector end
d13  j2 button       j1  button    d12
3v3                  button10      d11
ref                  button9       d10
a0   j1_x            button8       d9 
a1   j1_y            button7       d8
a2   j1_z            button6       d7
a3   pot1            button5       d6 
a4   j2_x            button4       d5 
a5   j2_y            button3       d4
a6   j2_z            button2       d3 
a7   pot2            button1       d2
5v                                 gnd
rst                                rst
gnd                  host tx data  rx0
vin                  host rx data  tx1



all button inputs need a 4k7 resistor to ground (pulldown)
each button is connect to 3v3 on one pin and button input on the other

analog pot wireing is   to 5v and gnd and appropriate analog in

notes :- the led l1 on the ardunio lights when js2 button is pressed
 this is as it shares the same i/o pin
 
*/
//
// **********************************************************************
//                                 varibles
// **********************************************************************
// analog input pins

const int j1_x = A4;
const int j1_y = A5;
const int j1_z = A6;
const int pot1 = A7;
const int j2_x = A0;
const int j2_y = A1;
const int j2_z = A2;
const int pot2 = A3;

// button input pins

const int button1 = 2;
const int button2 = 3;
const int button3 = 4;
const int button4 = 5;
const int button5 = 6;
const int button6 = 7;
const int button7 = 8;
const int button8 = 9;
const int button9 = 10;
const int button10 = 11;
const int button11 = 12;
const int button12 = 13;

// button vars
int b1 = 1;
int b2 = 1;
int b3 = 1;
int b4 = 1;
int b5 = 1;
int b6 = 1;
int b7 = 1;
int b8 = 1;
int b9 = 1;
int b10 = 1;
int js1 = 1;
int js2 = 1;

// analog vars
int x1 = 0;
int y1 = 0;
int z1 = 0;
int t1 = 0;
int x2 = 0;
int y2 = 0;
int z2 = 0;
int t2 = 0;

//  scailed analog vars
int x1p = 0;
int y1p = 0;
int z1p = 0;
int t1p = 0;
int x2p = 0;
int y2p = 0;
int z2p = 0;
int t2p = 0;

String outstring_new;
String outstring_old;
String inByte;
String buff;
// **********************************************************************
//                                 initalization 
// **********************************************************************
void setup() {
  
  // initialize the pushbutton pins as inputs:
  pinMode(button1, INPUT);
  pinMode(button2, INPUT);
  pinMode(button3, INPUT);
  pinMode(button4, INPUT);
  pinMode(button5, INPUT);
  pinMode(button6, INPUT);
  pinMode(button7, INPUT);
  pinMode(button8, INPUT);
  pinMode(button9, INPUT);
  pinMode(button10, INPUT);
  pinMode(button11, INPUT);
  pinMode(button12, INPUT); 
  // initialize serial communications at 9600 bps:
  Serial.begin(9600);
}

// **********************************************************************
//                              main code loop
// **********************************************************************
void loop() 
  {
    // read joystick 1 x value , scail and send to serial 
    x1 = analogRead(j1_x);
    x1p = map(x1, 0, 1023, 0, 9);
    if (x1p == 9) { x1p = 8; }
    outstring_new = "[";
    outstring_new = outstring_new + x1p;
    outstring_new = outstring_new + ",";
    delay(2);
    // read joystick 1 y value , scail and send to serial
    y1 = analogRead(j1_y);
    y1p = map(y1, 0, 1023, 0, 9);
    if (y1p == 9) { y1p = 8; }
    outstring_new = outstring_new + y1p;
    outstring_new = outstring_new + ",";
    delay(2);
    // read joystick 1 z value , scail and send to serial
    z1 = analogRead(j1_z);
    z1p = map(z1, 0, 1023, 0, 9);
    if (z1p == 9) { z1p = 8; }
    outstring_new = outstring_new + z1p;
    outstring_new = outstring_new + "],[";
    delay(2);
    // read pot 1 value , scail and send to serial
    /*
    t1 = analogRead(pot1);
    t1p = map(t1, 0, 1023, 0, 9);
    if (t1p == 9) { t1p = 8; }   // scale may need setting 
    outstring_new = outstring_new + t1p;
    outstring_new = outstring_new + "],[";
    delay(2);
    */
    // read joystick 2 x value , scail and send to serial
    x2 = analogRead(j2_x);
    x2p = map(x2, 0, 1023, 0, 9);
    if (x2p == 9) { x2p = 8; }
    outstring_new = outstring_new + x2p;
    outstring_new = outstring_new + ",";
    delay(2);
    // read joystick 2 y value , scail and send to serial
    y2 = analogRead(j2_y);
    y2p = map(y2, 0, 1023, 0, 9);
    if (y2p == 9) { y2p = 8; }
    outstring_new = outstring_new + y2p;
    outstring_new = outstring_new + ",";
    delay(2);
    // read joystick 2 z value , scail and send to serial
    z2 = analogRead(j2_z);
    z2p = map(z2, 0, 1023, 0, 9);
    if (z2p == 9) { z2p = 8; }
    outstring_new = outstring_new + z2p;
    outstring_new = outstring_new + "],[";
    delay(2);
    // read pot 1 value , scail and send to serial
    /*
    t2 = analogRead(pot2);
    t2p = map(t2, 0, 1023, 0, 9);
    if (t2p == 9) { t2p = 8; }   // scale may need setting
    outstring_new = outstring_new + t2p;
    outstring_new = outstring_new + "],[";
    */
    //read joystick 1 button and send to serial
    js1 = digitalRead(button11);
    if (js1 == HIGH) 
      {
        outstring_new = outstring_new + "X";
      } 
    else 
      {
        outstring_new = outstring_new + ".";
      }
    //read joystick 2 button and send to serial
    js2 = digitalRead(button12);
    if (js2 == HIGH)  
      {
        outstring_new = outstring_new + "X";
      } 
    else 
      {
        outstring_new = outstring_new + ".";
      }
    //read button 1 and send to serial
    b1 = digitalRead(button1);
    if (b1 == HIGH)  
      {
        outstring_new = outstring_new + "X";
      } 
    else 
      {
        outstring_new = outstring_new + ".";
      }
    //read button 2 and send to serial
    b2 = digitalRead(button2);
    if (b2 == HIGH)  
      {
        outstring_new = outstring_new + "X";
      } 
    else 
      {
        outstring_new = outstring_new + ".";
      }
    //read button 3 and send to serial
    b3 = digitalRead(button3);
    if (b3 == HIGH)  
      {
        outstring_new = outstring_new + "X";
      } 
    else 
      {
        outstring_new = outstring_new + ".";
      }
    //read button 4 and send to serial
    b4 = digitalRead(button4);
    if (b4 == HIGH)  
      {
        outstring_new = outstring_new + "X";
      } 
    else 
      {
        outstring_new = outstring_new + ".";
      }
    //read button 5 and send to serial
    b5 = digitalRead(button5);
    if (b5 == HIGH)  
      {
        outstring_new = outstring_new + "X";
      } 
    else 
      {
        outstring_new = outstring_new + ".";
      }
    //read button 6 and send to serial
    b6 = digitalRead(button6);
    if (b6 == HIGH)  
      {
        outstring_new = outstring_new + "X";
      } 
    else 
      {
        outstring_new = outstring_new + ".";
      }
    //read button 7 and send to serial
    b7 = digitalRead(button7);
    if (b7 == HIGH)  
      {
        outstring_new = outstring_new + "X";
      } 
    else 
      {
        outstring_new = outstring_new + ".";
      }
    //read button 8 and send to serial
    b8 = digitalRead(button8);
    if (b8 == HIGH)  
      {
        outstring_new = outstring_new + "X";
      } 
    else 
      {
        outstring_new = outstring_new + ".";
      }
    //read button 9 and send to serial
    b9 = digitalRead(button9);
    if (b9 == HIGH)  
      {
        outstring_new = outstring_new + "X";
      } 
    else 
      {
        outstring_new = outstring_new + ".";
      }
    //read button 10 and send to serial
    b10 = digitalRead(button10);
    if (b10 == HIGH)  
      {
        outstring_new = outstring_new + "X";
      } 
    else 
      {
        outstring_new = outstring_new + ".";
      }
    outstring_new = outstring_new + "]";

    if ( outstring_new != outstring_old )
      {
        Serial.println(outstring_new);
        outstring_old = outstring_new;
        outstring_new ="";
      }
    // is there new serial input if so decode and respond
    if (Serial.available())       
      {
        inByte = (char)Serial.read();    
        if (inByte=="#")         
          {
            Serial.println("k[joystick]");
          }
      }
  }
