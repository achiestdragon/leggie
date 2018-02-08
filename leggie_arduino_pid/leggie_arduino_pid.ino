// **********************************************************************
// * leggie arduino servo pid control   version 1.0a alpha   6 feb 2018 *
// **********************************************************************
// *      (c) 2018 & written by david powell (aka AchiestDragon)        *
// **********************************************************************
/*

discription:-

pid servo contoler for leggie robot
there are 3 ardunio nano's used in total each controling 2 legs
and all running the same code each set as a different address
by the adr0 and adr1 pins  jumper to gnd 
(pullups set on inputs so a jumper on pin = pull down=0)

adr0  adr1    legs
0     0       1 and 2       ( ardunio 1 )
1     0       3 and 4       ( ardunio 2 )
0     1       5 and 6       ( ardunio 3 )
1     1       calibrate / test mode ,

in calibrate /test mode it returns a extended packet with actual 
adc read values , scaled values and foot status 

the 3 arduino nanos are wired by short usb leads to the onboard 
raspberry pi3 where they also get there power
the pi3 gets its power from one of the 5v 3a regulators that is 
wired before the servo power switch the other regulators wired 
after the switch provide 5v for 4 servos each , only pwm and gnd 
signals go from the arduinos to the servos directly
the pots on each leg are wired between the ardunio 5v and gnd 
with the wipres connected to the appropriate analog in
the foot switch is connected between the same 5v and the input
with a 4k7 pulldown resistor to ground 


arduino nano pinouts 
--------------------

              usb connector 
d13  step_rdy_out    step_rdy_a_in d12
3v3                  hip1_servo    d11/pwm
ref                  leg1_servo    d10/pwm
a0   hip1_pot        knee1_servo   d9 /pwm
a1   leg1_pot        adr1          d8
a2   knee1_pot       adr0          d7
a3   foot_1          hip2_servo    d6 /pwm
a4   hip2_pot        leg2_servo    d5 /pwm
a5   leg2_pot        step_rdy_b_in d4
a6   knee2_pot       knee2_servo   d3 /pwm
a7   foot_2          exception_in  d2
5v                                 gnd
rst                                rst
gnd                  srl tx data   rx0
vin                  srl rx data   tx1
         6 pin isp connector
*/
//
// **********************************************************************
// TODO:-  ( not urgent and can be left )
//
//  add option to invert the read adc values (depending on what direction 
//  the potentiometers are actualy wired if different )
//
//  output pin  step_rdy_out,(d13) also drives an onboad led l1 
//  make use of this as a status led in some form 
//
//
// **********************************************************************
// FIXME:-  ( must be fixed before it will function as intended )
//
//  fix servo lock error message and add tag value
//
//  fix error message formats and codes
//    error = 1  =   ERROR [ com frame sync ]
//    error = 2  =   ERROR [ buffer overrun ]
//
//  add footing loss error 
//  add footing mode for foot loss error
//  
//  finish command input decode   
//
//
// **********************************************************************
//

//
// **********************************************************************
//                                 includes
// **********************************************************************
//

#include <Servo.h>

//
// **********************************************************************
//                                 varibles
// **********************************************************************
//

// analog inputs
const int hip1_pot    = A0;
const int leg1_pot    = A1;
const int knee1_pot   = A2;
const int foot1_pot   = A3;
const int hip2_pot    = A4;
const int leg2_pot    = A5;
const int knee2_pot   = A6;
const int foot2_pot   = A7;

// digital i/o pins 
const int exception_in_pin  = 2;  // ** pin defined but currently unused 
const int knee2_servo_pin   = 3;  // pwm
const int step_rdy_b_in_pin = 4;  // ** pin defined but currently unused
const int leg2_servo_pin    = 5;  // pwm
const int hip2_servo_pin    = 6;  // pwm
const int adr0_pin          = 7;  // input with pull up
const int adr1_pin          = 8;  // input with pull up
const int knee1_servo_pin   = 9;  // pwm
const int leg1_servo_pin    = 10; // pwm
const int hip1_servo_pin    = 11; // pwm
const int step_rdy_a_in_pin = 12; // ** pin defined but currently unused
const int step_rdy_out_pin  = 13; // ** pin defined but currently unused

// varibles  pot read values

int hip1_pos  = 0;
int leg1_pos  = 0;
int knee1_pos = 0;
int foot1_pos = 0;
int hip2_pos  = 0;
int leg2_pos  = 0;
int knee2_pos = 0;
int foot2_pos = 0;

// varibles  pot read values scailed

