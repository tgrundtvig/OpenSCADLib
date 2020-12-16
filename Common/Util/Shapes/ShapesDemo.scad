// Auther: Tobias Grundtvig
// Date: Oct 1, 2020
//
// A file to demonstrate the use of shapes

include <Common/Util/Shapes.scad>


translate([-40,-20,0])
Box([5,10,7]);
translate([-20,-20,0])
Cylinder(diameter=10, height=5);
translate([0,-20,0])
Cone(bottom_diameter=10, top_diameter=5, height=5);
translate([20,-20,0])
Flat_Ring(inner_diameter=5, outer_diameter=10, height=5);

translate([-20,-40,0])
Cylinder_Segment(diameter=10, height=5, from_angle=45, to_angle=315);
translate([-15,-40,0])
Cylinder_Segment(diameter=10, height=5, from_angle=315, to_angle=45);

translate([0,-40,0])
Cone_Segment(bottom_diameter=10, top_diameter=5, height=5, from_angle=45, to_angle=315);
translate([5,-40,0])
Cone_Segment(bottom_diameter=10, top_diameter=5, height=5, from_angle=315, to_angle=45);

translate([20,-40,0])
Flat_Ring_Segment(inner_diameter=5, outer_diameter=10, height=5, from_angle=45, to_angle=315);
translate([25,-40,0])
Flat_Ring_Segment(inner_diameter=5, outer_diameter=10, height=5, from_angle=315, to_angle=45);




translate([-40,20])
{
    Pie_2D(diameter=10, from_angle=45, to_angle=315, steps=32);
    translate([2,0,0])
    Pie_2D(diameter=10, from_angle=315, to_angle=45, steps=32);
}

translate([-20,20])
{
    Circle_Segment_2D(diameter=10, from_angle=45, to_angle=315);
    translate([2,0,0])
    Circle_Segment_2D(diameter=10, from_angle=315, to_angle=45);
}