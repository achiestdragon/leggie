// base.scad
//
//*****************************************************************************
//*             (c) 2017 by David Powell (aka AchiestDragon)                  *
//*****************************************************************************
// Notes :-
// 

//  included libs are none printable parts for positional /cutouts & assembly
//  guides unless otherwise stated


// ****************************************************************************
// Libraries :-     (local directory libs) 
include <MCAD/units/metric.scad>
include <MCAD/hardware/bearing.scad>
include <MCAD/fasteners/metric_fastners.scad>

include <shapes.scad>
include <parts_lib.scad>
include <leg_joints.scad>
include <leg_joint.scad>

//*****************************************************************************
// Code :-
//translate([0,0,-60])printer_bed();
//base_bottom();
asm();
module asm()

  {
  // hip motors and slides
  //upper();  
  //lower();
  
  // hip sence pots
  //translate([0,0,-70])rotate([0,0,30])Radial_Array(60,6,145){translate([0,0,2.5])rotate([0,0,90])pot();}
  //translate([0,0,70])rotate([0,180,0])rotate([0,0,30])Radial_Array(60,6,145){translate([0,0,2.5])rotate([0,0,90])pot();}
  //base plates
  //base_bottom();
  base_top();
  //base_center();
  
  //legs
  // full assembled legs or.. 
  //translate([0,0,-21])rotate([0,0,30])Radial_Array(60,6,346.5){rotate([180,-6,90])fullasm();}
  //translate([0,0,8])rotate([0,0,30])Radial_Array(60,6,486.5){rotate([0,-90,-90])leg();}
  // just leg hip joint plates
  //translate([0,0,5])rotate([0,0,30])Radial_Array(60,6,197.5){rotate([180,-0,90])end_joint1();}
  //hip_pivot_asm();
  upper_body_mount_asm();
  }
  
module upper_body_mount_asm()
  {
   upperbody();
   //pcbs
   color("green",1)
   {  
    //translate([0,0,135])rotate([0,0,30])rotate([0,90,0])translate([0,0,-105])Cubic_Array(0,0,30,1,1,6)cube ([100,160,2],center =true);
    //translate([0,0,134])rotate([0,0,30])Radial_Array(60,6,105)rotate([90,0,00])cube ([100,100,2],center =true); 
 //    translate([0,0,150])rotate([0,0,30])Radial_Array(120,3,90)cube ([100,100,2],center =true); 
   }
 }
 
module upperbody()
 {
 color("pink",1)
   {
     translate([0,0,80.5])
     {
       Radial_Array(60,6,110)rotate([0,0,30])ring (15,4,5,6);
     //translate([0,0,10])rotate([0,0,0]) ring (280,220,6,6); 
     }
     
     
   } 
 } 
module base_bottom()
  {
    difference()
    {
    translate([0,0,-70])base_half();
    rotate([0,0,0])
      {
        m_holes_l() ; 
        rotate([180,0,30])Radial_Array(-120,3,50){translate([72.5,0,30])rotate([0,-90,0])rail_end_mount_h();}
      }
    }
  }
  
module base_top() 
  {
    difference()
    {
    translate([0,0,70])rotate([0,180,0])base_half();
    rotate([0,0,60])
      {
        m_holes_l(); 
        rotate([180,0,30])Radial_Array(-120,3,50){translate([72.5,0,-30])rotate([0,-90,0])rail_end_mount_h();}
      }
      Radial_Array(-60,6,110){cylinder (h=200,d=4,center=true,$fn=60);}
    }
  }
module hip_pivot_asm()
  {
    rotate([0,180,-30])Radial_Array(120,3,145){rotate([0,0,-90])hip_pivot();}
    //rotate([0,180,-30])Radial_Array(120,3,145){rotate([0,0,-45])hip_pivot();}
    //rotate([0,180,-30])Radial_Array(120,3,145){rotate([0,0,-135])hip_pivot();}
    
    rotate([0,180,-30])Radial_Array(120,3,95){rotate([0,0,-90])hip_slide();}
    translate([0,0,-70])rotate([0,0,-30])Radial_Array(120,3,95){rotate([0,0,-90])hip_slide();}
    
    rotate([0,0,30])Radial_Array(120,3,145){rotate([0,0,-90])hip_pivot();}
    //rotate([0,0,30])Radial_Array(120,3,145){rotate([0,0,-45])hip_pivot();}
    //rotate([0,0,30])Radial_Array(120,3,145){rotate([0,0,-135])hip_pivot();}
    
    translate([0,0,70])rotate([0,180,30])Radial_Array(120,3,95){rotate([0,0,-90])hip_slide();}
    translate([0,0,-70])rotate([0,0,-30])Radial_Array(120,3,95){rotate([0,0,-90])hip_slide();}
  }
  
