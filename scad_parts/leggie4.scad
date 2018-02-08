// l-egg-ie 4 hexapod robot <leggie4.scad>   rev 1.0a  7 feb 2018
// 
//*****************************************************************************
//*             (c) 2018 by David Powell (aka AchiestDragon)                  *
//*****************************************************************************
// Notes :-

// TODO :-

//  extras todo 
//  extra cam mounting tilt servo mounting
//  extra cam mounting tilt assembly
//  extra cam mount cam / sensor  holder
//



//*****************************************************************************
// Libraries :-     (local directory libs) 

// from https://www.thingiverse.com/thing:2023897
//include <raspberrypi.scad>
include <parts_lib.scad>
include <shapes.scad> // csg shapes/functions


//*****************************************************************************
// Varibles :-
ah =0;
//*****************************************************************************
// Constants :-

//*****************************************************************************
// Code module calls :-
// printable parts assembly position 
//module                    material                     print gcode name
//---------               -------------                  ----------------
//base_bottom();     // print  black pla 1 off           base_bottom
//base_top();        // print  black pla 1 off           base_top
//base_sup();        // print  black pla 1 off           base_sup

//top();             // print  orange pla 2 off          top
//top1();            // print  black pla 1 off           top1
//top2();            // print  black pla 1 off           top2
//top3();            // print  black pla 1 off           top3
//top4();            // print  black pla 1 off           top4
//bottom();          // print  orange pla 2 off          top
//bottom1();         // print  black pla 1 off           bottom1
//camtower();        // print  orange pla 6 off          camtower(6of)
//camp();            // no print cam tower assembled
//hipasm(ah);        // no print all hips assmbled        
//topasm();          // no print bottom t&b assembled
//hipa();            // print  orange pla 18 off        ...hip(3of)
//hipb();            // print  orange pla 18 off        ...hip(3of)
//hipc();            // print  orange pla 6 off         ...hip(1of)
//hipd();            // no print for asm view           
//knee();            // no print for asm view           
//kneea();           // print orange pla 6 off          ...hip(1of)

//legasm();          // no print assembled leg parts        

//lower_leg();       // print black pla 6 off           ...leg(1of)
//legr();            // print black pla 6 off           ...leg(1of)
//legl();            // print black pla 6 off           ...leg(1of)
//legsup();          // print black pla 12 off          ...leg(2of)

//foot();            // print orange pla 6 off          ...foot(1of)
//footsw();          // print orange pla 6 off          ...foot(1of)
//footsw1();         // print orange pla 12 off         ...foot(2of)
//footsw2();         // ...                             ...foot(0of)
//footsw3();         // print orange pla 6 off          ...foot(1of)
//footpad();         // print black flexible 6 off      footpad 
//logo();            // print black pla 1 off           logo

// print times
//  part            material   quant     time per print   total time per set
// --------------- ----------- ------  ---------------- ---------------------
//  base top       black pla     1x       4hr30                  4hr30
//  base bottom    black pla     1x       4hr17                  4hr17
//  base supp      black pla     1x       4hr15                  4hr15 
//  top /(bottom)  orange pla    4x       4hr21                 17hr24
//  top1           black pla     1x       2hr07                  2hr07
//  top2 (feet)    black pla     1x       2hr50 est              2hr50
//  top3 (ring)    black pla     1x          42                     42
//  top4 (cam)     black pla     1x 
//  camtower set   orange pla    1x       1hr40                  
//  bottom1 (bat)  black pla     1x       2hr07                  2hr07
//  hip and knee   orange pla    6x       5hr07                 30hr32
//  leg            black pla     6x       4hr45                 28hr30
//  foot           orange pla    6x       1hr51                 11hr06
//  foot pad       black flex    6x          40                  4hr00
//  logo           black pla     1x          20 est                 20
//
//                                                        ----------------
//                                       total print time  
//                                                        ----------------

// non print parts assembly positions
//base_hw();
//hip_hw();

// other code modules 
//servo_cut();
//servo();

//*****************************************************************************
// Code :-
module logo()
{
color("black",1)
{
difference()
  {
   cube ([55,20,2],center=true);
   translate([0,0,-1.5])
    {
    linear_extrude(height = 4) 
      {
        text( "LEGGIE",
        size = 10,
        font = "Liberation Sans",
        valign="center",
        halign="center");
      }
    }
  }
  Cubic_Array (57,23,0,2,2,1,center=true){ ring(10,3.5,2,60) ;}
}
}
module topasm()
{
  translate([0,0,-135])
  {
    bottom();top(); 
  } 
}

