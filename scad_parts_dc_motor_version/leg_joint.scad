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

//leg();

module leg()
{rotate([0,90,0])
{
  
  translate([-60,0,-150])lower_leg();
}
}

module lower_leg()
{
  color("green",1)
  {
  difference()
  {
  cube([30,75,300],center=true);
  translate([-10,0,100])cube([40,55,90],center=true);
  translate([-10,0,-50])cube([40,30,205],center=true);
  translate([-10,-15,-50])rotate([2.5,0,0])cube([40,15,205],center=true);
  translate([-10,15,-50])rotate([-2.5,0,0])cube([40,15,205],center=true); 
  translate([-10,40,-50])rotate([-2.5,0,0])cube([70,24,210],center=true);  
  translate([-10,-40,-50])rotate([2.5,0,0])cube([70,24,210],center=true);  
  translate([-20,0,-50])rotate([0,-3,0])cube([20,80,230],center=true);
  translate([0,-60,150])rotate([0,90,0])Cubic_Array(20,40,1,4,2,1){cylinder(h=150,d=3.5,center=true,$fn=60); } 
  translate([3,0,4])cylinder(h=350,d=8,center=true,$fn=60);
  translate([0,0,30])rotate([0,90,0])cylinder(h=150,d=40,center=true,$fn=6); 
  translate([0,0,-22])rotate([0,90,0])cylinder(h=150,d=35,center=true,$fn=6);
  translate([0,0,-70])rotate([0,90,0])cylinder(h=150,d=30,center=true,$fn=6);
  translate([-20,0,110])rotate([0,6,0])cube([20,80,230],center=true);
  
  translate([0,7.5,-145])rotate([0,90,0])cylinder(h=150,d=3.5,center=true,$fn=60); 
  translate([0,-7.5,-145])rotate([0,90,0])cylinder(h=150,d=3.5,center=true,$fn=60);
  
  translate([0,7.5,-130])rotate([0,90,0])cylinder(h=150,d=3.5,center=true,$fn=60); 
  translate([0,-7.5,-130])rotate([0,90,0])cylinder(h=150,d=3.5,center=true,$fn=60);
  
  }
  difference()
  {
  union()
   {  
    translate([3,0,-100])cube([18,50,8],center=true);
    translate([3,0,4])cube([18,50,8],center=true); 
    translate([3,0,-48])cube([18,50,8],center=true);
     translate([0,0,55])cube([30,55,8],center=true);
   } 
  translate([3,0,-100])cylinder(h=350,d=8,center=true,$fn=60);  
  }
 }
}
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
      
      translate([-26.5,32,-72.5]){ rotate([90,0,0]) {cylinder(h=10,d=35,center=true,$fn=60);}}
       translate([-26.5,-32,-72.5]){ rotate([90,0,0]) {cylinder(h=10,d=35,center=true,$fn=60);}} 
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
      translate([-12.5,0,-90]){ rotate([90,45,0]) {cube([10,20,80],center=true);}}
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



