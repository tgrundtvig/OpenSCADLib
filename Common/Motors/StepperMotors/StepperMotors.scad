Nema17();

module MotorBlock(w, h, c, ww, wh, wl)
{
	translate([0, 0, -h/2])
	difference()
	{
		union()
		{
			//Main block
			cube([w, w, h], center=true);
			//Wire out
			translate([	0.5*(w+wl)-0.1,
							0,
							-0.5*(h-wh)])
			cube([wl+0.2,ww,wh], center=true);
		}
		union()
		{
			//Corners
			translate([(w/2), (w/2), 0])
			  rotate([0, 0, 45])
			  cube([c, c, h+2], center=true);
			translate([-(w/2), (w/2), 0])
			  rotate([0, 0, 45])
			  cube([c, c, h+2], center=true);
			translate([-(w/2), -(w/2), 0])
			  rotate([0, 0, 45])
			  cube([c, c, h+2], center=true);
	      translate([(w/2), -(w/2), 0])
			  rotate([0,0,45])
			  cube([c, c, h+2], center=true);
		}
	}
}

module MotorTop(dd, dh, ad, ah)
{
	union()
	{
		translate([0, 0, dh/2-0.1]) cylinder(d=dd,h=dh+0.2, center=true, $fn=64);
		translate([0, 0, ah/2-0.1]) cylinder(d=ad,h=ah+0.2, center=true, $fn=64);	
	}
}

module MotorScrews(distance, diameter, height, shd, shh)
{
	union()
	{
		translate([distance/2,distance/2,-0.1])
            MotorScrew(diameter, height+0.1, shd, shh);
		translate([-distance/2,distance/2,-0.1])
            MotorScrew(diameter, height+0.1, shd, shh);
		translate([distance/2,-distance/2,-0.1])
            MotorScrew(diameter, height+0.1, shd, shh);
		translate([-distance/2,-distance/2,-0.1])
            MotorScrew(diameter, height+0.1, shd, shh);
	}
}

module MotorScrew(diameter, height, shd, shh)
{
	cylinder(d=diameter, h=height+shh, $fn=64);
	translate([0,0,height])
	cylinder(d=shd, h=shh, $fn=64);
}

module Motor(w, h, c, dd, dh, ad, ah, sdist, sdia, sl, ww, wh, wl, shd=7, shh=20)
{
	union()
	{
		color("DarkSlateGray") MotorBlock(w,h,c,ww,wh,wl);
		color("Silver") MotorTop(dd,dh,ad,ah);
		color("Gray") MotorScrews(sdist,sdia,sl,shd,shh);
	}
}



module Nema17(screw_length=5)
{
	Motor(43.4, 48, 43.4/8, 23, 3, 6, 25, 31, 3.4, screw_length, 5, 8, 10);
}

