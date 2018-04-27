leggie  hexapod robot project version 6.0a README.txt

(c)2018 by David Powell  AKA. AchiestDragon

current version :- 6.0a  (alpha prototype)

project status
--------------

 hardware:-
    
    most of the cad redesign is done , although there's still some parts to do
  mainly , electronics covers , battery mounting , turret and head , that can
  wait for the time .
  
    there are a couple of points that may need some of the parts to be reprinted
  mainly the hip/knee joints ( with a diferent infill setting ) as a couple have
  slightly split where the pot mountings have been over tightended , although will
  see how they go as they have not totaly snapped and seem to hold well enough
    the other issues beeing the hip pivot part, this needs a hacksaw to remove on of the
  cross supports so it can actualy be assembled, in genaral all the bearing holes needed
  shaving so the bearings fitted and some of the holes in genaral also needed to be trimmed
  for it to go together.
  
    it takes about a day each to assemble a leg , including the time taken to clean up the
  3d printed parts, and about 2 days to do the main center base assembly , not including 
  print time , you need to ensure its 100 percent before fitting it as servicing it later
  is a real pain , there is an order it needs to be assembled in otherwise you will find 
  your taking it apart again ( should be covered in the assembly guide)
  
    its taken over 324 hrs of 3d printing (and about 6kg of filament used so far)
  the main base and legs of the robot are now all printed and assembled and i 
  am currently about to start work on  the dc motor drives & other electronics.
  
    once the robot can be powered up i can get back on with the software. i also 
  need to include schematics and layouts for the motor drivers and robot wireing
    
    at present im still planning to use a pi3 and adruino nanos for the robot control
  logic , but am still tempted to use a fpga for the motor timings in place of the
  arduino nanos , this is because the responce times are quicker and also the fact that the 
  fpga method can concurrently keep all the motors in sync far easyer than software
    with this in mind i need to keep the electronics more modular so it could be changed 
  if needed, the main issue here though is finding a fpga module with tool chain that
  is firstly not overly expencive and 2nd is going to be arround for some time , 
    as the same is true, of the controlers in genaral making it modular so future
  upgrades and new moddels of controlers may be used in future is also a good step
  
    this version the robot can seperate into 2 distinct parts the lower walking section
  base and legs , and the upper body section , they are joined by some spring and 3d printed 
  clips  , and connectors , that allow them to seperate , this is for transportation , 
  
    the upper electronic frame has mountings for 6 100*160 mm "eurocard" sized pcbs for the motor
  drivers (3 drivers on each ) and another for  interconnections and for the rpi3 to mount on 
  still to cad but the battery mountings , turret and head mountings will also attach to the upper
  assembly , also to cad are the covers for the electronics , but can only do these once the boards
  have been assembled so the component heights and positions can be taken into account , they may also 
  need fan mountings to keep the drivers cool 
  
    batteries , at present i have a couple of options  it needs 24 to 36v for the motors and 5v for the logic
  so i could use 2 14v and 1 7v lipo but dont realy want to have to mix types , and is the reason why i have not 
  done the cad for the battery mountings as yet 
    
    4 of the 7.4v 4000mAh or 2 of the 14.8v lipos batteries in series will give 29.6v  , an a seperate battery for
 the logic so that it does not just shutdown when the main drive power is low 
    
    the higher the voltage the faster rpm of the motors (before torque) , it could run from just 1 11.8v battery
  but it would be slow , current consumption / load is the other issue , and that relates to how long it will run 
  before you need to recharge
  
    the fact that this version is using the motors in a linear motor arrangment means all the legs hold without
  power only needing power to move , over servo versions that need power to the motors to hold there positions
  helps it run longer , the disadvantage is you cant just move the legs by hand without power to them , you have
  to turn the motor drive to get the joint to move , access to be able to do this is possible 
  

 software:-

    still work in progress (most of current software here relates to the servo 
  version at present and is going to be mostly rewritten )  as support for the 
  servo version is redundant long term it will be removed at some point
    

 history
-----------
    design history of the current hexapod robot 

    version 1  "tinybug" 
       not that tiny it used cheap satelite dish positioning jacks , suspended
    dew to being too big ( it was almost 10foot across in normal standing pose),
    power and speed with around 1kw full load, 160kg and a walk speed of about
    20 foot an hr  and 1 hr before needing to recharge the 8 x 12v 7ah lead acid gell batteries
    that took about 2 days each time, the joints where very clunky and had mountains 
    of backlash on each leg , and a mini atx controler (2010)
    
    version 2 "scare-e"
       smaller a servo version , it was fpga based and ran out of available gates in the
    fpga , so never was compleated, had 3d ultrasonics , leg movment was by pll locked state machine
    motor control sweet , ran out of gates doing the cpu , (2012)
    
    version 3 "un-named-version" 
       never got passed cad stage , sort of a hybrid concept  of a hexapd with wheels for feet
     so it could use the wheels on flat ground , or switch to walk mode and use them like feet 
     to climb up stairs , nice in concept till you try to do the stair climbing spaceings  then 
     it turns into a monster (2017)
    
    version 4 "un-named-version"
       did cad for this a dc motor version although with smaller motors but decided
      to have another go at a servo version , this one never left the drawing board
      but should of current version is a rework of the ideas i used on this (2017)
      
    
    version 5  "leggie " servo version  , scraped , servos not strong enough (2018)
    
    version 6  "leggie6" dc motor version current work in progress(2018)
    
