// carrage_half.scad
//
// this is 1 half of the linear actuator carrage (nut holder) 
// 2 off needed for each actuator 
//
//*****************************************************************************
//*             (c) 2017 by David Powell (aka AchiestDragon)                  *
//*****************************************************************************
// Notes :-
// 
// printing
//    print in pla with no supports and 100% infill (as its a small part)  
// 
// ****************************************************************************
// Libraries :-     (local directory libs) 

include <shapes.scad>

//*****************************************************************************
// Code :-


rotate([-90,0,0]){carrage_half();}

module carrage_half()
{
  color("white",1) 
  {
    difference()
    {
    translate([74.,6,20]){cube([30,12,19],center=true);}
    rotate([0,90,0])
      {
        translate([-20,0,74])
        {
          rotate([0,0,0])
          {
            cylinder(h=150,d=6,center=true,$fn=60);
            translate([0,0,0]){rotate([0,0,0]){cylinder(h=18,d=10.5,center=true,$fn=6);}}
            translate([0,0,9]){rotate([0,0,0]){cylinder(h=2,d=11,center=true,$fn=60);}}
            translate([0,0,-9]){rotate([0,180,0]){rotate([0,0,0]){cylinder(h=2,d=11,center=true,$fn=60);}}}
          }
          rotate([90,0,0])Cubic_Array (16.5,10,0,2,2,1,center=true){ {cylinder(h=40,d=4,center=true,$fn=60) ;}}
          rotate([90,0,0])cylinder(h=40,d=6,center=true,$fn=60) ;
          rotate([90,0,0])cylinder(h=15,d=10.5,center=true,$fn=6) ;
          rotate([90,0,0])
          {
            Cubic_Array (13,24,0,2,2,1,center=true){ {cylinder(h=40,d=3.5,center=true,$fn=60) ;}}
            translate([0,0,-25])
              {
              translate([6.5,12,0]) {rotate([0,0,30])cylinder(h=37.5,d=6.7,center=true,$fn=6) ;}
              translate([-6.5,-12,0]) {rotate([0,0,30])cylinder(h=37.5,d=6.7,center=true,$fn=6) ;}
              translate([-6.5,12,0]) {rotate([0,0,30])cylinder(h=37.5,d=7,center=true,$fn=60) ;}
              translate([6.5,-12,0]) {rotate([0,0,30])cylinder(h=37.5,d=7,center=true,$fn=60) ;}
            }
          }  
        } 
      }
    }
  }
}