module camp()
{
  Radial_Array (60,6,0){ camtower() ;}
}
module camtower()

translate([0,-52.5,180]){
{
  color("orangered",1)
  {
    difference()
    {
      rotate([0,90,0]){cube([100,35,10],center=true);}
      translate([0,-12.5,0]){cylinder(h=200,d=4,center=true,$fn=60);}
      translate([0,12.5,0]){cylinder(h=200,d=4,center=true,$fn=60);}
      translate([0,25,0]){cube([20,35,90],center=true);}
      translate([0,-25,10]){cube([20,35,110],center=true);}
      translate([0,-22,6.5]){rotate([-5,0,0]){cube([20,40,100],center=true);}}
      translate([0,22,-6.5]){rotate([-5,0,0]){cube([20,40,100],center=true);}}
    }
  }
}}

module legsup()
{
  color("black",1){
  difference()
  {
  translate([0,33,22.5]){cube([30,8,42],center=true);}
  
  Radial_Array (180,2,25)
    {
      cylinder(h=90,r=10,center=true,$fn=6);
    }
  Radial_Array(180,2,33)
      {
        translate ([-12,0,0]){cylinder(h=100,d=4,center=true,$fn=60);}
        translate ([12,0,0]){cylinder(h=100,d=4,center=true,$fn=60);}
      }
  translate([0,0,22.5])
   {
    translate([12,0,0]){rotate([90,0,0]){cube([7,32,100],center=true,$fn=4);}}
    
    translate([0,0,7]){rotate([90,0,0]){ rotate([0,0,90]){cylinder(h=300,d=11,center=true,$fn=6);}}}
    translate([0,0,-7]){rotate([90,0,0]){ rotate([0,0,90]){cylinder(h=300,d=11,center=true,$fn=6);}}}
    translate([-12,0,0]){rotate([90,0,0]){cube([7,32,100],center=true,$fn=4);}}
   }
  legr();            
  legl();   
  }
}}

module legasm()
{ Radial_Array(60,6,305){
  translate([22,0,20]){rotate([0,-90,0]){legr();legl();legsup();rotate([0,0,180]){legsup();}}}
}
  Radial_Array(60,6,400){
  translate([-50,0,40]){lower_leg(); }}
}

module bottom()
{
  color("orangered",1)
  {
    translate([0,0,65])
    {
      rotate([0,180,30])
      {  
        difference()
        {
          cylinder(h=40,d1=205,d2=150,center=true,$fn=6);
          cylinder(h=40.2,d1=200,d2=146,center=true,$fn=6);
          rotate([0,0,30]){Radial_Array(60,6,90){translate([0,0,0]){cylinder (h=90,d= 4,center=true,$fn= 60);}}}
        }
      }
      Radial_Array(60,6,90){translate([0,0,0]){ring (10, 4, 40, 60);}}
      Radial_Array(60,6,90){translate([0,0,19]){ring (19, 4, 2, 60);}}
    }
  }
}

module top()
{
  color("orangered",1)
  {
    translate([0,0,108])
    {
      rotate([0,0,30])
      {  
        difference()
        {
          cylinder(h=40,d1=205,d2=150,center=true,$fn=6);
          cylinder(h=40.2,d1=200,d2=146,center=true,$fn=6);
          rotate([0,0,30]){Radial_Array(60,6,90){translate([0,0,0]){cylinder (h=90,d= 4,center=true,$fn= 60);}}}
        }
      }
      Radial_Array(60,6,90){translate([0,0,0]){ring (10, 4, 40, 60);}}
      
      Radial_Array(60,6,90){translate([0,0,-19]){ring (19, 4, 2, 60);}}
    }
  }
}

