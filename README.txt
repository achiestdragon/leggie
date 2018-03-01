leggie  hexapod robot project version 1.0 README.txt

(c)2018 by David Powell  AKA. AchiestDragon

version 1.0a  alpha prototype 

most of  the documentation so far is in the comments in the code

project status
--------------
 hardware:-
 
    v1 built and assembled , found that the servos are under powered for the
    size and weight of the robot so currently redesigning to use rs-775 dc motors
    these are 12 to 36v motors and involves quite a number of major changes
    
    1 most of the 3d printed parts will need to be redesigned and reprinted
    
    2 the power requirements have increased , it will now need 2*11.1v or 14.6v lipos 
      for the dc motor drive power (wired in parallel to give 22.2v or 29.2v) and still 
      keep the 7.4v 4000ma lipo for logic power( with the 5v regulator)
      this should save having to power down the whole robot when the drive power is 
      depleted and give quite a few hrs of logic power
      
    3 the need for 18 h bridge drivers suitable for the rs-775 motors
    
    4 2 sense pots will be used per leg joint again acting as the joint bearing as this
      seems to work well 
    
    5 the drive system will use the dc motors driving 5mm threaded bar to form a linear
      actuator , with .8mm per turn and 80 mm movement giving an joint angle range of 
      160deg and movment speed around of around 1 second at 7000rpm from end to end
      with a gearing reduction of 225:1  and give a stall torque of around  400kg.cm or
      40N.M in that arrangement , about 40x that of the mg996r servos 
    
    6 the other advantage of using the drives in linear actuator form is they dont 
      slip position when not powered, this will make running power more efficiant as
      its not having to provide hold power to keep the legs in hold position 
      although it does have the disadvantage that you cant move the legs without power
    
    7 delay in development dew to extra expense and time waiting for parts
    

 software:-

    still work in progress

 
******* notes below here relate to servo version and are to be replaced **********
    
    
3d printing requirements   
------------------------
  intended for printing on a tevo delta 3d printer
  or one that is able to print 340mm dia 
  
  the prototype was printed with 20% infill and no supports i used slow 
  print speed settings so the print time in total is a lot longer than
  it should be 

  Note :- current gcode has some prity rough settings that may need tweeking
  depending on your filament , its probablay better to recreate them from the
  stl files , printing times are based on these slower settings also 
  (scad and stl files have been uploaded to the project but i have Not
  uploaded the gcode as you would be better generating it using slic3r or
  whatever other program you use to ensure its suitable for your 3d printer)

  version 1 (servo version )
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
     
     parts list for the electronics and hardware
     
TODO:-  to sort out in genaral for beta version print files

   do some documentation for the project , assembly instructions , 
   operating guide , fix spellings
   
   draw a schematic diagram for it
   
   extra support braceing on 3d printable parts where needed , and tidy up 
   part looks 

   split main scad file into individual part files and have them drawn in 
   printing positions / groupings
   
   better wireing loom method (make it  easyer) include leg loom connectors
   so a leg wireing can be disconnected if removing a leg for service/repair
   and making assembley easyer,
   
   look at making it easyer to service and repair currently this involves
   removing quite a lot of nuts and bolts to gain access to parts 

   sort out a better method of power distribution to servos and sensors

   sort out some form of ardunio nano mountings ,

   fix scad for pot shaft mounts (holes size too big) and
   pot shaft clamp nut hole size too small ( need to push nut
   in with soldering iron ),

   add  top/bottom parts one with hole for servo power switch
   the other with holes for logo plate

   joystick top plate add holes for usb cable tie  , and 
   mountings for additional pots 1 and 2  (optional) 
   and add mounting hole for a power led  
   
   look at ways of making the parts lighter but stronger 
   
   the nuts have a habit of working lose should use locking nuts 
   as appropriate 
   
   foot switch  make this easyer to assemble and allow for locking 
   nuts to be used , spring centering hole size is a bit big 
   
   other stuff as it becomes apparent 
   
 
