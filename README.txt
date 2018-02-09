leggie  hexapod robot project version 1.0 README.txt

(c)2018 by David Powell  AKA. AchiestDragon

version 1.0a  alpha prototype 

most of  the documentation so far is in the comments in the code


3d printing requirements   
------------------------
  intended for printing on a tevo delta 3d printer
  or one that is able to print 340mm dia 

  Note :- current gcode has some prity rough settings that may need tweeking
  depending on your filament , its probablay better to recreate them from the
  stl files , printing times are based on these slower settings also 
  (scad and stl files have been uploaded to the project but i have Not
  uploaded the gcode as you would be better generating it using slic3r or
  whatever other program you use to ensure its suitable for your 3d printer)

  part            material   quant     time per print   total time per set
--------------- ----------- ------  ---------------- ---------------------
  base top       black pla     1x       4hr30                  4hr30
  base bottom    black pla     1x       4hr17                  4hr17
  base supp      black pla     1x       4hr15                  4hr15 
  top /(bottom)  orange pla    4x       4hr21                 17hr24
  top1           black pla     1x       2hr07                  2hr07
  top2 (feet)    black pla     1x       2hr50 est              2hr50
  top3 (ring)    black pla     1x          42                     42
  top4 (cam)     black pla     1x          20 est                 20
  camtower set   orange pla    1x                              1hr40                  
  bottom1 (bat)  black pla     1x       2hr07                  2hr07
  hip and knee   orange pla    6x       5hr07                 30hr32
  leg            black pla     6x       4hr45                 28hr30
  foot           orange pla    6x       1hr51                 11hr06
  foot pad       black flex    6x          40                  4hr00
  logo           black pla     1x          20 est                 20

  joystick case 

 
                                                        ----------------
                                       total print time    a few days
                                                        ----------------
  filament usage it should be  possible to print it with 
         1kg of black pla * would go for 2x 1kg spools as its borderline
         1kg of orange pla * would go for 2x 1kg spools as its borderline
         and some flex 250g should be more than enough
         
         if doing it all one color then 3x 1kgspools of pla would do
         with 250g of flex 
         
         thats allowing enough for a couple of fail / bad prints , and
         leaving enough to print spare parts from if needed
         
NOTES :-
   this is the alpha prototype version and is still in development 
   as such some parts :-
   
    1   parts may need modifying to fit properly
           some small mods
           
    2   the documentation may be incompleate
           it still is
           
    3   parts are subject to change without notice
           
    4   there is  no garantee that it will work 
           
    5   the software is still beeing written so
        maybe incompleate or none functional
        
    6   other stuff as it becomes apparent
    
    current progress
     parts printed , and robot assembled , at least it all fits together
     some minor mods but couple of extra holes but it fits

     legs wired , battery and power regulators and distribution done , 
     pi3 mounted, wireing loom done , 
     
     robot leg driver arduinos mounted , it powers up , reads the adc values
     sorting the pwm drive code 
     
     the joystick is finished, and its arduino software tested this bit at
     least is done and working 
     
     the contoller pc side code ie joystick to wifi to robot and robot
     status over wifi to pc display still to do although inital testing 
     is going to be done with joystick connected directly to the onboard 
     pi3 via usb
     
     camera pan tilt mount still todo and camera / head sensors to sort
    
     parts list for the electronics and hardware
     
TODO:-  most are to sort out in genaral for next version

   do some documentation for the project , assembly instructions , programming
   and setup guide, operating guide , fix spellings
   
   draw a schematic wireing diagram for it
   
   camera pan and  tilt brackets 3d printable parts  ( once its decided
   what camera / sensors to use

   extra support braceing on 3d printable parts where needed , and tidy up 
   part looks 

   split main scad file into individual part files and have them drawn in 
   printing positions / groupings
   
   better wireing loom method (make it  easyer) include leg loom connectors
   so a leg wireing can be disconnected if removing a leg for service/repair
   and making assembley easyer,
 
   mountings for regulators,

   sort out a better method of power distribution to servos and sensors

   sort out some form of ardunio nano mountings ,

   fix scad for pot shaft mounts (holes size too big) and
   pot shaft clamp nut hole size too small ( need to push nut
   in with soldering iron ),

   add  top/bottom parts one with hole for servo power switch
   the other with holes for logo plate

   joystick top plate add holes for usb cable tie  , and 
   mountings for additional pots 1 and 2  (optional) 
   and add mounting for a power led  

   other stuff as it becomes apparent 
   
 
