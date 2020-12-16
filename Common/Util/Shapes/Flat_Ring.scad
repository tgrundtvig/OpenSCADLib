// Auther: Tobias Grundtvig
// Date: Oct 1, 2020
//
// A flat ring

use  <Cylinder.scad>

Flat_Ring(inner_diameter=20, outer_diameter=25, height=5,t_x="neg", angular_resolution=32);

module Flat_Ring(   inner_diameter,
                    outer_diameter,
                    height,
                    t_x="center",
                    t_y="center",
                    t_z="center",
                    angular_resolution=32)
{
    tx = t_x == "neg" ? -outer_diameter/2 : 
            t_x == "pos" ? outer_diameter/2 : 0;
    ty = t_y == "neg" ? -outer_diameter/2 : 
            t_y == "pos" ? outer_diameter/2 : 0;
    tz = t_z == "neg" ? -height/2 : 
            t_z == "pos" ? height/2 : 0;
    translate([tx, ty, tz])
    difference()
    {
        Cylinder(   diameter=outer_diameter,
                    height=height,
                    angular_resolution=angular_resolution   );
        translate([0,0,-1])
        Cylinder(   diameter=inner_diameter,
                    height=height+3, 
                    angular_resolution=angular_resolution);
    }
}