// conrod.scad
//
//*****************************************************************************
//*             (c) 2017 by David Powell (aka AchiestDragon)                  *
//*****************************************************************************
// Notes :-
// 

//  included libs are none printable parts for positional /cutouts & assembly
//  guides unless otherwise stated


//*****************************************************************************
// Code :-



module conrod();
{
  color("red",1) rotate([-90,0,0])
  translate([74,0,20])
  {
   difference()
    { 
    union()
      {
        translate([0,21,0]){rotate([-90,0,0]){ cylinder(h=10,d=25,center=true,$fn=60);}}
        translate([47.5,21,0]){cube([95,10,20],center=true);}
        translate([95,21,0]){rotate([-90,0,0]){ cylinder(h=10,d=20,center=true,$fn=60);}}
      } 
    translate([0,18.5,0]){rotate([90,0,0]){ cylinder(h=5.1,d=16.5,center=true,$fn=60);}}
    translate([0,18.5,0]){rotate([90,0,0]){ cylinder(h=15.1,d=10.5,center=true,$fn=60);}}
    translate([95,21,0]){rotate([-90,0,0]){ cylinder(h=15,d=5.2,center=true,$fn=60);}}
    translate([0,24.5,0]){rotate([90,-20,0]){translate([0,10,0]){rotate([-90,0,0]){ cylinder(h=15,d=4,center=true,$fn=60);}}}}
    translate([0,24.5,0]){rotate([90,-160,0]){translate([0,10,0]){rotate([-90,0,0]){ cylinder(h=15,d=4,center=true,$fn=60);}}}}
    
    translate([95,24.5,0]){rotate([90,30,0]){translate([0,10,0]){rotate([-90,0,0]){ cylinder(h=15,d=4,center=true,$fn=60);}}}}
    translate([95,24.5,0]){rotate([90,150,0]){translate([0,10,0]){rotate([-90,0,0]){ cylinder(h=15,d=4,center=true,$fn=60);}}}}
    translate([95,24.5,0]){rotate([90,-90,0]){translate([0,6,0]){rotate([-90,0,0]){ cylinder(h=8,d=4,center=true,$fn=60);}}}}
  }
  }
}


