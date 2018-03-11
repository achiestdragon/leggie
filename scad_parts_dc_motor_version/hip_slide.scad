module hip_slide();
  {
    rotate([0,180,0])
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