module bottom1()
{
  color("blue",1)
  {
    translate([0,0,65])
    {
      rotate([0,0,30])
      {  
        difference()
        {
          union()
          {
            cylinder(h=3,d=175,center=true,$fn=6);
            translate([0,25,-5]){cube ( [100,4,10],center=true);}
            translate([0,-25,-5]){cube ( [100,4,10],center=true);}
            translate([0,0,-3]){rotate([0,0,45]){Radial_Array(90,4,65){translate([0,0,0]){
            ring( 10,4,5,60);}}}}
            translate([72,0,-5]){cube ( [4,20,10],center=true);}
            translate([-72,0,-5]){cube ( [4,20,10],center=true);}
          }  
          Cubic_Array (45,40,0,2,2,1,center=true){ 
          cube ([25,5,25],center=true);}
          Cubic_Array (45,60,0,2,2,1,center=true){ 
          cube ([25,5,25],center=true);}
          translate([0,50,-5]){cube ([60,25,25],center=true);}
          translate([0,-50,-5]){cube ([60,25,25],center=true);}
          rotate([0,0,45]){Radial_Array(90,4,65){translate([0,0,0]){
            cylinder(h=8,d=4,center=true,$fn=60);}}}
         
        }
      }
      Radial_Array(60,6,90){translate([0,0,0]){
        ring (20, 4, 3, 60);
        }} 
      
          }}
    
  
}

module top1()
{
  color("black",1)
  {
    translate([0,0,130])
    {
      rotate([0,0,30])
      {  
        difference()
        {
          cylinder(h=3,d=175,center=true,$fn=6);
          cylinder(h=6,d=40,center=true,$fn=6);
          Radial_Array(60,6,45){translate([0,0,0]){
            cylinder(h=6,d=40,center=true,$fn=6);
            
        }}
        rotate([0,0,30]){Radial_Array(60,6,65){translate([0,0,0]){
            cylinder(h=8,d=4,center=true,$fn=60);}}}
        rotate([0,0,30]){Radial_Array(60,6,25){translate([0,0,0]){
            cylinder(h=8,d=4,center=true,$fn=60);}}}
        }
      }
      Radial_Array(60,6,90){translate([0,0,0]){
        ring (20, 4, 3, 60);
        }}
    }
  }
}

module top2()
{
  color("blue",1)
  {
    translate([0,0,85])
    {
      rotate([0,0,30])
      {  
        difference()
        {
          cylinder(h=3,d=175,center=true,$fn=6);
          cylinder(h=6,d=40,center=true,$fn=6);
          Radial_Array(60,6,45){translate([0,0,0]){
            cylinder(h=6,d=40,center=true,$fn=6);
            
        }}
        rotate([0,0,30]){Radial_Array(60,6,65){translate([0,0,0]){
            cylinder(h=8,d=4,center=true,$fn=60);}}}
        rotate([0,0,30]){Radial_Array(60,6,25){translate([0,0,0]){
            cylinder(h=8,d=4,center=true,$fn=60);}}}
        }
      }
      Radial_Array(60,6,90){translate([0,0,0]){
        ring (20, 4, 3, 60);
      }}
      Radial_Array(60,6,90){translate([0,0,4]){
        ring (25, 15, 11, 60);
        }}
      
    }
  }
}
module top3()
{
  color("blue",1)
  {
    translate([0,0,40])
    {
      rotate([0,0,30])
      {  
        difference()
        {
          cylinder(h=3,d=206,center=true,$fn=6);
          cylinder(h=6,d=195,center=true,$fn=6);
          Radial_Array(60,6,45){translate([0,0,0]){
            cylinder(h=6,d=40,center=true,$fn=6);
            
        }}
        rotate([0,0,30]){Radial_Array(60,6,65){translate([0,0,0]){
            cylinder(h=8,d=4,center=true,$fn=60);}}}
        rotate([0,0,30]){Radial_Array(60,6,25){translate([0,0,0]){
            cylinder(h=8,d=4,center=true,$fn=60);}}}
        }
      }
      Radial_Array(60,6,90){translate([0,0,0]){
        ring (20, 4, 3, 60);
      }}
    }
  }
}
module top4()
{
  color("black",1)
  {
    translate([0,0,235])
    {
      rotate([0,0,30])
      {  
        difference()
        {
          cylinder(h=3,d=95,center=true,$fn=6);

        rotate([0,0,30]){Radial_Array(60,6,40){translate([0,0,0]){
            cylinder(h=8,d=4,center=true,$fn=60);}}}
        translate([0,0,1.5]){servo_cut(); }  
        }
      }
    }
  }
}
module base_sup()
{
  color("black",1)
  {
    difference()
    {
      union()
      {
        Radial_Array(60,6,90){translate([0,0,22.5]){ring (10, 4, 42.5, 60);}}
        Radial_Array (60,6,125)
        {
          translate([0,-29.75,22.5]){rotate([0,0,0]){
            cube([30.25,2,42.5],center=true);
            }}
        } 
        rotate([0,0,30])
        {
          Radial_Array (60,6,90){translate([0,-0,22.5]){
            cube([70,2,42.5],center=true);}}
        }
      }
      rotate([0,0,30]){translate ([0,0,22.5])
      {
        Radial_Array (60,6,100)
        {
          rotate([90,0,0])
          {
            translate ([-15,0,00]){rotate([0,0,30]){
              cylinder(h=30,d=30,center=true,$fn=6);}}
            translate ([15,0,00]){rotate([0,0,30]){
              cylinder(h=30,d=30,center=true,$fn=6);}}
          }
        }
      }
    }       
    Radial_Array (60,6,100)
      {
        translate ([-10,0,22]){rotate([90,0,0]){
          cylinder(h=30,d=10,center=true,$fn=60);}}
        translate ([10,0,22]){rotate([90,0,0]){
          cylinder(h=30,d=10,center=true,$fn=60);}}
      }
    }
  }
}

