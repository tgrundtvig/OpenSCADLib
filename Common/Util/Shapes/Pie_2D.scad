// Auther: Tobias Grundtvig
// Date: Oct 1, 2020
//
//  A 2-dimensional pie
//  can be used to linear-extract a 3D Pie


Pie_2D(diameter=10, from_angle=45, to_angle=315, steps=32);
translate([2,0,0])
Pie_2D(diameter=10, from_angle=315, to_angle=45, steps=32);

module Pie_2D(diameter, from_angle, to_angle, steps=32)
{
    step_size = from_angle < to_angle ?
                (to_angle-from_angle)/steps :
                (360 - (from_angle-to_angle))/steps;
    r=diameter/2;
    points = from_angle < to_angle ?
        [
            for(i = [0:steps])
            [r * cos(from_angle+i*step_size), r * sin(from_angle+i*step_size)]
        ] :
        [
            for(i = [0:steps])
            [r * cos(from_angle+i*step_size), r * sin(from_angle+i*step_size)]
        ];
            
    polygon(concat([[0, 0]], points));
}