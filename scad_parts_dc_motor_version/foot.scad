// template.scad
//
//*****************************************************************************
//*             (c) 2017 by David Powell (aka AchiestDragon)                  *
//*****************************************************************************
// Notes :-
// 

//  included libs are none printable parts for positional /cutouts & assembly
//  guides unless otherwise stated

//*****************************************************************************



include <shapes.scad>
include <parts_lib.scad>



// per foot parts 
//  foot()  1 of      foot to leg mount bracket 
//  footsw1() 2 of    lower top/bottom plates
//  footsw3() 1 of    upper plate
//  footsw4() 1 of    lower nut cage
//  footpad() 1 of    foot pad (flexible)

//  assembly  
foot(); 
footsw2();  // footsw1 and footsw3 in assembly pos
footsw1();
footsw4();
footpad();


module foot()
{
  color("orangered",1)
  {
    difference()
    {
      union()
      {
        translate([0,0,20]){cube ([6,25,40],center=true);}
        translate([-7.5,0,20]){cube ([10,6,40],center=true);}
        cylinder (h=5,d=45,center=true,$fn=60);
      }
   
    rotate([0,0,0]){
    translate([-12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([-12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    
    
    translate([0,0,165]){
      translate([0,7.5,-145])rotate([0,90,0])cylinder(h=150,d=3.5,center=true,$fn=60); 
      translate([0,-7.5,-145])rotate([0,90,0])cylinder(h=150,d=3.5,center=true,$fn=60);
  
      translate([0,7.5,-130])rotate([0,90,0])cylinder(h=150,d=3.5,center=true,$fn=60); 
      translate([0,-7.5,-130])rotate([0,90,0])cylinder(h=150,d=3.5,center=true,$fn=60);
    }
      
      Radial_Array (90,4,22)
        {
          cylinder(h=30,r=10,center=true,$fn=6);
        }}
    }  
  }
}

module footsw2()
{ 
translate([0,0,15]){footsw3();}
translate([0,0,-10]){footsw1();}
}

module footsw1()
{
  translate ([0,0,-20])
 {
  color("orangered",1)
  {
    difference()
    {
      union()
      {
         cylinder (h=3,d=45,center=true,$fn=60);
      }
     translate([0,0,0]){cylinder(h=60,d=15,center=true,$fn=60);}
      
    translate([-12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([-12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    
    rotate([0,0,45]){
    translate([-12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([-12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
        }
    }  
  }
}
 
}

module footsw3()
{
  translate ([0,0,-20])
 {
  color("orangered",1)
  {
    difference()
    {
      union()
      {
         cylinder (h=3,d=45,center=true,$fn=60);
      }
     translate([0,0,0]){cylinder(h=60,d=15,center=true,$fn=60);}
      
    translate([-12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([-12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    
    rotate([0,0,45]){
    translate([-12,12,0]){cylinder(h=60,d=6,center=true,$fn=60);}
    translate([12,-12,0]){cylinder(h=60,d=6,center=true,$fn=60);}
    translate([-12,-12,0]){cylinder(h=60,d=6,center=true,$fn=60);}
    translate([12,12,0]){cylinder(h=60,d=6,center=true,$fn=60);}
        }
    }  
  }
}
}
module footsw4()
{
  translate ([0,0,-25])
 {
  color("orangered",1)
  {
    difference()
    {
      union()
      {
         cylinder (h=4,d=45,center=true,$fn=60);
      }
     
      
    translate([-12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([-12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    
    rotate([0,0,45]){
    translate([-12,12,0]){cylinder(h=60,d=6,center=true,$fn=6);}
    translate([12,-12,0]){cylinder(h=60,d=6,center=true,$fn=6);}
    translate([-12,-12,0]){cylinder(h=60,d=6,center=true,$fn=6);}
    translate([12,12,0]){cylinder(h=60,d=6,center=true,$fn=6);}
        }
    }  
  }
}
}
module footpad()
{
  translate ([0,0,-30]){
  color("blue",1)
  {
    difference()
    {
     translate([0,-0,-00]){sphere (d=50,center=true,$fn=60);}
     translate([0,0,20]){rotate ([00,0,0]){cylinder (h=50,d=55,center=true,$fn=60);}}
     translate([-12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
     translate([12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
     translate([-12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
     translate([12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}  

     translate([-12,12,-38]){cylinder(h=60,d=12,center=true,$fn=60);}
     translate([12,-12,-38]){cylinder(h=60,d=12,center=true,$fn=60);}
     translate([-12,-12,-38]){cylinder(h=60,d=12,center=true,$fn=60);}
     translate([12,12,-38]){cylinder(h=60,d=12,center=true,$fn=60);}  
    
     translate([-12,12,-1.5]){cylinder(h=10,d=6,center=true,$fn=6);}
     translate([12,-12,-1.5]){cylinder(h=10,d=6,center=true,$fn=6);}
     translate([-12,-12,-1.5]){cylinder(h=10,d=6,center=true,$fn=6);}
     translate([12,12,-1.5]){cylinder(h=10,d=6,center=true,$fn=6);}  
    }
  }
}
}