module hip_slide()
  {
    rotate([0,0,0])
    color("red",1)translate([0,0,12])
    difference()
    {
      cube ([25,25,15],center=true);
      translate([0,20,-5])cube ([28,22,17],center=true);
      translate([0,-20,-5])cube ([28,22,17],center=true);
      translate([0,0,1])cylinder (h=3,d1=9,d2=16,center=true,$fn=60);
      translate([0,0,6])cylinder (h=8,d=16,center=true,$fn=60);
      translate([0,0,0])cylinder (h=40,d=9,center=true,$fn=60);
      translate([8,8,-5])cylinder (h=20,d=4,center=true,$fn=60);
      translate([8,-8,-5])cylinder (h=20,d=4,center=true,$fn=60);
      translate([-8,8,-5])cylinder (h=20,d=4,center=true,$fn=60);
      translate([-8,-8,-5])cylinder (h=20,d=4,center=true,$fn=60);
      translate([8,-10,5])rotate([90,0,0])cylinder (h=10,d=4,center=true,$fn=60);
      translate([8,10,5])rotate([90,0,0])cylinder (h=10,d=4,center=true,$fn=60);
      translate([-8,-10,5])rotate([90,0,0])cylinder (h=10,d=4,center=true,$fn=60);
      translate([-8,10,5])rotate([90,0,0])cylinder (h=10,d=4,center=true,$fn=60);
    }
  }
  
module hip_pivot()
{ 
  rotate([0,0,0])color("yellow",1)
 { 
  difference()
   {
     union()
     {
       translate([95,0,7.5])cube([10,20,5],center=true); 
       translate([95,0,62.5])cube([10,20,5],center=true);
       translate([50,15,10])cube([100,10,10],center=true);
       translate([50,-15,10])cube([100,10,10],center=true);
       translate([50,15,60])cube([100,10,10],center=true);
       translate([50,-15,60])cube([100,10,10],center=true); 
       rotate([0,0,30])cylinder(h=130,d=40,center=true,$fn=6);
       translate([-15,0,0])cube([5,50,80],center=true); 
     }
     ring (240,197,200,60);
     translate([95,0,24])rotate([0,10,0])cube([40,45,25],center=true); 
     translate([95,0,46])rotate([0,-10,0])cube([40,45,25],center=true);
     translate([-30,-60,50])rotate([0,90,0])Cubic_Array(20,40,0,4,2,1){cylinder(h=50,d=3.5,center=true,$fn=60);}
     cylinder(h=135,d=6,center=true,$fn=60);
     translate([-10,0,62])rotate([0,90,0])cylinder(h=20,d=3.5,center=true,$fn=60);
     translate([-10,0,64])rotate([0,90,0])cube([10,5.6,4],center=true);
     translate([-10,0,60])rotate([0,90,0])cylinder(h=4,d=6.5,center=true,$fn=6);
     translate([-10,0,-62])rotate([0,90,0])cylinder(h=20,d=3.5,center=true,$fn=60);
     translate([-10,0,-64])rotate([0,90,0])cube([10,5.6,4],center=true);
     translate([-10,0,-60])rotate([0,90,0])cylinder(h=4,d=6.5,center=true,$fn=6);
  } 
 }
}

module upper()
  {
  translate([0,0,35])rotate([0,0,30])Radial_Array(120,3,115){rotate([90,0,0])shaft_rail1();}
  translate([0,0,35])rotate([0,0,30])Radial_Array(-120,3,50){rotate([90,0,0])motor_rs_7751();}
  translate([0,0,35])rotate([0,0,30])Radial_Array(-120,3,95){rotate([90,0,0])shaft_m51();}
  color("yellow",1)
    {
    translate([0,0,35])rotate([0,0,30])Radial_Array(-120,3,95){translate([98,-10,-10])rotate([0,-90,0])pully();}
    translate([0,0,35])rotate([0,0,30])Radial_Array(-120,3,50){translate([70.5,-10,10])rotate([0,90,0])pully();}
    }
  translate([0,0,0])rotate([0,0,30])Radial_Array(-120,3,50){translate([67.5,0,35])rotate([0,90,0])motor_mount();}
  translate([0,0,0])rotate([0,180,30])Radial_Array(-120,3,50){translate([72.5,0,-35])rotate([0,-90,0])rail_end_mount();}
  }
  
