// template.scad
//
//*****************************************************************************
//*             (c) 2017 by David Powell (aka AchiestDragon)                  *
//*****************************************************************************
// Notes :-
// 

//  include libs are none printable parts for positional assembly guides
//       unless otherwise stated


// ****************************************************************************
// Libraries :-     (local directory libs) 

  
include <shapes.scad>


include <parts_lib.scad>


//*****************************************************************************
// Varibles :-



//*****************************************************************************
// Constants :-


//*****************************************************************************
// Code :-
module asm();
{
 translate([65,-12,30]){rotate([0,0,0]){joy_mount();}}
 translate([-65,-12,30]){rotate([0,0,0]){joy_mount();}}
 translate([0,0,-24]){box();}
 translate([0,0,-4]){spacer();}
 translate([0,0,20]){boxlid();}
  
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