int hip1_pos_s  = 0;
int leg1_pos_s  = 0;
int knee1_pos_s = 0;
int foot1       = 0;
int hip2_pos_s  = 0;
int leg2_pos_s  = 0;
int knee2_pos_s = 0;
int foot2       = 0;

// last foot state varibles

int foot1_old = 0 ; 
int foot2_old = 0 ;

// new serial data varibles  

int hip1_new  = 0;
int leg1_new  = 0;
int knee1_new = 0;
int hip2_new  = 0;
int leg2_new  = 0;
int knee2_new = 0;

// pwm servo names

Servo hip1_servo;    
Servo leg1_servo;    
Servo knee1_servo;    
Servo hip2_servo;     
Servo leg2_servo;     
Servo knee2_servo;  
 
//  pwm varibles

int hip1_pwm  = 0;
int leg1_pwm  = 0;
int knee1_pwm = 0;
int hip2_pwm  = 0;
int leg2_pwm  = 0;
int knee2_pwm = 0;

// pwm output varibles

int hip1_pwmo  = 0;
int leg1_pwmo  = 0;
int knee1_pwmo = 0;
int hip2_pwmo  = 0;
int leg2_pwmo  = 0;
int knee2_pwmo = 0;

// hold position varibles

int hip1_hold  = 0;       
int leg1_hold  = 0;       
int knee1_hold = 0;      
int hip2_hold  = 0;       
int leg2_hold  = 0;       
int knee2_hold = 0;       

// input pin varibles

//int exception_in  = false;  // **unused
//int step_rdy_b_in = false;  // **unused
int adr0          = false;
int adr1          = false;
//int step_rdy_a_in = false;  // **unused

// output pin varibles

//int step_rdy_out  = false;   //**unused ** this drives a board led
                               // use this as a status led in  some form 
//serial Strings

String inByte    ;
String buff      ;
String nosstr    ;
String tagstr    ;
String hipstr    ;
String legstr    ;
String kneestr   ;
// other varibles

int cal    = false ;
int btag   = 0     ;

// individual servos reached new hold pos 
  
int hip1_rdy   = false ;
int leg1_rdy   = false ;
int knee1_rdy  = false ;
int hip2_rdy   = false ;
int leg2_rdy   = false ;
int knee2_rdy  = false ;

// servos in hold pll lock

int hip1_lock  = false ;
int leg1_lock  = false ;
int knee1_lock = false ;
int hip2_lock  = false ;
int leg2_lock  = false ;
int knee2_lock = false ;

// leg ready all servos reached hold lock 

int rdy1       = false ;
int rdy2       = false ;

// robot leg id varibles

int leg1 = 0 ;
int leg2 = 0 ;

// new sequence tags 

int tag1_new  = 0;
int tag2_new  = 0;

// current hold sequence tag

int tag1_hold = 0;
int tag2_hold = 0;

// error code varible

int error     = 0;

//
// **********************************************************************
//     robot dependant configurtion settings and calibration values 
// **********************************************************************
//     these need to be set depending on your actual robots setup 
// **********************************************************************
//
// servo properties , this defines the working pwm range of all servos
// this should be set to the pwm driven rotational range of movment of 
// the servos  , default 180 degree mg996r servos
   
const int pwm_neg90  =   0 ;  //-90 deg rotation pwm value of servos
const int pwm_pos90  = 255 ;  //-90 deg rotation pwm value of servos

// set so that scaled adc values = servo pwm for the range 
// note :-
// min value should be at least = to backlash value (adc range)
// max value must be 1024 - adc range backlash

const int pot_min    = 90;   // 170 for 180 degree servos
const int pot_max    = 930;  // 850 for 180 degree servos

// change if potentiometer values need inverting
 
const int hip_d = 0  ;  // 0=normal / 1=invert pot read to pwm value
const int leg_d = 0  ;  // 0=normal / 1=invert pot read to pwm value
const int knee_d = 0 ;  // 0=normal / 1=invert pot read to pwm value

//default backlash range read is of 20 (+-10) as read from adc values
//needs scaleing to the pwm range thats = to 1/4 approx = +-2.5
//as it needs to be an int use 3 and add one more so that you have a
// wider pwm lock range  makes it +-4 , use 4 as the values is used
// in eather direction no need to have it signed

const int backlash_range  = 4 ;  //default backlash value 

// unscale this value for note on pot_min & pot_max settings above

