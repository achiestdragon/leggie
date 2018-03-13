// leg_half.scad
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
//rotate([0,90,0])end_joint();

module fullasm()
{
  pos();
  rotate([0,180,0]){pos();}
}

module pos()
{
  translate([0,0,-1])
  {
    hwasm();
    translate ([0,0,0]){carrage_half();}
    rotate([0,0,180]){translate ([-148,0,0]){carrage_half();}}
    shaft_rail();
  }
  legbase();
  //hip center
  //translate([-140,0,14]){end_joint();}
  //hip +90deg
  translate([-140,0,14])rotate([0,-5,0]){end_joint();}
  //hip -90deg
  //translate([-140,0,14])rotate([0,-45,0]){end_joint();}
  color("yellow",1)translate([15.5,0,-30])rotate([90,-25,0]){import("../stl_parts_dc_motor_version/conrod.stl");}
  color("yellow",1)translate([-1.5,0,5.5])rotate([-90,-25,0]){import("../stl_parts_dc_motor_version/conrod.stl");}
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


module legbase()
{
  color("brown",1)
  {
    difference()
    {
      union()
      {
        //main base
        translate([0,0,2]){cube([310,60,4],center=true);}
        //sides
        translate([0,28,8]){cube([310,4,12],center=true);}
        translate([0,-28,8]){cube([310,4,12],center=true);}
        
        translate([-45,28,18]){cube([150,4,12],center=true);}
        translate([-45,-28,18]){cube([150,4,12],center=true);}
        //motor mount
        translate([-23,0,22]){cube([6,60,36],center=true);}
        // motor endplate
        translate([-122,0,22]){cube([4,60,36],center=true);}
        //potmounts
        translate([-139,20,15]){cube([32,4,25],center=true);}
        translate([-139,-20,15]){cube([32,4,25],center=true);}
      }
      translate([-66,0,2]){cube([80,35,6],center=true);}
      translate([66,0,2]){cube([80,35,6],center=true);}
      translate([77.5,0,2]){cube([132,26,6],center=true);}
      translate([77.5,0,2])
        {
        Cubic_Array (140,17.5,0,2,2,1,center=true)
          { cylinder(h=18,d=3.5,center=true,$fn=60);}
        }
      translate([-77.5,0,2])
        {
        Cubic_Array (140,17.5,0,2,2,1,center=true)
          { cylinder(h=18,d=3.5,center=true,$fn=60);}
        }
        // motor mount holes 
        translate([-22,0,19])rotate([0,90,0])
        {
          cylinder(h=25,d=20,center=true,$fn=60);
          translate([0,14.5,0]){cylinder(h=25,d=4,center=true,$fn=60);}
          translate([0,-14.5,0]){cylinder(h=25,d=4,center=true,$fn=60);}
          rotate([0,0,45])Radial_Array (90,4,16){ cylinder(h=10,d=8.5,center=true,$fn=6) ;}
          rotate([0,0,35])Radial_Array (90,4,16){ cylinder(h=10,d=8,center=true,$fn=16) ;}
          rotate([0,0,-35])Radial_Array (90,4,16){ cylinder(h=10,d=8,center=true,$fn=16) ;}
          //motor mount champhers
          
          rotate([0,0,135])translate ([00,40,0]){ cube([40,30,10],center=true) ;}
          rotate([0,0,45])translate ([00,40,0]){ cube([40,30,10],center=true) ;}
          translate([-10,0,35.5]){rotate([0,15,0]){cube([20,90,40],center=true);}}
          //end plate champers
          rotate([0,0,135])translate ([00,40,-100]){ cube([40,30,10],center=true) ;}
          rotate([0,0,45])translate ([00,40,-100]){ cube([40,30,10],center=true) ;}
        }
    //pot mounts and endplate cutouts
    translate([-140,-22,14]){rotate([90,180,0]){pot();}}
    translate([-140,22,14]){rotate([-90,180,0]){pot();}}
    translate([-140,27,14]){rotate([-90,0,0]){cylinder(h=10,d=32,center=true,$fn=60);}}
    translate([-140,-27,14]){rotate([-90,0,0]){cylinder(h=10,d=32,center=true,$fn=60);}}
    translate([-150,-27,14]){rotate([-90,0,0]){cube([40,30,10],center=true);}}
    translate([-150,27,14]){rotate([-90,0,0]){cube([40,30,10],center=true);}}
    translate([-120,0,24]){rotate([0,90,0]){cylinder(h=30,d=20,center=true,$fn=60);}}
    translate([-120,0,14]){rotate([0,90,0]){cube([20,20,20],center=true);}}
    
    translate([-160,0,34]){rotate([0,45,0]){cube([25,50,55],center=true);}}
    //other end
    translate([150,-27,14]){rotate([-90,0,0]){cube([40,30,10],center=true);}}
    translate([150,27,14]){rotate([-90,0,0]){cube([40,30,10],center=true);}}
    
    //cableholes
    translate([5,20,0]) cylinder(h=20,d=6,center=true,$fn=60);
    translate([0,20,0]) cube([10,6,20],center=true);
    translate([-5,20,0]) cylinder(h=20,d=6,center=true,$fn=60);
    translate([5,-20,0]) cylinder(h=20,d=6,center=true,$fn=60);
    translate([0,-20,0]) cube([10,6,20],center=true);
    translate([-5,-20,0]) cylinder(h=20,d=6,center=true,$fn=60);
    translate([-20,22,8]) rotate([0,90,0])cylinder(h=20,d=8,center=true,$fn=60);
    translate([-20,-22,8]) rotate([0,90,0])cylinder(h=20,d=8,center=true,$fn=60);
    
    Cubic_Array (230,40,0,2,2,1,center=true){ {cylinder(h=40,d=3.5,center=true,$fn=60) ;}}
    } 
  } 
}

module carrage_half()
{
  color("black",1) 
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
module shaft_rail()
{ 
  color("orangered",1)
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
        {Cubic_Array (140,17.5,0,2,2,1,center=true){ cylinder(h=30,d=3.5,center=true,$fn=60);}}
      }
    }
  }
}


