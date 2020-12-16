// Auther: Tobias Grundtvig
// Date: Oct 1, 2020
//
// A segment of a flat ring

use <Pie_2D.scad>
use <Flat_Ring.scad>

Flat_Ring_Segment(  inner_diameter=20,
                    outer_diameter=25,
                    height=5,
                    from_angle=45,
                    to_angle=135,
                    t_y="neg",
                    angular_resolution=32);

module Flat_Ring_Segment(   inner_diameter,
                            outer_diameter,
                            height,
                            from_angle,
                            to_angle,
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
    intersection()
    {
        linear_extrude(height=height, center=true)
        {
            Pie_2D
            (
                diameter=outer_diameter*2,
                from_angle=from_angle,
                to_angle=to_angle,
                steps = 8
            );
        }
        Flat_Ring(  inner_diameter=inner_diameter,
                    outer_diameter=outer_diameter,
                    height=height,
                    angular_resolution=angular_resolution);
    }
}