module base_bottom()
{
  translate([0,0,45]){rotate([180,0,0])
  {
    color("black",1)
    {
      difference()
      {
        union()
        {
          // main outer shape
          Radial_Array (60,6,140){cylinder(h=3,d=50,center=true,$fn=6);}
          Radial_Array (60,6,115){cube([40,50,3],center=true,$fn=6);}
          rotate([0,0,30]){cylinder(h=3,d=230,center=true,$fn=6);}
          //support rails outer
          Radial_Array (60,6,125)
          {
            translate([15,0,2]){rotate([-2,0,0]){cube([3,50,5],center=true);}}
            translate([-15,0,2]){rotate([-2,0,0]){cube([3,50,5],center=true);}}
            translate([0,-26,3]){rotate([0,0,0]){cube([33,3,5],center=true);}}
          } 
          rotate([0,0,30])
          {
            Radial_Array (60,6,92.5){translate([0,-0,3]){
              cube([75,3,5],center=true);}}
          }
        }
        //pi holes
        translate([-2,0,0])
        {
          translate([-85/2+3.5,-49/2,-10]){cylinder(d=3,h=30);}
          translate([-85/2+3.5, 49/2,-10]){cylinder(d=3,h=30);}
          translate([58-85/2+3.5,-49/2,-10]){cylinder(d=3,h=30);}
          translate([58-85/2+3.5, 49/2,-10]){cylinder(d=3,h=30);}
        }
        // servo cutouts 
        Radial_Array (60,6,140)
        {
          translate ([0,0,-2]){rotate([180,0,-90]){pot();}}
        }
        // hex holes
        rotate([0,0,30])
        {
          cylinder(h=30,r=30,center=true,$fn=6);
          Radial_Array (60,6,60)
          {
          cylinder(h=30,r=30,center=true,$fn=6);
          }
        }
        // support holes
        Radial_Array(60,6,90)
        {
          cylinder(h=8,d=4,center=true,$fn=60);     
        }        
      }
    }
  }}
}

module base_top()
{
  color("black",1)
  {
    difference()
    {
      union()
      {
        // main outer shape
        Radial_Array (60,6,140){cylinder(h=3,d=50,center=true,$fn=6);}
        Radial_Array (60,6,115){cube([40,50,3],center=true,$fn=6);}
        rotate([0,0,30]){cylinder(h=3,d=230,center=true,$fn=6);}
        //support rails outer
        Radial_Array (60,6,125)
        {
          translate([15,0,2]){rotate([-2,0,0]){cube([3,50,5],center=true);}}
          translate([-15,0,2]){rotate([-2,0,0]){cube([3,50,5],center=true);}}
          translate([0,-26,3]){rotate([0,0,0]){cube([33,3,5],center=true);}}
        } 
        rotate([0,0,30])
        {
          Radial_Array (60,6,92.5){translate([0,-0,3]){
            cube([75,3,5],center=true);}}
        }
      }
      //pi holes
      translate([-2,0,0])
      {
        translate([-85/2+3.5,-49/2,-10]){cylinder(d=3,h=30);}
        translate([-85/2+3.5, 49/2,-10]){cylinder(d=3,h=30);}
        translate([58-85/2+3.5,-49/2,-10]){cylinder(d=3,h=30);}
        translate([58-85/2+3.5, 49/2,-10]){cylinder(d=3,h=30);}
      }
      // servo cutouts 
      Radial_Array (60,6,140)
      {
        translate ([0,0,-2]){rotate([0,180,0]){ servo_cut() ;}}
        //translate ([0,0,45]){rotate([0,0,-90]){pot();}}
      }
      // hex holes
      rotate([0,0,30])
      {
        cylinder(h=30,r=30,center=true,$fn=6);
        Radial_Array (60,6,60)
        {
          cylinder(h=30,r=30,center=true,$fn=6);
        }
      }
      // support holes
      Radial_Array(60,6,90)
      {
        cylinder(h=8,d=4,center=true,$fn=60);
      }
    }
  }
}

