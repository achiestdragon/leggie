// template.scad
//
//*****************************************************************************
//*             (c) 2017 by David Powell (aka AchiestDragon)                  *
//*****************************************************************************
// Notes :-
// 

//  include libs are none printable parts for positional assembly guides
//       unless otherwise stated

//*****************************************************************************
// Libraries :-     (general mcad libs) 

include <MCAD/units/metric.scad>
include <MCAD/hardware/bearing.scad>

include <MCAD/fasteners/metric_fastners.scad>
// csk_bolt (3,14);
// washer (3);
// flat_nut (3);
// bolt (3,14);
// cylinder_chamfer (8,1);
// chamfer (10,2);

include <MCAD/motors/servos.scad>
// alignds420  (position, rotation, screws = 0, axle_lenght = 0)
// futabas3003 (position, rotation)

// ****************************************************************************
// Libraries :-     (local directory libs) 

include <raspberrypi.scad>
// pi (part,header);
// zero ( header= 0);
// hifiberryDacPlus (withHeader=false);
// pi_hat();
// pi3 ();

//include <euro100x160pcb.scad> ***
//**** or use eurocard() in lib_parts quicker as its "pre-rendered" 
  
include <shapes.scad>
// slot (width, lenth, hight, rotation)
// ring (outer, inner, hight, segments)
// rbox (x,y,z,d)
// torus (r1,r2,a,s1,s2)
//
// Cubic_Array (sx,sy,sz,nx,ny,nz,center=true){ child_objects ;}
// Radial_Array (a,n,r){ child_objects ;}

include <parts_lib.scad>
// printer_bed ();    // 3d printer bed size allignment guide
// motor();           // 12v 12000 rpm 3mm shaft
// microswitch ();    // small microswitch 
// shaft_coupler ();  // 3mm to 3mm shaft coupler 
// encoder_disk ();   // optical encoder disk 3mm mounting (printable)
// slot_sensor ();    // slotted opto switch
// selonoid ();       // lift/hold seloniod 2.5kg 20mm dia 15mm h
// bearings (type);   // from lib MCAD-dev but only needs type input
//                    // skate(608) =683 etc eg:-
// translate ([0,0,10]) {rotate([0,0,0]){bearings(623);}}    //3mm 
// translate ([0,0,0])  {rotate([0,0,0]){bearings(624);}}    //4mm
// translate ([0,0,-10]){rotate([0,0,0]){ bearings(606);}}    //6mm
// pot();             // pot 16mm metal flat d 6mm shaft  
// eurocard();        // a quick pre rendered  100x160mm euro square pad 
//                    // proto board , from euro100x160pcb.scad pcb();
//                    // as that takes about 15 mins to render

//*****************************************************************************
// Varibles :-



//*****************************************************************************
// Constants :-


//*****************************************************************************
// Code :-
module asm();
{
 //translate([65,-12,0]){rotate([0,0,0]){joy_mount();}}
 // translate([-65,-12,0]){rotate([0,0,0]){joy_mount();}}
 //translate([0,0,-24]){box();}
 translate([0,0,-4]){spacer();}
 //translate([0,0,20]){boxlid();}
  
}

module boxlid()
{
  color("dimgray",1){
  difference()
  {
    union()
    {
    difference()
    {
      cube ([200,100,3],center=true);
        translate([65,-12,0]){rotate([0,0,0]){joy_mount_holes();}}
  translate([-65,-12,0]){rotate([0,0,0]){joy_mount_holes();}}
    }
    Cubic_Array (65,95,0,4,2,1,center=true){ cylinder(h=3,d=10,center=true,$fn=60) ;}
    }
    
    Cubic_Array (65,95,0,4,2,1,center=true){ cylinder(h=4,d=4,center=true,$fn=60) ;}
    translate([0,35,0]){Cubic_Array (20,0,0,10,1,1,center=true){ cylinder( h=20,d=12.1,center=true,$fn=60) ;}}
        
    translate([0,35,10.5]){Cubic_Array (20,0,0,10,1,1,center=true){ cylinder( h=20,d=15.1,center=true,$fn=60) ;}}
    
  }
    
  }
  
}
module box()
{
  color("dimgray",1){
  difference()
  {
    union()
    {
      cube ([200,100,3],center=true);
      Cubic_Array (65,95,0,4,2,1,center=true){ cylinder(h=3,d=10,center=true,$fn=60) ;}
    }
     Cubic_Array (65,95,0,4,2,1,center=true){ cylinder(h=4,d=4,center=true,$fn=60) ;}
   }
    
  }
  
}
module box2()
{
  color("dimgray",1){
  difference()
  {
    union()
    {
    difference()
    {
      rbox (200,100,30,8);
      rbox (195,95,25,4);
    }
    Cubic_Array (65,95,0,4,2,1,center=true){ cylinder(h=30,d=10,center=true,$fn=60) ;}
    }
    translate([0,0,20]){cube([300,200,20],center=true);}
    Cubic_Array (65,95,0,4,2,1,center=true){ cylinder(h=30,d=2.5,center=true,$fn=60) ;}
  }
    
  }
  
}
module spacer()
{
  color("orangered",1){
  difference()
  {
    union()
    {
    difference()
    {
      cube([200,100,30],center=true);
      cube([195,95,35],center=true);
      //rbox (200,100,30,8);
      //rbox (195,95,40,4);
    }
    Cubic_Array (65,95,0,4,2,1,center=true){ cylinder(h=30,d=10,center=true,$fn=60) ;}
    }
    translate([0,50,-15]){rotate([90,0,0]){cube([5,10,20],center=true);}}
    translate([0,50,-10]){rotate([90,0,0]){cylinder(h=30,d=5,center=true,$fn=60) ;}}
    Cubic_Array (65,95,0,4,2,1,center=true){ cylinder(h=30,d=2.5,center=true,$fn=60) ;}
  }
    
  }
  
}
module buttons()
{  
difference()
{
cube([100,30,3],center=true);
Cubic_Array (20,0,0,5,1,1,center=true){ cylinder( h=20,d=12.1,center=true,$fn=60) ;}
Cubic_Array (40,20,0,3,2,1,center=true){ cylinder( h=20,d=3.4,center=true,$fn=60) ;}

}
}

module joy_mount()
{ 
 color("orangered",1){ 
difference()
{
rotate([0,0,45]){cylinder(h=3,d1=88,d2=85,center=true,$fn=4);}
//cube([60,60,3],center=true);
Cubic_Array (32.5,32.5,0,2,2,1,center=true){ cylinder( h=20,d=2.4,center=true,$fn=60) ;}
Cubic_Array (50,50,0,2,2,1,center=true){ cylinder( h=20,d=3.4,center=true,$fn=60) ;}
cylinder( h=20,d=40.4,center=true,$fn=60) ;
translate([0,0,10]){cylinder( h=20,d=50.4,center=true,$fn=60) ;}
}
}}
module joy_mount_holes()
{  
Cubic_Array (50,50,0,2,2,1,center=true){ cylinder( h=20,d=3.4,center=true,$fn=60) ;}
rotate([0,0,22.5]){cylinder( h=20,d=60,center=true,$fn=8) ;}
}