module lower()
  {
  translate([0,0,-35])rotate([0,0,-30])Radial_Array(-120,3,115){rotate([90,0,0])shaft_rail1();}
  translate([0,0,-35])rotate([0,0,-30])Radial_Array(-120,3,50){rotate([90,0,0])motor_rs_7751();}
  translate([0,0,-35])rotate([0,0,-30])Radial_Array(-120,3,95){rotate([90,0,0])shaft_m51();}
  color("yellow",1)
    {
    translate([0,0,-35])rotate([0,0,-30])Radial_Array(-120,3,95){translate([98,-10,-10])rotate([0,-90,0])pully();}
    translate([0,0,-35])rotate([0,0,-30])Radial_Array(-120,3,50){translate([70.5,-10,10])rotate([0,90,0])pully();}
    
  }
  translate([0,0,0])rotate([180,0,30])Radial_Array(-120,3,50){translate([-67.5,0,35])rotate([0,-90,0])motor_mount();}
  translate([0,0,0])rotate([180,0,30])Radial_Array(-120,3,50){translate([72.5,0,35])rotate([0,-90,0])rail_end_mount();}
}

module rail_end_mount_h()
{
     translate([0,19,-11.5])rotate([0,90,0]) cylinder(h=120,d=3.5,center=true,$fn=60) ;   
}

module rail_end_mount()
{
  color("green",1)
  {
    difference()
    {
      union()
      {
       translate([0,27,-0.5])cube([28,5,15],center=true);
       translate([0,22,-11.5])cube([65,15,14],center=true);
       
      }
    translate([0,19,-11.5])cube([55,10,18],center=true);
     translate([0,19,-11.5])rotate([0,90,0]) cylinder(h=120,d=3.5,center=true,$fn=60) ;   
    translate([9,24,2.5])rotate([90,0,0])cylinder(h=20,d=3.5,center=true,$fn=60) ;  
    translate([-9,24,2.5])rotate([90,0,0])cylinder(h=20,d=3.5,center=true,$fn=60) ; 
    }
  }
}

module motor_mount()
{ 
  color("blue",1)
  {
    difference()
    {
      union()
      {
        difference()
        {
          cube([65,60,5],center=true);
          translate([-25.5,27.5,5])cube([23,30,20],center=true); 
          translate([25.5,27.5,5])cube([23,30,20],center=true); 
        }
        translate([29.5,-10,5])cube([6,45,15],center=true);
        translate([-29.5,-10,5])cube([6,45,15],center=true);
        translate([0,-27.5,-20])cube([65,10,45],center=true);
        translate([0,27,4.5])cube([28,6,5],center=true);
        translate([0,22.5,2.5])rotate([40,0,0])cube([28,8,5],center=true);
        rotate([0,0,90])cylinder (h=5,d=50,center=true,$fn=60);
      }
    rotate([0,0,90])cylinder (h=60,d=20,center=true,$fn=60);
 
           // motor mount holes 
        translate([0,0,0])rotate([0,0,90])
        {
          cylinder(h=25,d=20,center=true,$fn=60);
          translate([0,14.5,0]){cylinder(h=25,d=4,center=true,$fn=60);}
          translate([0,-14.5,0]){cylinder(h=25,d=4,center=true,$fn=60);}
          rotate([0,0,45])Radial_Array (90,4,16){ cylinder(h=10,d=6.5,center=true,$fn=6) ;}
          rotate([0,0,35])Radial_Array (90,4,16){ cylinder(h=10,d=6,center=true,$fn=16) ;}
          rotate([0,0,-35])Radial_Array (90,4,16){ cylinder(h=10,d=6,center=true,$fn=16) ;}
        }
    translate([0,8,8])rotate([0,90,0])cylinder(h=80,d=3.5,center=true,$fn=60) ; 
    translate([0,-28,8])rotate([0,90,0])cylinder(h=80,d=3.5,center=true,$fn=60) ;
    translate([0,-28,-36])rotate([0,90,0])cylinder(h=80,d=3.5,center=true,$fn=60) ; 
    translate([0,-28,-39])cube([55,45,15],center=true);
    translate([9,24,2.5])rotate([90,0,0])cylinder(h=20,d=3.5,center=true,$fn=60) ;  
    translate([-9,24,2.5])rotate([90,0,0])cylinder(h=20,d=3.5,center=true,$fn=60) ;
    translate([-9,22,2.5])cube([7,4,15],center=true);
    translate([9,22,2.5])cube([7,4,15],center=true);    
    }
  }
}

module m_holes_l()
{
  translate([0,0,0])rotate([180,0,30])Radial_Array(-120,3,50){translate([-67.5,0,35])rotate([0,-90,0]){
  translate([0,8,8])rotate([0,90,0])cylinder(h=280,d=3.5,center=true,$fn=60) ; 
  translate([0,-28,8])rotate([0,90,0])cylinder(h=280,d=3.5,center=true,$fn=60) ;
  translate([0,-28,-36])rotate([0,90,0])cylinder(h=280,d=3.5,center=true,$fn=60) ; }}
}  

