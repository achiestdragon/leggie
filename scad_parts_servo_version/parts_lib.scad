// parts_lib.scad
//   (c)2018 by david Powell   AKA AchiestDragon
//
// usa as :- include<parts_lib.scad>
//
// provides :-
// ------------
//printer_bed();        // 3d printer bed size allignment guide
//motor();              // 12v 12000 rpm 3mm shaft
//microswitch();        // small microswitch 
//shaft_coupler();      // 3mm to 3mm shaft coupler 
//encoder_disk();       // optical encoder disk 2 vains  3mm mounting 
//slot_sensor();        // slotted opto switch
//selonoid();           // lift/hold seloniod 2.5kg 20mm dia 15mm h
//bearings(type);       // from lib MCAD-dev but only type input =skate =683 etc
//mg996();              // MG996 metal gear servo
//mg996_cutout();       // servo cutout/mounting hole csg shape
//eurocard ();          // quick load from pre rendered stl files
//


// includes
include <MCAD/hardware/bearing.scad>
//include <MCAD/fasteners/metric_fastners.scad>
include <shapes.scad>

//  ***************************************************

module  printer_bed()
{
  color("red",1)
  {
    difference()
    {  
      translate ([0,0,-1]){cylinder ( h=1 , d=340 , center =true ,$fn=360);}
      translate ([0,0,-1]){cylinder ( h=2 , d=330 , center =true ,$fn=360);}
    }
  } 
  color("green",1)
  {
    translate ([0,0,-1]){cylinder ( h=1 , d=330 , center =true ,$fn=360);}
  }
  # translate ([0,0,250]){cylinder ( h=500 , d=340 , center =true ,$fn=360);} 
}

module bearings(type)   // from lib MCAD-dev but only type input
{
  bearing(pos=[0,0,0],angle=[0,0,0],model=type,outline=false,material=1,sideMaterial=BlackPaint,center=true);
}


module selonoid()
//seloniod 2.5kg 
{
  color("silver",1)
  {
    difference()
    {
      union()
      {
        difference()
        {
        cylinder(h=15,d=20,center=true,$fn=60);
        cylinder(h=16,d=18,center=true,$fn=60);
        }
      translate([0,0,2.5]){cylinder(h=10,d=20,center=true,$fn=60);}
      translate([0,0,0]){cylinder(h=15,d=8,center=true,$fn=60);}
      
      }
    translate([0,0,2.5]){cylinder(h=11,d=3,center=true,$fn=60);}
    rotate([0,90,45]){translate([-4,0,1.5]){cylinder(h=21,d=4,center=true,$fn=60);}}
    }
    
  }
  color("black",1){cylinder(h=13,d=18,center=true,$fn=60);}
}

module microswitch()
{
color("black",1)
{
difference()
{
cube([13,6,6.3],center =true);
translate ([-3,0,-1.5]){rotate([90,0,0]){cylinder(h=40,d=2,center=true,$fn=30);}}
translate ([3,0,-1.5]){rotate([90,0,0]){cylinder(h=40,d=2,center=true,$fn=30);}}
}
}
color("silver",1)
{
translate ([0,0,-4.4]){cube([1,1,6],center =true);}
translate ([-5,0,-4.4]){cube([1,1,6],center =true);}
translate ([5,0,-4.4]){cube([1,1,6],center =true);}

translate ([0,0,4.4]){rotate([0,10,0]){cube([13,3,0.3],center =true);}}
}
}
//motor();

module motor()
{
  color("silver",1)
  {
    rotate([0,-90,0])
    {
    difference()
      {
      union()   //main motor body
        {
        cylinder(h=58,d=36,center=true,$fn=240);
        translate([0,0,7]){cylinder(h=38,d=38,center=true,$fn=240);}
        translate([0,0,30]){cylinder(h=3,d=10,center=true,$fn=60);}
        translate([0,0,30]){cylinder(h=25,d=3,center=true,$fn=60);}
        // power lugs
        translate([0,12.5,-30]){cube([3,1,12],center=true);}
        translate([0,-12.5,-30]){cube([3,1,12],center=true);}
        }
      union()   //mounting holes 
        {
      translate([0,12.5,30]){cylinder(h=25,d=2.6,center=true,$fn=60);}
      translate([0,-12.5,30]){cylinder(h=25,d=2.6,center=true,$fn=60);}
        }
      }
    }
  }
}

module shaft_coupler()
{
  //3mm shaft coupler 
  color("green",1)
  {
    translate ([0,0,0])
    {
      rotate([0,90,0])
      {
        difference()
        {
          cylinder(h=20,d=12,center=true,$fn=60);
          cylinder(h=22,d=3.1,center=true,$fn=60);
        }
      }
    }
  }
  color("black",1)
  {
    translate ([4.5,0,2.5]){cylinder(h=7,d=4,center=true,$fn=60);}
   translate ([-4.5,0,2.5]){cylinder(h=7,d=4,center=true,$fn=60);} 
  }
}
module encoder_disk()
{ 
  color("red",1)
  {  
  rotate([0,90,0])
  {
    difference()
    {
      union()
      {
      cylinder(h=1,d=8,center=true,$fn=60);
    
      difference()
      {
        translate([0,0,1.25]){cylinder(h=1.5,d=8,center=true,$fn=60);}
        translate([0,0,1.5]){cylinder(h=2,d=5.5,center=true,$fn=6);}
      }
      
      difference()
      {
        cylinder(h=1,d=22,center=true,$fn=60);
        translate([6,6,0]){cube([12,12,12],center=true);}
        translate([-6,-6,0]){cube([12,12,12],center=true);}
      }
    }
    cylinder(h=6,d=3.2,center=true,$fn=60);
}
}}}