//
// **********************************************************************
//                              setup
// **********************************************************************
// this runs once on startup or reset
void setup() 
{
  // define i/o & servo pwm pins 
  
  pinMode(step_rdy_out_pin, OUTPUT);     //  d13 ** defined but unused
  pinMode(step_rdy_a_in_pin, INPUT);     //  d12 ** defined but unused
  hip1_servo.attach(hip1_servo_pin);     //  d11 pwm hip1
  leg1_servo.attach(leg1_servo_pin);     //  d10 pwm leg1
  knee1_servo.attach(knee1_servo_pin);   //  d9  pwm knee1
  pinMode(adr1_pin, INPUT_PULLUP);       //  d8
  pinMode(adr0_pin, INPUT_PULLUP);       //  d7 
  hip2_servo.attach(hip2_servo_pin);     //  d6  pwm hip2
  leg2_servo.attach(leg2_servo_pin);     //  d5  pwm leg2
  pinMode(step_rdy_b_in_pin, INPUT);     //  d4  ** defined but unused
  knee2_servo.attach(knee2_servo_pin);   //  d3  pwm knee2
  pinMode(exception_in_pin, INPUT);      //  d2  ** defined but unused
  
  // initialize serial communications at 9600 bps:
  Serial.begin(9600);

  adr0 = digitalRead(adr0_pin);
  adr1 = digitalRead(adr1_pin); 
  if ( adr0 == 0 )
  {
    if ( adr1 == 0)
    {
      // adr=00   legs 1&2
      leg1 = 1;
      leg2 = 2;
      cal = false ;
    }
    else
    {
      // adr=01   legs 3&4
      leg1 = 3;
      leg2 = 4;
      cal = false ;           
    }
  }
  else
  {
    if ( adr1 == 0)
    {
      // adr=10   legs 5&6
      leg1 = 5;
      leg2 = 6;  
      cal = false ;     
    }
    else
    {
      // adr=11   calibrate/test mode 
      cal = true;
    }
  } 

  // set inital hold values to inital pwm values
  
  hip1_hold  = hip1_pwm ;       
  leg1_hold  = leg1_pwm ;       
  knee1_hold = knee1_pwm;       
  hip2_hold  = hip2_pwm ;       
  leg2_hold  = leg2_pwm ;       
  knee2_hold = knee2_pwm; 

  // set and invert if needed pwmo values 
  if (hip_d == 0)
    {
       hip1_pwmo  =  hip1_pwm  ;
       hip2_pwmo  =  hip2_pwm  ;
     }  
  else 
    {
       hip1_pwmo  = 256 - hip1_pwm  ;
       hip2_pwmo  = 256 - hip2_pwm  ;
     }
  if (leg_d == 0) 
    {
      leg1_pwmo  =  leg1_pwm  ;
      leg2_pwmo  =  leg2_pwm  ;
    }
    else
    {
      leg1_pwmo  = 256 - leg1_pwm  ;
      leg2_pwmo  = 256 - leg2_pwm  ;
    }       
  if (knee_d == 0) 
    {
      knee1_pwmo = knee1_pwm ;       
      knee2_pwmo = knee2_pwm ;      
    }
    else
    {
      knee1_pwmo = 256 - knee1_pwm ;       
      knee2_pwmo = 256 - knee2_pwm ;
    }
  // update pwm i/o values   servo.write(pwmvalout); for all servos
  hip1_servo.write(hip1_pwmo);    
  leg1_servo.write(leg1_pwmo);    
  knee1_servo.write(knee1_pwmo);    
  hip2_servo.write(hip2_pwmo);     
  leg2_servo.write(leg2_pwmo);     
  knee2_servo.write(knee2_pwmo); 
     
}

//
// **********************************************************************
//                               main code loop
// **********************************************************************
// main code , loops forever

