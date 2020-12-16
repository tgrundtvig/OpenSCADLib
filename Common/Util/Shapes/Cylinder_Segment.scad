// Auther: Tobias Grundtvig
// Date: Oct 1, 2020
//
// A segment of a cylinder

use <Pie_2D.scad>
use <Cylinder.scad>

Cylinder_Segment(diameter=20, height=5, from_angle=45, to_angle=135, t_y="neg", t_z="neg");

module Cylinder_Segment(diameter,
                        height,
                        from_angle,
                        to_angle,
                        t_x="center",
                        t_y="center",
                        t_z="center",
                        angular_resolution=32)
{
    tx = t_x == "neg" ? -diameter/2 : 
            t_x == "pos" ? diameter/2 : 0;
    ty = t_y == "neg" ? -diameter/2 : 
            t_y == "pos" ? diameter/2 : 0;
    tz = t_z == "neg" ? -height/2 : 
            t_z == "pos" ? height/2 : 0;
    translate([tx, ty, tz])
    intersection()
    {
        linear_extrude(height=height, center=true)
        {
            Pie_2D
            (
                diameter=diameter*2,
                from_angle=from_angle,
                to_angle=to_angle,
                steps = 8
            );
        }
        Cylinder(   diameter=diameter,
                    height=height,
                    angular_resolution=angular_resolution);
    }
}
