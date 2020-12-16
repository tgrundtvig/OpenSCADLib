// Auther: Tobias Grundtvig
// Date: Oct 1, 2020
//
// A cone, wraps the build-in cylinder module, to get consistent naming

Cone(bottom_diameter=20, top_diameter=10, height=10, t_x="neg");

module Cone(bottom_diameter,
            top_diameter,
            height,
            t_x="center",
            t_y="center",
            t_z="center",
            angular_resolution=32)
{
    max_d = max(bottom_diameter, top_diameter);
    tx = t_x == "neg" ? -max_d/2 : 
            t_x == "pos" ? max_d/2 : 0;
    ty = t_y == "neg" ? -max_d/2 : 
            t_y == "pos" ? max_d/2 : 0;
    tz = t_z == "neg" ? -height/2 : 
            t_z == "pos" ? height/2 : 0;
    translate([tx,ty,tz])
    cylinder(d1=bottom_diameter, d2=top_diameter, h=height, center=true, $fn=angular_resolution);
}