module slot_sensor()
{ 
  color("black",1)
  {
  difference()
  {  
    translate([0,0,-6]){cube([6.35,23.75,2.03,],center=true);}
    translate([0,-9.5,-5]){cylinder(h=15,d=2.5,center=true,$fn=20);}
    translate([0,9.5,-5]){cylinder(h=15,d=2.5,center=true,$fn=20);}
  }
  difference()
    { 
      cube([6.35,12.95,10.54],center=true);
      translate([0,0,2.54]){cube([7,3.18,10.54],center=true);}
    }
  }
  color("silver",1)
  {
    translate([1.5,-5,-12]){cube([1,1,15],center=true);}
    translate([-1.5,-5,-12]){cube([1,1,15],center=true);}
    translate([1.5,5,-12]){cube([1,1,15],center=true);}
    translate([-1.5,5,-12]){cube([1,1,15],center=true);}
  }

}

module eurocard() // quick load from pre rendered stl files
{
  color ("khaki",1) {import ("euro_a.stl");}
  color ("lightslategray",1){ import ("euro_b.stl");}
}


module pot()
{
  color("silver",1)
  {
    translate([0,0,10])
    {
      difference()
      {
        cylinder(h=14,d=6,center=true,$fn=60);
        translate([7,0,0]){cube([10,10,15],center=true);}
      }
    }    
    cylinder(h=8,d=6,center=true,$fn=60);
    cylinder(h=6,d=7,center=true,$fn=60);
    translate ([0,0,-8]){cylinder(h=8,d=16,center=true,$fn=60);}
    translate ([0,0,1]){cylinder(h=2,d=12,center=true,$fn=6);}
    translate ([0,0,-5]){cylinder(h=4,d=10,center=true,$fn=60);}
    translate ([0,0,-4]){cube([8,18,2],center=true);}
    translate ([0,-7,-2]){cylinder(h=4,d=3,center=true,$fn=60);}   
    translate ([4,0,-6]){cube([10,15,2],center=true);}
    translate ([8,0,-6]){cube([15,1,1],center=true);}
    translate ([8,5,-6]){cube([15,1,1],center=true);}
    translate ([8,-5,-6]){cube([15,1,1],center=true);}
  }
}

// MG996 metal gear servo
module mg996() // MG996 metal gear servo
{
  color("blue",1)
  {
    difference()
    {
      union()
      { 
        translate ([0,-10,-11]){cube ([21,40,41],center=true);}
        translate ([0,-10,1.5]){cube ([21,55,3],center=true);}
        translate ([0,0,5]){cylinder(h=20,d=5,center=true,$fn=30);}
        translate ([0,0,1]){cylinder(h=20,d=12,center=true,$fn=30);}
      }
      translate ([5,-34.5,1.5]){cylinder(h=20,d=4,center=true,$fn=30);}
      translate ([-5,-34.5,1.5]){cylinder(h=20,d=4,center=true,$fn=30);}
      translate ([5,14.5,1.5]){cylinder(h=20,d=4,center=true,$fn=30);}
      translate ([-5,14.5,1.5]){cylinder(h=20,d=4,center=true,$fn=30);}
    } 
  }
    color("black",1)
  {
    difference()
    {
      union()
      {
        translate ([0,0,13])
        {
          rotate([0,180,0]){cylinder(h=5,d=7,center=true,$fn=60);}
        }
        Radial_Array (60,6,0)
        {
          translate ([0,0,14.5])
          {
            rotate([0,180,90]){cube([32,5,2],center=true);}
          }
        }
      }
    translate ([0,0,14.5])
      {
        rotate([0,180,0]){cylinder(h=10,d=3,center=true,$fn=60);}
      }
    Radial_Array (60,6,7){cylinder(h=60,d=1,center=true,$fn=60);}
    Radial_Array (60,6,10){cylinder(h=60,d=1,center=true,$fn=60);}
    Radial_Array (60,6,13){cylinder(h=60,d=1,center=true,$fn=60);}
    } 
  }
  translate ([0,0,17]){rotate([0,180,0]){bolt(3,15);}}
}

// MG996 metal gear servo mounting cutout
module mg996_cutout() // servo cutout/mounting hole csg shape
{
    union()
    { 
      translate ([0,-10,-11]){cube ([22,42,42],center=true);}
      translate ([0,-10,1.5]){cube ([22,55,3],center=true);}
      translate ([0,0,5]){cylinder(h=20,d=5,center=true,$fn=30);}
      translate ([0,0,1]){cylinder(h=20,d=12,center=true,$fn=30);}

    translate ([5,-34.5,1.5]){cylinder(h=20,d=4,center=true,$fn=30);}
    translate ([-5,-34.5,1.5]){cylinder(h=20,d=4,center=true,$fn=30);}
    translate ([5,14.5,1.5]){cylinder(h=20,d=4,center=true,$fn=30);}
    translate ([-5,14.5,1.5]){cylinder(h=20,d=4,center=true,$fn=30);}
  } 
}