// TODO:- MOVE THIS MODULE TO parts_lib.scad
// MG996 metal gear servo
module servo() // none printable assembly part
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

// TODO:- MOVE THIS MODULE TO parts_lib.scad
// MG996 metal gear servo mounting cutout
module servo_cut() // servo cutout/mounting hole csg shape
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

module base_hw() // servos and pots and pi3 parts in base assembly 
{  
    translate ([-2,0,40]){rotate([180,0,0]){
       // needs pi3 scad file https://www.thingiverse.com/thing:2023897 
            pi3 ();}}
       // servo cutouts 
      Radial_Array (60,6,140)
      {
        translate ([0,0,-2]){rotate([0,180,0]){ servo() ;}}
        translate ([0,0,47]){rotate([0,0,-90]){pot();}}
      }
    }
    
module hip_hw() // servos and pots in hip assembly 
{  
    
  // servo 
      Radial_Array (60,6,190)
      {
        translate ([5,35,42]){rotate([0,-90,0])
        {
          translate ([-22,0,-18]){rotate([0,180,180]){ servo() ;}}
          translate ([-22,0,30.5]){rotate([0,0,90]){pot();}}
        }}
      }
      //knee
      Radial_Array (60,6,350)
      {
        translate ([5,35,42]){rotate([0,-90,0])
        {
          translate ([-22,0,-18]){rotate([0,180,0]){ servo() ;}}
          translate ([-22,0,30.5]){rotate([0,0,-90]){pot();}}
        }}
      }
    }

