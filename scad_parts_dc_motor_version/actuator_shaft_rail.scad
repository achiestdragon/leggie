// actuator_shaft_rail.scad
//
//*****************************************************************************
//*             (c) 2017 by David Powell (aka AchiestDragon)                  *
//*****************************************************************************
// Notes :-
// 
//

// ****************************************************************************
// Libraries :-     (local directory libs) 


include <shapes.scad>


//*****************************************************************************
// Code :-


rotate([90,0,0]){    shaft_rail();}

module shaft_rail()
{ 
  color("yellow",1)
  {
    translate([77.5,0,0])
    { 
      difference()
      {
        union()
        {
          translate([-62.5,0,20]){cube([6,25,30],center=true);}
          translate([62.5,0,20]){cube([6,25,30],center=true);}
          translate([0,0,32.5]){cube([131,25,5],center=true);}
          translate([0,0,7.5]){cube([150,25,5],center=true);}
          
          translate([0,9.5,34.5]){cube([131,6,6],center=true);}
          translate([0,9.5,5.5]){cube([131,6,6],center=true);}
          translate([0,-9.5,34.5]){cube([131,6,6],center=true);}
          translate([0,-9.5,5.5]){cube([131,6,6],center=true);}
          
          translate([0,7,34.5]){rotate([0,90,0])cylinder(h=131,d=6,center=true,$fn=60);}
          translate([0,7,5.5]){rotate([0,90,0])cylinder(h=131,d=6,center=true,$fn=60);}
          translate([0,-7,34.5]){rotate([0,90,0])cylinder(h=131,d=6,center=true,$fn=60);}
          translate([0,-7,5.5]){rotate([0,90,0])cylinder(h=131,d=6,center=true,$fn=60);}
        }
        translate ([-3.5,0,20])rotate([0,90,0])
        {
          translate([0,0,-60]){rotate([0,180,0]){cylinder(h=5,d=16,center=true,$fn=60);}}
          translate([0,0,-60]){rotate([0,180,0]){cylinder(h=30,d=10,center=true,$fn=60);}} 
          translate([0,0,67.5]){rotate([0,180,0]){cylinder(h=5,d=16,center=true,$fn=60);}}
          translate([0,0,67.5]){rotate([0,180,0]){cylinder(h=30,d=10,center=true,$fn=60);}} 
          translate([0,0,85]){rotate([0,180,0]){cylinder(h=30,d=22,center=true,$fn=60);}}
          translate([0,0,-78]){rotate([0,180,0]){cylinder(h=30,d=22,center=true,$fn=60);}}
        }
        {Cubic_Array (140,17.5,0,2,2,1,center=true){ rotate([0,0,0]){cylinder(h=30,d=3.5,center=true,$fn=60);}}}
      }
    }
  }
}
