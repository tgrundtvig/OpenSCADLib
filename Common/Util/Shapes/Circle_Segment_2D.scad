// Auther: Tobias Grundtvig
// Date: Oct 1, 2020
//
// A segment of a circle. The segment is cut out of the circle,
// to get the exactsame borderline as the full circle

use <Pie_2D.scad>

Circle_Segment_2D(diameter=10, from_angle=45, to_angle=315);
translate([1,0,0])
Circle_Segment_2D(diameter=10, from_angle=315, to_angle=45);


module Circle_Segment_2D(diameter, from_angle, to_angle, angular_resolution=32)
{
    intersection()
    {
        circle(d=diameter, $fn=angular_resolution);  
        Pie_2D
        (
            diameter=diameter*2,
            from_angle=from_angle,
            to_angle=to_angle,
            steps = 8
        );       
    }
}