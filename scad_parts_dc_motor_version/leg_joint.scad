// leg_joint.scad
//
//*****************************************************************************
//*             (c) 2017 by David Powell (aka AchiestDragon)                  *
//*****************************************************************************
// Notes :-
// 

//  included libs are none printable parts for positional /cutouts & assembly
//  guides unless otherwise stated

//*****************************************************************************
// Libraries :-     (general mcad libs) 

include <MCAD/units/metric.scad>
include <MCAD/hardware/bearing.scad>
include <MCAD/fasteners/metric_fastners.scad>
// NOTE :- the sizes are wrong for nut and bolt heads in this lib
// as cylinder(h,d,center,$fn=6) gives dia size from point tip
// to point tip  and spanner sizes are mesured across flat sides
// 

// ****************************************************************************
// Libraries :-     (local directory libs) 


include <shapes.scad>
include <parts_lib.scad>



//*****************************************************************************
// Code :-


//fullasm();    // full assembled view
//legbase();  // just 1 leg_half for printing
rotate([0,-90,0])end_joint();


module end_joint()
{
  color("orangered",1)
  {
    difference()
    {
      union()
      {
      translate([0,32,0])rotate([90,0,0])cylinder(h=10,d=25,center=true,$fn=60);
      translate([0,-32,0])rotate([90,0,0])cylinder(h=10,d=25,center=true,$fn=60);
      translate([-7.5,-32,2.5])cube([12,10,20],center=true);
      translate([-7.5,32,2.5])cube([12,10,20],center=true);
      rotate([0,-45,0])
        {  
        translate([-21.5,-32,3.5])cube([42,10,30],center=true);
       translate([-21.5,32,3.5])cube([42,10,30],center=true); 
        } 
      translate([-30,-32,-45])cube([30,10,85],center=true);
      translate([-30,32,-45])cube([30,10,85],center=true);
    
      translate([-42.5,0,-47.5])cube([5,60,80],center=true);
      
      translate([-35.5,0,-12.5])cube([10,60,6],center=true); 
      }
    //cutouts
      rotate([0,-20,0]){
      translate([-50,0,-60]){ rotate([90,0,0]) {cylinder(h=100,d=8,center=true,$fn=60);}}
      translate([-50,35,-60]){ rotate([90,0,0]) {cylinder(h=5,d=16,center=true,$fn=60);}} 
      translate([-50,-35,-60]){ rotate([90,0,0]) {cylinder(h=5,d=16,center=true,$fn=60);}}
      }     
      translate([0,32,0])rotate([90,0,0])cylinder(h=40,d=6.5,center=true,$fn=60);
      translate([0,-32,0])rotate([90,0,0])cylinder(h=40,d=6.5,center=true,$fn=60);
      translate([-7,32,0])rotate([0,90,0])cylinder(h=16,d=4,center=true,$fn=60);
      translate([-7,-32,0])rotate([0,90,0])cylinder(h=16,d=4,center=true,$fn=60);
     translate([- 37,32,0])rotate([0,90,0])cylinder(h=46,d=8,center=true,$fn=60);
      translate([-37,-32,0])rotate([0,90,0])cylinder(h=46,d=8,center=true,$fn=60);
      
      translate([-7,32,0])cube([3,20,5.8],center=true);
      translate([-7,-32,0])cube([3,20,5.8],center=true); 
      translate([0,-60,0])rotate([0,90,0])Cubic_Array(20,40,1,4,2,1){cylinder(h=150,d=3.5,center=true,$fn=60); } 
    }
  }
}



