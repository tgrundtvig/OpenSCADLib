// Auther: Tobias Grundtvig
// Date: Oct 1, 2020
//
// A wrapper of the build-in cylinder module, to get consistent naming

Cylinder(diameter=10, height=5, t_x="neg", t_z="pos");

module Cylinder(diameter, height, t_x="center", t_y="center", t_z="center", angular_resolution=32)
{
    tx = t_x == "neg" ? -diameter/2 : 
            t_x == "pos" ? diameter/2 : 0;
    ty = t_y == "neg" ? -diameter/2 : 
            t_y == "pos" ? diameter/2 : 0;
    tz = t_z == "neg" ? -height/2 : 
            t_z == "pos" ? height/2 : 0;
    translate([tx,ty,tz])
        cylinder(d=diameter, h=height, center=true, $fn=angular_resolution);
}