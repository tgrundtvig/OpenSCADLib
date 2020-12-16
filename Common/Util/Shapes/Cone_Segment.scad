// Auther: Tobias Grundtvig
// Date: Oct 1, 2020
//
// A segment of a cone

use <Pie_2D.scad>
use <Cone.scad>

Cone_Segment(bottom_diameter=20, top_diameter=25, height=5, from_angle=45, to_angle=135);

module Cone_Segment(bottom_diameter,
                    top_diameter,
                    height,
                    from_angle,
                    to_angle,
                    t_x="center",
                    t_y="center",
                    t_z="center",
                    angular_resolution=32)
{
    max_d=max(bottom_diameter, top_diameter);
    tx = t_x == "neg" ? -max_d/2 : 
            t_x == "pos" ? max_d/2 : 0;
    ty = t_y == "neg" ? -max_d/2 : 
            t_y == "pos" ? max_d/2 : 0;
    tz = t_z == "neg" ? -height/2 : 
            t_z == "pos" ? height/2 : 0;
    translate([tx, ty, tz])
    intersection()
    {
        linear_extrude(height=height, center=true)
        {
            Pie_2D
            (
                diameter=max(bottom_diameter, top_diameter)*2,
                from_angle=from_angle,
                to_angle=to_angle,
                steps = 8
            );
        }
        Cone(   bottom_diameter=bottom_diameter,
                top_diameter=top_diameter,
                height=height,
                angular_resolution=angular_resolution);
    }
}
