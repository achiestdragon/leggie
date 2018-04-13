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
// mg996();           // MG996 metal gear servo
// mg996_cutout();    // servo cutout/mounting hole csg shape
// eurocard();        // a quick pre rendered  100x160mm euro square pad 
//                    // proto board , from euro100x160pcb.scad pcb();
//                    // as that takes about 15 mins to render

//*****************************************************************************
// Varibles :-



//*****************************************************************************
// Constants :-


//*****************************************************************************
// Code :-

module spacer();
{
color("blue",1)rotate([90,0,0])
{
difference()
  {
   cylinder(h=32,d=15,center=true,$fn=6);
   cylinder(h=40,d=7,center=true,$fn=60);
  }
}
}