module hipa() //  hip part a
{
  color("orangered",1)   
  {
    difference()
    {
      union()
      {
        translate([0,0,-20]){cylinder(h=3,d=50,center=true,$fn=6);}
        translate([0,20,-20]){cube([40,40,3],center=true);}
        translate([0,37,-15]){cube([40,6,13],center=true);}
      }
      cylinder(h=180,d=8,center=true,$fn=60);
      Radial_Array(60,6,10){slot(2.6,8,80,90);}
      translate([12.5,40,-14]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([-12.5,40,-14]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
    }     
  }
}

module hipb() //  hip part b
{
  color("orangered",1)   
  {
    difference()
    {
      union()
      {
        translate([0,0,60]){cylinder(h=3,d=50,center=true,$fn=6);}
        translate([0,20,60]){cube([40,40,3],center=true);}
        translate([0,37,55]){cube([40,6,13],center=true);}
        translate([0,0,55]){cylinder(h=8,d=30,center=true,$fn=6);}
      }
      translate([0,0,55]){cylinder(h=30,d=7,center=true,$fn=60);}
      translate([0,0,55]){ rotate([90,0,0])
      {
       translate([0,0,10]){cylinder(h=15,d=3.3,center=true,$fn=60);}
       translate([0,0,8]){rotate([0,0,90]){cylinder(h=3,d=5.7,center=true,$fn=6);}}
       translate([0,-4,8]){cube([5.3,10,3],center=true);}
          }}
      translate([12.5,40,54]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([-12.5,40,54]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
    }     
  }
}

module hipc() //  hip part c
{
  color("orangered",1)   
  {
    difference()
    {
      union()
      {
        translate([0,42,20]){cube([40,6,83],center=true);}
        translate([0,42,20]){cube([83,6,40],center=true);}
        translate([0,42,20]){rotate([0,45,0]){cube([87,6,30.5],center=true);}}
        translate([0,42,20]){rotate([0,-45,0]){cube([87,6,30.5],center=true);}}
      }
      translate([12.5,40,-14]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([-12.5,40,-14]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([12.5,40,54]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([-12.5,40,54]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      
      translate([0,40,20]){
        
        rotate([90,0,0]){Radial_Array (60,6,22){cylinder(h=50,d=20,center=true,$fn=6);}
        }
        rotate([90,0,0]){cylinder(h=50,d=20,center=true,$fn=60);}
        }
    translate([-20,0,20]){rotate([0,90,0]){     
      translate([12.5,40,-14]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([-12.5,40,-14]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([12.5,40,54]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([-12.5,40,54]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}}}
    }
  }
}

module kneea()
{
  color("orangered",1)   
  {
    difference()
    {
      union()
      {
        translate([0,42,20]){cube([83,6,40],center=true);}
      }
      translate([0,0,20]){
      translate([12.5,40,-12.5]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([-12.5,40,-12.5]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([12.5,40,12.5]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([-12.5,40,12.5]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      }
      translate([0,40,20])
      {
        rotate([90,0,0]){cylinder(h=50,d=20,center=true,$fn=60);}
        }
    translate([-20,0,20]){rotate([0,90,0]){     
      translate([12.5,40,-14]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([-12.5,40,-14]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([12.5,40,54]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([-12.5,40,54]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}}}
    }
  }
}

module hipd()
{
  translate([20,85,20]){rotate([0,90,180]){hipa();hipb();}}
}
 
module knee()
{
  rotate([0,180,0])
  {
    translate([-20,245,-20]){rotate([0,90,0]){hipa();hipb();}}
  }
}
module hipasm(ah)  
{
  Radial_Array (60,6,140)
      {
        rotate([0,0,ah]){
  hipa();hipb();hipc();hipd();knee();
        translate([0,245,0]){  kneea();}
      }}
}

module legr()
{
  color("black",1)
  {
    difference()
    {
      union()
      {
        // main outer shape
        Radial_Array (180,2,80){cylinder(h=3,d=50,center=true,$fn=6);}
        cube([40,150,3],center=true,$fn=6);
        translate([17,0,3]){{cube([3,80,5],center=true);}}
        translate([-17,0,3]){{cube([3,80,5],center=true);}}
        //support rails outer
        Radial_Array (180,2,65){
          translate([15,0,2]){rotate([-2,0,0]){cube([3,50,5],center=true);}}
          translate([-15,0,2]){rotate([-2,0,0]){cube([3,50,5],center=true);}}
        }
        translate([0,-39,3]){rotate([0,0,0]){cube([33,3,5],center=true);}}
        translate([0,39,3]){rotate([0,0,0]){cube([33,3,5],center=true);}}
      }
      // servo cutouts 
      Radial_Array (180,2,80)
      {
        translate ([0,0,-2]){rotate([0,180,0]){ servo_cut() ;}}
      }
        cylinder(h=30,r=10,center=true,$fn=6);
        Radial_Array (180,2,25)
        {
          cylinder(h=30,r=10,center=true,$fn=6);
        }
      // support holes
      Radial_Array(180,2,33)
      {
        translate ([-12,0,0]){cylinder(h=8,d=4,center=true,$fn=60);}
        translate ([12,0,0]){cylinder(h=8,d=4,center=true,$fn=60);}
      }
    }
  }
}

module legl()
{
  color("black",1)
  {
    translate([0,0,45])
    {
      rotate([0,180,0])
    {
    difference()
    {
      union()
      {
        // main outer shape
        Radial_Array (180,2,80){cylinder(h=3,d=50,center=true,$fn=6);}
        cube([40,150,3],center=true,$fn=6);
        translate([17,0,3]){{cube([3,80,5],center=true);}}
        translate([-17,0,3]){{cube([3,80,5],center=true);}}
        //support rails outer
        Radial_Array (180,2,65){
          translate([15,0,2]){rotate([-2,0,0]){cube([3,50,5],center=true);}}
          translate([-15,0,2]){rotate([-2,0,0]){cube([3,50,5],center=true);}}
        }
        translate([0,-39,3]){rotate([0,0,0]){cube([33,3,5],center=true);}}
        translate([0,39,3]){rotate([0,0,0]){cube([33,3,5],center=true);}}
      }
      // servo cutouts 
      Radial_Array (180,2,80)
      {
        translate ([0,0,-2]){rotate([0,180,90]){pot();}}
      }
        cylinder(h=30,r=10,center=true,$fn=6);
        Radial_Array (180,2,25)
        {
          cylinder(h=30,r=10,center=true,$fn=6);
        }
      // support holes
      Radial_Array(180,2,33)
      {
        translate ([-12,0,0]){cylinder(h=8,d=4,center=true,$fn=60);}
        translate ([12,0,0]){cylinder(h=8,d=4,center=true,$fn=60);}
      }
    }
  }
}}}

module lower_leg()
{translate([50,0,-20]){rotate([0,-0,0])
  {
  color("black",1)
  {
    difference()
    {
      union()
      {
      translate([0,32.5,-10]){cube([40,4,60],center=true);} 
      translate([18,38,-10]){cube([4,10,60],center=true);}
      translate([-18,38,-10]){cube([4,10,60],center=true);} 
      translate([15,38,-139]){rotate([0,2,0])cube([5,10,200],center=true);}
      translate([-15,38,-139]){rotate([0,-2,0])cube([5,10,200],center=true);}
      translate([0,32.5,-139]){cube([40,4,200],center=true);} 
      }
      translate([0,54.5,-139]){rotate([-2,0,0])cube([40,27,232],center=true);}
      translate([0,54.5,0]){rotate([4,0,0])cube([50,27,232],center=true);}
      translate([20.5,50,-139]){rotate([0,2,0])cube([8,59.5,202],center=true);}
      translate([-20.5,50,-139]){rotate([0,-2,0])cube([8,60,202],center=true);}
      translate([-0,50,-170]){rotate([90,90,0])cylinder(h=60,r=9,center=true,$fn=6);}  
      translate([-0,50,-140]){rotate([90,90,0])cylinder(h=60,r=10,center=true,$fn=6);}
    translate([-0,50,-110]){rotate([90,90,0])cylinder(h=60,r=11,center=true,$fn=6);}  
    translate([-0,50,-80]){rotate([90,90,0])cylinder(h=60,r=12,center=true,$fn=6);}  
    translate([-0,50,-50]){rotate([90,90,0])cylinder(h=60,r=13,center=true,$fn=6);}  
    //foot mounts
    translate([-0,50,-210]){rotate([90,90,0])cylinder(h=60,d=4.2,center=true,$fn=60);}
    translate([-0,50,-230]){rotate([90,90,0])cylinder(h=60,d=4.2,center=true,$fn=60);} 
    //hip mounts
    translate([0,0,0]){
          translate([12.5,40,-12.5]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([-12.5,40,-12.5]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([12.5,40,12.5]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
      translate([-12.5,40,12.5]){rotate([90,0,0]){cylinder(h=50,d=3.5,center=true,$fn=60);}}
    }
    translate([-0,40,0]){rotate([90,0,0]){cylinder(h=50,d=20,center=true,$fn=60);}}
      }}
  }
}}
module foot()
{
  color("orangered",1)
  {
    difference()
    {
      union()
      {
        translate([0,0,20]){cube ([9,15,40],center=true);}
        cylinder (h=5,d=45,center=true,$fn=60);
      }
    translate([-0,-0,15]){rotate([0,90,0])cylinder(h=60,d=4.2,center=true,$fn=60);}
    translate([-0,-0,35]){rotate([0,90,0])cylinder(h=60,d=4.2,center=true,$fn=60);}
    rotate([0,0,0]){
    translate([-12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([-12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    
      
      Radial_Array (90,4,22)
        {
          cylinder(h=30,r=10,center=true,$fn=6);
        }}
    }  
  }
}

module footsw()
{
  translate ([0,0,-25])
 {
  color("orangered",1)
  {
    difference()
    {
      union()
      {
         cylinder (h=3,d=45,center=true,$fn=60);
      }
   
    translate([-12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([-12,-12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    translate([12,12,0]){cylinder(h=60,d=4,center=true,$fn=60);}
    
    Radial_Array (90,4,22)
        {
          cylinder(h=30,r=10,center=true,$fn=6);
        }
    }  
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
  
}}