module base_half()
{
  rotate([0,0,0])color("orangered",1)
  {
    translate([0,0,0])
    {
      
      difference()
      {
        union()
        {
        cylinder(h=5,d=320,center=true,$fn=12);
        translate([0,0,-8])Radial_Array(60,6,79){cube([5,45,11],center=true);}
        rotate([0,0,30])translate([0,0,-8])Radial_Array(60,6,50){cube([60,5,11],center=true);}
        rotate([0,0,30])translate([0,0,-8])Radial_Array(60,6,140){translate([20,0,0])cube([5,30,11],center=true);}
        rotate([0,0,30])translate([0,0,-8])Radial_Array(60,6,140){translate([-20,0,0])cube([5,30,11],center=true);}
        rotate([0,0,30])translate([0,0,-8])Radial_Array(60,6,90){rotate([0,0,-30])translate([-40,0,0])cube([5,55,11],center=true);}
        rotate([0,0,-30])translate([0,0,-8])Radial_Array(60,6,90){rotate([0,0,30])translate([40,0,0])cube([5,55,11],center=true);}
      }
      rotate([0,0,30])cylinder(h=10,d=70,center=true,$fn=6);
      rotate([0,0,-30])Radial_Array(120,3,90){cylinder(h=60,d=60,center=true,$fn=6);}
      
      Radial_Array(60,6,190){rotate([0,0,30])cylinder(h=60,d=140,center=true,$fn=6);}
      
      rotate([0,0,30])Radial_Array(60,6,150){translate([0,0,-2.5])cylinder(h=2.5,d=30,center=true,$fn=60);}
      rotate([0,0,30])Radial_Array(60,6,145){translate([0,0,2.5])rotate([0,0,-90])pot();}
      
      }
    }
    
  }
}

module base_center()
{
  rotate([0,0,0])color("brown",1)
  {
    translate([0,0,0])
    {
      
      difference()
      {
      cylinder(h=5,d=280,center=true,$fn=12);
      rotate([0,0,30])cylinder(h=10,d=70,center=true,$fn=6);
      Radial_Array(60,6,160){rotate([0,0,-30])cylinder(h=60,d=80,center=true,$fn=6);}
      
      rotate([0,0,30])Radial_Array(60,6,150){cylinder(h=60,d=80,center=true,$fn=6);}
      
      rotate([0,0,30])Radial_Array(60,6,145){cylinder(h=60,d=7.5,center=true,$fn=60);}
      
      m_holes_l();
      translate([0,0,0])rotate([180,0,30])Radial_Array(-120,3,50){translate([72.5,0,35])rotate([0,-90,0])rail_end_mount_h();}
      rotate([0,0,60])
      {m_holes_l();
      translate([0,0,0])rotate([180,0,30])Radial_Array(-120,3,50){translate([72.5,0,35])rotate([0,-90,0])rail_end_mount_h();}
    }
      }
    }
  }
}

module pully()
{
   
  import("../stl_parts_dc_motor_version/12_tooth_T5.stl");
   
}

module shaft_rail1()
{ 
  color("yellow",1)
  {
    translate([0,0,40])rotate([0,180,0])
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
          translate([0,11,5.5]){cube([131,3,6],center=true);}
          translate([0,-9.5,34.5]){cube([131,6,6],center=true);}
          translate([0,-11,5.5]){cube([131,3,6],center=true);}
          
          translate([0,7,34.5]){rotate([0,90,0])cylinder(h=131,d=6,center=true,$fn=60);}
          translate([0,9.5,5.5]){rotate([0,90,0])cylinder(h=131,d=6,center=true,$fn=60);}
          translate([0,-7,34.5]){rotate([0,90,0])cylinder(h=131,d=6,center=true,$fn=60);}
          translate([0,-9.5,5.5]){rotate([0,90,0])cylinder(h=131,d=6,center=true,$fn=60);}
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

module end_joint1()
{
  translate([10,0,55])rotate([0,0,0])color("orangered",1)
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

module shaft_m51()
{ 
  translate([0,0,0])
  {
    rotate([0,-90,0])
    {
      translate([0,0,-4])cylinder(h=200,d=5,center=true,$fn=60);
      
      //drive end hw
      translate([0,0,-66.5]){rotate([0,180,0]){ flat_nut (5);}}
      translate([0,0,-65]){rotate([0,180,0]){bearings (625);}}
      //free end hw
      
      translate([0,0,66.5]){rotate([0,0,0]){ flat_nut (5);}}
      translate([0,0,65]){rotate([0,180,0]){bearings (625);}}
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
    translate ([-74,0,-20]){carrage_half();}
    rotate([0,0,180]){translate ([-74,0,-20]){carrage_half1();}}
}
module carrage_half1()
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

module motor_rs_7751()
{
  color("silver",1)
  {
    translate([30,0,0])rotate([0,90,0])
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