void loop() 
{
  // main code :
  if ( cal = false)
  {
    // read adc's for both legs 
    // scale values  read foot status
    // do pwm pll lock and 
    // check ready state for each servo 
    
    //
    //  leg1  read and scale adc pot positions for leg 1
    //
    hip1_pos = analogRead(hip1_pot);
    hip1_pos_s=map(hip1_pos,pot_min,pot_max, pwm_neg90,pwm_pos90);
    delay(2);
    leg1_pos = analogRead(leg1_pot);
    leg1_pos_s=map(leg1_pos,pot_min,pot_max, pwm_neg90,pwm_pos90);
    delay(2);
    knee1_pos = analogRead(knee1_pot);
    knee1_pos_s=map(knee1_pos,pot_min,pot_max, pwm_neg90,pwm_pos90);
    delay(2);

    //
    //foot1 status 
    //
   
    foot1_pos = analogRead(foot1);
    
    if (foot1_pos > 520) 
      { 
        foot1=true;
        if (foot1 !=  foot1_old) //new foot down detected
          {
            foot1_old = foot1;
            Serial.print("f[");
            Serial.print(leg1);
            Serial.print(",d,");
            Serial.print(tag1_hold);
            Serial.print(",");
            Serial.print(hip1_pos_s);
            Serial.print(",");
            Serial.print(leg1_pos_s);
            Serial.print(",");
            Serial.print(knee1_pos_s);
            Serial.print("]");
            hip1_hold  = hip1_pos_s  ;
            leg1_hold  = leg1_pos_s  ;
            knee1_hold = knee1_pos_s ;
            hip1_rdy   = false ;
            leg1_rdy   = false ;
            knee1_rdy  = false ;
            rdy1       = true ;
            hip1_lock  = true ;
            leg1_lock  = true ;
            knee1_lock = true ;
            hip1_pwm   = hip1_hold  ;
            leg1_pwm   = leg1_hold  ;
            knee1_pwm  = knee1_hold ;
          }
      } 
      else
      {
        foot1_old = foot1;
        foot1=false;
        //**Serial.print("u,");
      }

    //
    //  hip1 pwm pll lock and rdy detect
    //  
    if (hip1_hold == hip1_pos_s)
      {
        
        hip1_lock = true; 
        hip1_rdy  = true;
      }
    else
      {
        // hip 1 pll lock dir check and pwm update
        if (hip1_lock == true)
        {
          if ( hip1_pos  >= hip1_hold + backlash_range )  
            {  
              hip1_lock  =false;
              Serial.print("E[hip1lock] "); //**fixme add tag number
            }
          if ( hip1_pos  <= hip1_hold - backlash_range ) 
            {
              hip1_lock  =false;
              Serial.print("E[hip1lock]"); //**fixme add tag number
            }
          // pll lock up/down to hold  
          if (hip1_pos > hip1_hold ) { hip1_pwm=hip1_pwm - 1; }
          if (hip1_pos < hip1_hold ) { hip1_pwm=hip1_pwm + 1; }           
        }
        else
        {
          // still moveing and not ready
        }
      }

    //
    //   leg1 pwm pll lock and rdy detect
    //  
    if (leg1_hold == leg1_pos_s)
      {
        
        leg1_lock = true; 
        leg1_rdy  = true;
      }
    else
      {
        // leg 1 pll lock dir check and pwm update
        if (leg1_lock == true)
        {
          if ( leg1_pos  >= leg1_hold + backlash_range )  
            {  
              leg1_lock  =false;
              Serial.print("E[leg1lock]"); //**fixme add tag number 
            }
          if ( leg1_pos  <= leg1_hold - backlash_range ) 
            {
              leg1_lock  =false;
              Serial.print("E[leg1lock]");  //**fixme add tag number
            }
          // pll lock up/down to hold  
          if (leg1_pos > leg1_hold ) { leg1_pwm=leg1_pwm - 1; }
          if (leg1_pos < leg1_hold ) { leg1_pwm=leg1_pwm + 1; }           
        }
        else
        {
          // still moveing and not ready
        }
      }

    //
    //  knee1 pwm pll lock and rdy detect
    //  
    if (knee1_hold == knee1_pos_s)
      {
        
        knee1_lock = true; 
        knee1_rdy  = true;
      }
    else
      {
        // knee 1 pll lock dir check and pwm update
        if (knee1_lock == true)
        {
          if ( knee1_pos  >= knee1_hold + backlash_range )  
            {  
              knee1_lock  =false;
              Serial.print("E[knee1lock]"); //**fixme add tag number 
            }
          if ( knee1_pos  <= knee1_hold - backlash_range ) 
            {
              knee1_lock  =false;
              Serial.print("E[knee1lock]"); //**fixme add tag number 
            }
          // pll lock up/down to hold  
          if (knee1_pos > knee1_hold ) { knee1_pwm=knee1_pwm - 1; }
          if (knee1_pos < knee1_hold ) { knee1_pwm=knee1_pwm + 1; }           
        }
        else
        {
          // still moveing and not ready
        }
      }     
    if (hip1_rdy==true&leg1_rdy==true&knee1_rdy==true&rdy1==false)
      {    
        // all valid new ready signals
        if (hip1_lock==true&leg1_lock==true&knee1_lock==true)
          {
           // and all locks ok,send status, update rdy 
           Serial.print("l[");
           Serial.print(leg1);
           Serial.print(",r,");
           Serial.print(tag1_hold);
           Serial.println("]"); 
           hip1_rdy  = false ;
           leg1_rdy  = false ;
           knee1_rdy = false ;
           rdy1      =  true ;
          }
        else
          {
            Serial.println("[WTF.1]"); // something realy bad happened 
          }
      }
    //
    //  leg2  read and scale adc pot positions for leg 2
    //
    hip2_pos = analogRead(hip1_pot);
    hip2_pos_s=map(hip2_pos,pot_min,pot_max, pwm_neg90,pwm_pos90);
    delay(2);
    leg2_pos = analogRead(leg2_pot);
    leg2_pos_s=map(leg2_pos,pot_min,pot_max, pwm_neg90,pwm_pos90);
    delay(2);
    knee2_pos = analogRead(knee2_pot);
    knee2_pos_s=map(knee2_pos,pot_min,pot_max, pwm_neg90,pwm_pos90);
    delay(2);

    //
    //foot2 status  
    //
    foot2_pos = analogRead(foot2);
    
    if (foot2_pos > 520) 
      { 
        foot2=true;
        if (foot2 !=  foot2_old) //new foot down detected
          {
            foot2_old = foot2;  
            Serial.print("f[");
            Serial.print(leg2);
            Serial.print(",d,");
            Serial.print(tag2_hold);
            Serial.print(",");
            Serial.print(hip2_pos_s);
            Serial.print(",");
            Serial.print(leg2_pos_s);
            Serial.print(",");
            Serial.print(knee2_pos_s);
            Serial.print("]");
            hip2_hold  = hip2_pos_s  ; 
            leg2_hold  = leg2_pos_s  ;
            knee2_hold = knee2_pos_s ;
            hip2_rdy   = false ;
            leg2_rdy   = false ;
            knee2_rdy  = false ;
            rdy2       = true ;
            hip2_lock  = true ; 
            leg2_lock  = true ;
            knee2_lock = true ;
            hip2_pwm   = hip2_hold  ; 
            leg2_pwm   = leg2_hold  ;
            knee2_pwm  = knee2_hold ;
          }
      } 
      else
      {
        foot2_old = foot2;
        foot2=false;
        //**Serial.print("u,");
      }
    
    //
    //  hip2 pwm pll lock and rdy detect
    //  
    if (hip2_hold == hip2_pos_s)
      {
        
        hip2_lock = true; 
        hip2_rdy  = true;
      }
    else
      {
        // hip 2 pll lock dir check and pwm update
        if (hip2_lock == true)
        {
          if ( hip2_pos  >= hip2_hold + backlash_range )  
            {  
              hip2_lock  =false;
              Serial.println("E[hip2lock]");  //**fixme add tag number
            }
          if ( hip2_pos  <= hip2_hold - backlash_range ) 
            {
              hip2_lock  =false;
              Serial.println("E[hip2lock]");  //**fixme add tag number
            }
          // pll lock up/down to hold  
          if (hip2_pos > hip2_hold ) { hip2_pwm=hip2_pwm - 1; }
          if (hip2_pos < hip2_hold ) { hip2_pwm=hip2_pwm + 1; }           
        }
        else
        {
          // still moveing and not ready
        }
      }

    //
    //   leg2 pwm pll lock and rdy detect
    //  
    if (leg2_hold == leg2_pos_s)
      {
        
        leg2_lock = true; 
        leg2_rdy  = true;
      }
    else
      {
        // leg 2 pll lock dir check and pwm update
        if (leg2_lock == true)
        {
          if ( leg2_pos  >= leg2_hold + backlash_range )  
            {  
              leg2_lock  =false;
              Serial.print("E[leg2lock]");  //**fixme add tag number
            }
          if ( leg2_pos  <= leg2_hold - backlash_range ) 
            {
              leg2_lock  =false;
              Serial.print("E[leg2lock]");  //**fixme add tag number
            }
          // pll lock up/down to hold  
          if (leg2_pos > leg2_hold ) { leg2_pwm=leg2_pwm - 1; }
          if (leg2_pos < leg2_hold ) { leg2_pwm=leg2_pwm + 1; }           
        }
        else
        {
          // still moveing and not ready
        }
      }

    //
    //  knee2 pwm pll lock and rdy detect
    //  
    if (knee2_hold == knee2_pos_s)
      {
        
        knee2_lock = true; 
        knee2_rdy  = true;
      }
    else
      {
        // knee 2 pll lock dir check and pwm update
        if (knee2_lock == true)
        {
          if ( knee2_pos  >= knee2_hold + backlash_range )  
            {  
              knee2_lock  = false;
              Serial.print("E[knee2lock]"); //**fixme add tag number 
            }
          if ( knee2_pos  <= knee2_hold - backlash_range ) 
            {
              knee2_lock  = false;
              Serial.print("E[knee2lock]");  //**fixme add tag number
            }
          // pll lock up/down to hold  
          if (knee2_pos > knee2_hold ) { knee2_pwm=knee2_pwm - 1; }
          if (knee2_pos < knee2_hold ) { knee2_pwm=knee2_pwm + 1; }           
        }
        else
        {
          // still moveing and not ready
        }
      }
    if (hip2_rdy==true&leg2_rdy==true&knee2_rdy==true&rdy2==false)
      {    
        // all valid new ready signals
        if (hip2_lock==true&leg2_lock==true&knee2_lock==true)
          {
           // and all locks ok,send status, update rdy 
           Serial.print("l[");
           Serial.print(leg2);
           Serial.print(",r,");
           Serial.print(tag2_hold);
           Serial.println("]"); 
           hip2_rdy  = false ;
           leg2_rdy  = false ;
           knee2_rdy = false ;
           rdy2      =  true ;   
          }
        else
          {
            Serial.println("E[WTF.2]"); // something realy bad happened 
          }
       }
       
    // read serial
    if (Serial.available())       // new serial data
      {
        inByte = Serial.read();   // read serial
        buff += inByte;           // add char to buffer
       
        if (inByte=='\n')         // is end of line
          {
            //newline detected so decode string
            if (buff.substring(0) == "#") 
              {
                //valid command string detected
                if (buff.substring(0,1) == "#0")  //home
                  {
                  // home all legs direct 
                  // 
                  // to fix  constants for hip,leg,knee home values
                  hip1_new  = 127; // mid
                  leg1_new  = 255; // up full
                  knee1_new = 0;   // down full
                  tag1_new  = 1;   // position  sync id tag
                  hip2_new  = 127; // mid
                  leg2_new  = 255; // up full
                  knee2_new = 0;   // down full
                  tag2_new  = 1;   // position  sync id tag
            
                  hip1_hold  = hip1_new  ;
                  leg1_hold  = leg1_new  ;
                  knee1_hold = knee1_new ;
                  tag1_hold  = tag1_new  ;
                  hip1_rdy   = false ;
                  leg1_rdy   = false ;
                  knee1_rdy  = false ;
                  rdy1       = false ;
                  hip1_lock  = false;
                  leg1_lock  = false;
                  knee1_lock = false;
                  
                  hip2_hold  = hip2_new  ;
                  leg2_hold  = leg2_new  ;
                  knee2_hold = knee2_new ; 
                  tag2_hold  = tag2_new  ;  
                  hip2_rdy   = false ;
                  leg2_rdy   = false ;
                  knee2_rdy  = false ;
                  rdy2       = false ;
                  hip2_lock  = false;
                  leg2_lock  = false;
                  knee2_lock = false;
                
                  buff ="";              // clear buffer
                  error=0;                 
                }
              if (buff.substring(0) == "#1")  //new
                {
                  // new    load new values for hip,leg,knee
                  // for appropriate legs data format :-
                  //
                  // "#1[n,t,hhh,lll,kkk]"
                  //
                  // where :- 
                  //     n   = legnos (1 to 6)
                  //     t   = tag  (1 to 8)
                  //     hhh  = hip val   000 to 255
                  //     lll = leg value 000 to 255
                  //     kkk   = knee value 000 to 255
                  // ** hip,leg and knee values must have leading 0's
                  // and be a 3 chrs fixed lenght
                  //
                  // if leg nos is valid then ack with "k[n,t]"
                  //
                  nosstr=buff.substring(3)      ;
                  tagstr=buff.substring(5)      ;
                  hipstr=buff.substring(7,9)    ;
                  legstr=buff.substring(11,13)  ;
                  kneestr=buff.substring(14,16) ;
                  
                  btag=nosstr.toInt();
                  if (btag == leg1 )
                    {
                      tag1_new  = tagstr.toInt() ;
                      hip1_new  = hipstr.toInt() ;
                      leg1_new  = legstr.toInt() ;
                      knee1_new = kneestr.toInt();
                      Serial.print("k[");
                      Serial.print(leg1);
                      Serial.println(",");
                      Serial.print(tag1_new);
                      Serial.println("]");
                    }
                  
                  if (btag == leg2 )
                    {
                      tag2_new  = tagstr.toInt() ;
                      hip2_new  = hipstr.toInt() ;
                      leg2_new  = legstr.toInt() ;
                      knee2_new = kneestr.toInt();
                      Serial.print("k[");
                      Serial.print(leg2);
                      Serial.println(",");
                      Serial.print(tag2_new);
                      Serial.println("]");                      
                    }
                  buff ="";              // clear buffer
                  error=0;  
                }
              if (buff.substring(0) == "#2")  //next
                {
                  // next   make new values current values
                  // for specified legs
                  hip1_hold  = hip1_new  ;
                  leg1_hold  = leg1_new  ;
                  knee1_hold = knee1_new ;
                  tag1_hold  = tag1_new  ;
                  hip1_rdy   = false ;
                  leg1_rdy   = false ;
                  knee1_rdy  = false ;
                  rdy1       = false ;
                  hip1_lock  = false;
                  leg1_lock  = false;
                  knee1_lock = false;
                  
                  hip2_hold  = hip2_new  ;
                  leg2_hold  = leg2_new  ;
                  knee2_hold = knee2_new ; 
                  tag2_hold  = tag2_new  ;  
                  hip2_rdy   = false ;
                  leg2_rdy   = false ;
                  knee2_rdy  = false ;
                  rdy2       = false ;
                  hip2_lock  = false;
                  leg2_lock  = false;
                  knee2_lock = false;
                  
                  buff ="";              // clear buffer
                  error=0;
                }
              if (buff.substring(0) == "#3")  //stop
                {
                  // stop   sets vurrent read values to hold values
                  // for all legs and pwm pll lock
                  hip1_hold  = hip1_pos_s  ;
                  leg1_hold  = leg1_pos_s  ;
                  knee1_hold = knee1_pos_s ;
                  hip1_rdy   = false ;
                  leg1_rdy   = false ;
                  knee1_rdy  = false ;
                  rdy1       = false ;
                  hip1_lock  = true  ;
                  leg1_lock  = true  ;
                  knee1_lock = true  ;
                  
                  hip2_hold  = hip2_pos_s  ;
                  leg2_hold  = leg2_pos_s  ;
                  knee2_hold = knee2_pos_s ; 
                  hip2_rdy   = false ;
                  leg2_rdy   = false ;
                  knee2_rdy  = false ;
                  rdy2       = false ;
                  hip2_lock  = true  ;
                  leg2_lock  = true  ;
                  knee2_lock = true  ;
                  
                  buff ="";              // clear buffer
                  error=0;
                }
              if (buff.substring(0) == "#4")  //
                {
                  // TODO:-

                  
                  buff ="";              // clear buffer
                  error=0;
                }
              if (buff.substring(0) == "#5")  //
                {
                  // TODO:-

                  
                  buff ="";              // clear buffer 
                  error=0;
                }
              if (buff.substring(0) == "#6")  //
                {
                  // TODO:-

                   
                  buff ="";              // clear buffer
                  error=0;
                }
              if (buff.substring(0) == "#7")  //
                {
                  // TODO:- 

                  
                  buff ="";              // clear buffer
                  error=0;
                }
                                
              if (buff.substring(0) == "#8")  //
                {
                  // TODO:- 

                  
                  buff ="";              // clear buffer
                  error=0;
                }
              if (buff.substring(0) == "#9")  //
                {
                  // TODO:- 
                  

                  buff ="";              // clear buffer
                  error=0;
                }
            }   
          else
            {
              error=1 ; //ERROR [com frame sync]
            }
          buff ="";              // clear buffer for next command 
        }
      if (buff.length() > 32)    // serial overrun
        {
          // serial overrun error and realy it should never get her
          // the longest command string is 18chrs long
          // and most of them are just 2 bytes long
           
          buff ="";              // clear buffer
          error = 2;             //ERROR [ buffer overrun ]
        }
    
      }
    if (error != 0)
      {
        Serial.print("E[");
        Serial.print(error);
        Serial.println("]");
        //clear error
        error=0;
      }    
    // set and invert if needed pwmo values 
    if (hip_d == 0)
      {
         hip1_pwmo  =  hip1_pwm  ;
         hip2_pwmo  =  hip2_pwm  ;
       }  
    else 
      {
         hip1_pwmo  = 256 - hip1_pwm  ;
         hip2_pwmo  = 256 - hip2_pwm  ;
      }
    if (leg_d == 0) 
      {
        leg1_pwmo  =  leg1_pwm  ;
        leg2_pwmo  =  leg2_pwm  ;
      }
    else
      {
        leg1_pwmo  = 256 - leg1_pwm  ;
        leg2_pwmo  = 256 - leg2_pwm  ;
      }       
    if ( knee_d == 0) 
      {
        knee1_pwmo = knee1_pwm ;       
        knee2_pwmo = knee2_pwm ;      
      }
    else
      {
        knee1_pwmo = 256 - knee1_pwm ;       
        knee2_pwmo = 256 - knee2_pwm ;
      }
    // update pwm i/o values   servo.write(pwmvalout); for all servos
    hip1_servo.write(hip1_pwmo);    
    leg1_servo.write(leg1_pwmo);    
    knee1_servo.write(knee1_pwmo);    
    hip2_servo.write(hip2_pwmo);     
    leg2_servo.write(leg2_pwmo);     
    knee2_servo.write(knee2_pwmo);     
  } 
  else     // calibrate (cal == true)
  { 
    // this code section is for testing, diagnostics and calibration
    // to enter this mode remove address jumpers for board under test 
    //
    // it outputs a serial stream in the format :-
    
    // "1[h=[raw]pwm[d],l=[raw]pwm[d],k=[raw]pwm[d],f[t]]  ;2[h=[raw]pwm[
    // d],l=[raw]pwm[d],k=[raw]pwm[d],f[t]]"
    //
    // where:-
    //  h is for hip , l for leg , k for knee , f for foot
    //  raw = raw adc  value range 0 to 1024
    //  pwm = adc value scaled to pwm range 0 to 255
    //  d =  + for normal   or - for inverted scale range 
    //  t = u for up ( no ground contact ) or d down ( ground contact ) 
    //  foot sence switch
    //  
    // note :-  the inverted state of the pwm output range shown but the 
    //  values shown are not changed to reflect that 
    //  all values shown are none inverted !  be aware of that  

    // hip1
    Serial.print("1[h=[");
    hip1_pos = analogRead(hip1_pot);                
    Serial.print(hip1_pos);                     
    Serial.print("]");
    hip1_pos_s=map(hip1_pos,pot_min,pot_max,pwm_neg90,pwm_pos90);
    Serial.print(hip1_pos_s);                                        
    if (hip_d == 0) 
      {
        Serial.print("[+]");
      }
    else
      {
        Serial.print("[-]");
      } 
    delay(2);
    // leg1
    Serial.print("l=[");
    leg1_pos = analogRead(leg1_pot);                               
    Serial.print(leg1_pos);                                       
    Serial.print("]");
    leg1_pos_s=map(leg1_pos,pot_min,pot_max,pwm_neg90,pwm_pos90);
    Serial.print(leg1_pos_s);                                      
    if (leg_d == 0) 
      {
        Serial.print("[+]");
      }
    else
      {
        Serial.print("[-]");
      }
    delay(2); 
    // knee1  
    Serial.print("k=[");
    knee1_pos = analogRead(knee1_pot);
    Serial.print(knee1_pos);
    Serial.print("]");
    knee1_pos_s=map(knee1_pos,pot_min,pot_max,pwm_neg90,pwm_pos90);
    Serial.print(knee1_pos_s);
    if (knee_d == 0) 
      {
        Serial.print("[+]");
      }
    else
      {
        Serial.print("[-]");
      }
    delay(2);
    // foot1
    Serial.print(",f[");
    foot1_pos = analogRead(foot1_pot);
    if (foot1_pos > 520) 
      { 
        foot1=true;
        Serial.print("d");
      } 
      else
      {
        foot1=false;
        Serial.print("u");
      }
    Serial.print("]]  ;");
    delay(2);
    //hip2
    Serial.print("2[h=[");
    hip2_pos = analogRead(hip2_pot);
    Serial.print(hip2_pos);
    Serial.print("]");
    hip2_pos_s=map(hip2_pos,pot_min,pot_max,pwm_neg90,pwm_pos90);
    Serial.print(hip2_pos_s); 
    if (hip_d == 0) 
      {
        Serial.print("[+]");
      }
    else
      {
        Serial.print("[-]");
      }
    delay(2);
    // leg2
    Serial.print("l=[");
    leg2_pos = analogRead(leg2_pot);
    Serial.print(leg2_pos);
    Serial.print("]");
    leg2_pos_s=map(leg2_pos,pot_min,pot_max,pwm_neg90,pwm_pos90);
    Serial.print(leg2_pos_s);
    if (leg_d == 0) 
      {
        Serial.print("[+]");
      }
    else
      {
        Serial.print("[-]");
      }
    delay(2); 
    // knee2  
    Serial.print("k=[");
    knee2_pos = analogRead(knee2_pot); 
    Serial.print(knee2_pos); 
    Serial.print("]");
    knee1_pos_s=map(knee2_pos,pot_min,pot_max,pwm_neg90,pwm_pos90);
    Serial.print(knee2_pos_s); 
    if (knee_d == 0) 
      {
        Serial.print("[+]");
      }
    else
      {
        Serial.print("[-]");
      }
    delay(2);
    // foot2
    Serial.print(",f[");
    foot2_pos = analogRead(foot2_pot);
    if (foot2_pos > 520) 
      { 
        foot2=true;
        Serial.print("d");
      } 
      else
      {
        foot2=false;
        Serial.print("u");
      }
    Serial.println("]]");
    delay(200);  
  }
}

  

