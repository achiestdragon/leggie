// csg shapes & libs
//
// slot (width, lenth, hight, rotation)
// ring (outer,inner,hight,segments)
// rbox (x,y,z,d)
// torus(r1,r2,a,s1,s2)
//
// Cubic_Array(sx,sy,sz,nx,ny,nz,center=true){child objects;}
// Radial_Array(a,n,r){child objects;}
//
//
//tests 
//slot (4,20,6,45);
//ring (40,10,1,60);
//rbox (100,100,100,10);
//torus(20,3,245,360,8);
//cylinder (h=10, r1=20,r2 = 10,center =true,$fn=4) ;
//
// slot (width, lenth, hight, rotation)
//

module slot (width,lenth,hight,rotation)
{ 
  rotate ([0,0,rotation])
  {
  union()
    {
      translate ([((lenth-width)/2),0,0]){cylinder(h=hight,d=width,center=true,$fn=60);}
      translate ([0-((lenth-width)/2),0,0]){cylinder(h=hight,d=width,center=true,$fn=60);}
      cube ([lenth-width,width,hight],center=true);
    }
  }
}

//
// ring (outer,inner,hight,segments)
//

module ring (outer,inner,hight,segments)
{
  difference()
  {
    cylinder(h=hight,d=outer,center=true,$fn=segments);
    cylinder(h=hight+.1,d=inner,center=true,$fn=segments);
  }
}

//
// rbox (x,y,z,d)
//
function fragments(r=1) = ($fn > 0) ? 
  ($fn >= 3 ? $fn : 3) : 
  ceil(max(min(360.0 / $fa, r*2*PI / $fs), 5));

function arc(r=1, angle=360, offsetAngle=0, c=[0,0], center=false, internal=false, d, fragments) = 
  let (
    r1 = d==undef ? r : d/2,
    fragments = fragments==undef ? ceil((abs(angle) / 360) * fragments(r1,$fn)) : fragments,
    step = angle / fragments,
    a = offsetAngle-(center ? angle/2 : 0),
    R = internal ? to_internal(r1) : r1,
    last = (abs(angle) == 360 ? 1 : 0)
  )
  [ for (i = [0:fragments-last] ) let(a2=i*step+a) c+R*[cos(a2), sin(a2)] ];

module rbox(x,y,z,d) {
  r = d/2;
  $fn=60;
  hull() 
  for(i=[0,1],j=[0,1],k=[0,1]) mirror([i,0,0]) mirror([0,j,0]) mirror([0,0,k])
    translate([0.5*x-r,0.5*y-r,0.5*z-r]) 
      rotate_extrude(angle=90) 
        polygon(concat(
          [[0,0]], 
          arc(r=r, angle=90)
        ));
}

 
module torus(r1,r2,a,s1,s2)
{
  rotate_extrude(angle=a,$fn=s1) translate([r1,0,0]) circle(r2,$fn=s2);
}

// Cubic_Array(sx,sy,sz,nx,ny,nz,center=true){child objects;}
// main lib modules
module Cubic_Array(sx,sy,sz,nx,ny,nz,center)
	{
	if (center==true)
		{
		translate([-(((nx+1)*sx)/2),-(((ny+1)*sy)/2),-(((nz+1)*sz)/2)])
			{
			for(x=[1:nx])
				{
				for(y=[1:ny])
					{
					for(z=[1:nz])
						{
						translate([x*sx,y*sy,z*sz])
						for (k = [0:$children-1]) children(k,center=true);;
						}
					}
				}
			}
		}
	else
		{
		translate([0,0,0])
			{
			for(x=[1:nx])
				{
				for(y=[1:ny])
					{
					for(z=[1:nz])
						{
						translate([x*sx,y*sy,z*sz])
						for (k = [0:$children-1]) children(k);
						}
					}
				}
			}
		}
	}

//
//Radial_Array(a,n,r){child object}
// produces a clockwise radial array of child objects rotated around the local z axis   
// a= interval angle 
// n= number of objects 
// r= radius distance 
//
module Radial_Array(a,n,r)
{
 for (k=[0:n-1])
 {
 rotate([0,0,-(a*k)])
 translate([0,r,0])
 for (k = [0:$children-1]) children(k);
 }
}