module hwasm()
{
translate([-60,0,20]){actuatorhwasm();}
translate([-140,-22,15]){rotate([90,180,0]){pot();}}
translate([-140,22,15]){rotate([-90,180,0]){pot();}}
hip_knee_shaft();
}

module actuatorhwasm()
{
  rotate([0,90,0])
  {
    motor_rs_775();
    shaft_coupler();
    shaft_m5();
    
  }
}
module hip_knee_shaft()
{
  translate([-160,0,-60])
  {
    rotate([90,90,0])
    {
      cylinder(h=100,d=5,center=true,$fn=60);
      
      //drive end hw
      translate([0,0,-37.5]){rotate([0,180,0]){ flat_nut (5);}}
      translate([0,0,-36]){rotate([0,180,0]){bearings (625);}}
      //free end hw
      
      translate([0,0,37]){rotate([0,0,0]){ flat_nut (5);}}
      translate([0,0,35.5]){rotate([0,180,0]){bearings (625);}}
    }
  }
}
module shaft_m5()
{ 
  translate([0,0,134])
  {
    rotate([0,0,0])
    {
      cylinder(h=150,d=5,center=true,$fn=60);
      
      //drive end hw
      translate([0,0,-62.5]){rotate([0,180,0]){ flat_nut (5);}}
      translate([0,0,-60]){rotate([0,180,0]){bearings (625);}}
      //free end hw
      
      translate([0,0,70]){rotate([0,0,0]){ flat_nut (5);}}
      translate([0,0,67.5]){rotate([0,180,0]){bearings (625);}}
      // carrage nuts
      
      translate([0,0,4]){rotate([0,0,0]){ flat_nut (5);}}
      translate([0,0,8.5]){rotate([0,0,0]){color("black",1)ring (10, 6, 1.5, 60) ;}}
      translate([0,0,9.5]){rotate([0,0,0]){washer(5);}}
      translate([0,0,-4]){rotate([0,180,0]){ flat_nut (5);}}
      translate([0,0,-8.5]){rotate([0,0,0]){color("black",1)ring (10, 6, 1.5, 60) ;}}
      translate([0,0,-9.5]){rotate([0,0,0]){washer(5);}}
      
      //carrage side pivot bearings ,nuts and bolts
      translate([0,3.5,0]){rotate([-90,0,0]){ bolt (5,25);}}
      translate([0,-3.5,0]){rotate([90,0,0]){ bolt (5,25);}}
      translate([0,16,0]){rotate([90,0,0]){ flat_nut (5);}}
      translate([0,18.5,0]){rotate([90,0,0]){bearings (625);}}
      translate([0,21,0]){rotate([-90,0,0]){ flat_nut (5);}}
      translate([0,-16,0]){rotate([-90,0,0]){ flat_nut (5);}}
      translate([0,-18.5,0]){rotate([-90,0,0]){bearings (625);}}
      translate([0,-21,0]){rotate([90,0,0]){ flat_nut (5);}}
      
      //teflon tube bits
      color("blue",1)translate ([0,6,0])rotate([90,0,0])Cubic_Array (16.5,10,0,2,2,1,center=true){ {ring(4,2.5,8,60) ;}}
      color("blue",1)translate ([0,-6,0])rotate([90,0,0])Cubic_Array (16.5,10,0,2,2,1,center=true){ {ring(4,2.5,8,60) ;}}
    }
  }
}

module shaft_coupler()
{ 
  translate([0,0,55])
  {
    rotate([0,0,0])
    {
      cylinder(h=25,d=19,center=true,$fn=60);
    }
  }
}

module motor_rs_775()
{
  color("silver",1)
  {
    rotate([0,0,0])
    {
    difference()
      {
      union()   //main motor body
        {
        cylinder(h=67,d=40,center=true,$fn=60);
        translate([0,0,9]){cylinder(h=38,d=42,center=true,$fn=60);}
        translate([0,0,35]){cylinder(h=3,d=18,center=true,$fn=60);}
        translate([0,0,38]){cylinder(h=25,d=5,center=true,$fn=60);}
        // power lugs
        translate([0,14.5,-35]){cube([3,1,12],center=true);}
        translate([0,-14.5,-35]){cube([3,1,12],center=true);}
        }
      union()   //mounting holes 
        {
      translate([0,14.5,30]){cylinder(h=25,d=2.6,center=true,$fn=60);}
      translate([0,-14.5,30]){cylinder(h=25,d=2.6,center=true,$fn=60);}
        }
      }
    }
  }
}

