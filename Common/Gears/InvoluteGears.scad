include <Common/Util/Shapes.scad>
use <GearUtil.scad>


//Sharp_Tooth(h1=5, h2=5, segment_angle=360/32, base_radius=20, max_rolloff_angle=35, fitting_angle=0);
/*
difference()
{
    union()
    {
        Insertion_Gear( width = 14,
                        width_transition = 4,
                        number_of_teeth = 24,
                        gear_dist = 30,
                        total_teeth = 32,
                        pressure_angle=10,
                        t_x="center",
                        t_y="center",
                        t_z="pos",
                        fitting=0.2);
    }
    translate([0,0,-1])
    Cylinder(diameter=4.4, height=17, t_z="pos", angular_resolution=32);
    translate([0,0,11])
    Cylinder(diameter=8.2, height=4, t_z="pos", angular_resolution=32);
    translate([0,0,-1])
    union()
    {
        Cylinder(diameter=8.2, height=4, t_z="pos", angular_resolution=32);
        translate([0,0,4])
        Cone(bottom_diameter=8.2, top_diameter=4.4, height=5, t_z="pos");
    }
    translate([0,0,-1])
    ring_of_cylinders(inner_diameter=12, outer_diameter=36, height=17, angular_resolution=32);
}
*/

difference()
{
    union()
    {
        Involute_Gear(  width = 5,
                        number_of_teeth = 32,
                        gear_dist = 30,
                        total_teeth = 32,
                        helix_angle=0,
                        t_z="pos",
                        fitting=0.2);
        translate([0,0,5])
        Insertion_Gear( width = 15,
                        width_transition = 4,
                        number_of_teeth = 8,
                        gear_dist = 30,
                        total_teeth = 32,
                        pressure_angle=10,
                        t_x="center",
                        t_y="center",
                        t_z="pos",
                        fitting=0.2);
    }
    translate([0,0,-1])
    Cylinder(diameter=4.4, height=22, t_z="pos", angular_resolution=32);
    translate([0,0,17])
    Cylinder(diameter=8.2, height=4, t_z="pos", angular_resolution=32);
    translate([0,0,-1])
    union()
    {
        Cylinder(diameter=8.2, height=4, t_z="pos", angular_resolution=32);
        translate([0,0,4])
        Cone(bottom_diameter=8.2, top_diameter=4.4, height=5, t_z="pos");
    }
    translate([0,0,-1])
    ring_of_cylinders(inner_diameter=20, outer_diameter=50, height=7, angular_resolution=32);
}             

/*

translate([0,0,0])
difference()
{
    Involute_Gear(  width = 5,
                    number_of_teeth = 8,
                    gear_dist = 10,
                    total_teeth = 8,
                    helix_angle=0,
                    t_z="pos",
                    fitting=0.2);
    Cylinder(diameter=3.4, height=5, t_z="pos");
}
translate([25,0,0])
rotate([0,0,360/16])
difference()
{
    Involute_Gear(  width = 5,
                    number_of_teeth = 8,
                    gear_dist = 10,
                    total_teeth = 8,
                    helix_angle=0,
                    t_z="pos",
                    fitting=0.2);
    Cylinder(diameter=8.4, height=5, t_z="pos");
}
*/

//ring_of_cylinders(inner_diameter=10, outer_diameter=50, height=10, angular_resolution=32);

//Involute_Gear_2D();
/*
cylinder(r1=10, r2=5, h=5, $fn=64);
for(i = [0:17])
{
    rotate([0,0,i*(360/18)])
    translate([10,0,0])
    rotate([0,-45,0])
    hull()
    {
        translate([-10,0,0])
        linear_extrude(0.1)
        Involute_Tooth_Segment_2D(segment_angle=10, base_radius=10, max_rolloff_angle=33.3548);
        translate([0,0,sqrt(50)])
        translate([-5,0,0])
        linear_extrude(0.1)
        Involute_Tooth_Segment_2D(segment_angle=10, base_radius=5, max_rolloff_angle=33.3548);
    }
}
*/
module Involute_Gear(   width,
                        number_of_teeth,
                        gear_dist,
                        total_teeth,
                        pressure_angle=10,
                        helix_angle=0,
                        t_x="center",
                        t_y="center",
                        t_z="center",
                        fitting=0)
{
    modul = 2*gear_dist / total_teeth;
    diameter = modul * number_of_teeth;
	radius = diameter * 0.5;
    rad = 180/PI;
    gamma = rad*width/(radius*tan(90-helix_angle));
    tx = t_x == "neg" ? -radius : 
            t_x == "pos" ? radius : 0;
    ty = t_y == "neg" ? -radius : 
            t_y == "pos" ? radius : 0;
    tz = t_z == "neg" ? -width : 
            t_z == "pos" ? 0 : -width*0.5;
    translate([tx,ty,tz])
    linear_extrude(height = width, twist = gamma)
    {
        Involute_Gear_2D(   number_of_teeth=number_of_teeth,
                            gear_dist=gear_dist,
                            total_teeth=total_teeth,
                            pressure_angle=pressure_angle,
                            helix_angle=helix_angle,
                            fitting=fitting);
    }
}


module Involute_Gear_2D(number_of_teeth, gear_dist, total_teeth, pressure_angle=10, helix_angle=0, fitting=0)
{
    modul = 2*gear_dist / total_teeth;
    diameter = modul * number_of_teeth;
	radius = diameter / 2;
    alpha_stirn = atan(tan(pressure_angle)/cos(helix_angle)); 
    //alpha_stirn = pressure_angle; 
    base_diameter = diameter * cos(alpha_stirn); 
    base_radius = base_diameter / 2;
    //Tip diameter according to DIN 58400 or DIN 867
    tip_diameter = ((modul < 1) ? diameter + modul * 2.2 : diameter + modul * 2) - fitting;
    tip_radius = tip_diameter / 2;
    tip_room = (number_of_teeth < 3) ? 0 : modul/6;
    root_diameter = diameter - 2 * (modul + tip_room);
    root_radius = root_diameter / 2;
    max_rolloff_angle = acos(base_radius/tip_radius);
    segment_angle = 180 / number_of_teeth;
    step_angle = 360 / number_of_teeth;
    fitting_angle = (fitting / (diameter * PI)) * 360;
    union()
    {
        circle(r=root_radius-fitting, $fn=number_of_teeth*8);
        for(i = [0:number_of_teeth-1])
        {
            rotate(i*step_angle)
            Involute_Tooth_Segment_2D(segment_angle, base_radius, max_rolloff_angle, fitting_angle);
        }
    }
}

module Insertion_Gear(  width,
                        width_transition,
                        number_of_teeth,
                        gear_dist,
                        total_teeth,
                        pressure_angle=10,
                        t_x="center",
                        t_y="center",
                        t_z="center",
                        fitting=0)
{
    modul = 2*gear_dist / total_teeth;
    diameter = modul * number_of_teeth;
	radius = diameter * 0.5;
    rad = 180/PI;
    alpha_stirn = pressure_angle; 
    //alpha_stirn = pressure_angle; 
    base_diameter = diameter * cos(alpha_stirn); 
    base_radius = base_diameter / 2;
    //Tip diameter according to DIN 58400 or DIN 867
    tip_diameter = ((modul < 1) ? diameter + modul * 2.2 : diameter + modul * 2) - fitting;
    tip_radius = tip_diameter / 2;
    tip_room = (number_of_teeth < 3) ? 0 : modul/6;
    root_diameter = diameter - 2 * (modul + tip_room);
    root_radius = root_diameter / 2;
    max_rolloff_angle = acos(base_radius/tip_radius);
    segment_angle = 180 / number_of_teeth;
    step_angle = 360 / number_of_teeth;
    fitting_angle = (fitting / (diameter * PI)) * 360;
    
    tx = t_x == "neg" ? -radius : 
            t_x == "pos" ? radius : 0;
    ty = t_y == "neg" ? -radius : 
            t_y == "pos" ? radius : 0;
    tz = t_z == "neg" ? -width : 
            t_z == "pos" ? 0 : -width*0.5;
    translate([tx,ty,tz])
    union()
    {
        Cylinder(diameter=root_diameter, height=width, t_z="pos", angular_resolution=256);
        for(i = [0:number_of_teeth-1])
        {
            rotate([0,0,i*(360/number_of_teeth)])
            Insertion_Tooth(h1=width-width_transition,
                            h2=width_transition,
                            segment_angle=segment_angle,
                            base_radius=base_radius,
                            max_rolloff_angle=max_rolloff_angle,
                            fitting_angle=fitting_angle);
        }
    }
    
}
    
module Insertion_Tooth(h1, h2, segment_angle, base_radius, max_rolloff_angle, fitting_angle=0)
{
    hull()
    {
        linear_extrude(height=h1)
        {
            Involute_Tooth_Segment_2D(segment_angle, base_radius, max_rolloff_angle, fitting_angle);
        }
        Box([base_radius, 0.4, h1+h2], t_x="pos", t_z="pos");
    }
}

module Involute_Tooth_Segment_2D(segment_angle, base_radius, max_rolloff_angle, fitting_angle=0)
{
    steps = 32;
    step_size = max_rolloff_angle/steps;
    rotate(-segment_angle/2)
    polygon
    (
        concat
        (							        
            // Start and end segment at origin
            [[0,0]],
            // first flank
            [for (i = [0:steps])		     
                polar_to_cartesian
                (
                    [
                        circle_involute(base_radius,i*step_size)[0],
                        circle_involute(base_radius,i*step_size)[1] + fitting_angle // First involute flank
                    ]
                )
            ],		
            // second flank
            [for (i = [steps:-1:0])
                polar_to_cartesian
                (
                    [
                        circle_involute(base_radius,i*step_size)[0],
                        segment_angle - circle_involute(base_radius,i*step_size)[1] - fitting_angle
                    ]
                 )
            ]                 
        )
    );
}

function radians_to_degrees(radian) = radian*180/PI;

function degrees_to_radians(angle) = angle*PI/180;

function dist_teeth_to_modul(gear_dist, total_teeth) = 2*gear_dist/total_teeth;

function polar_to_cartesian(polar_vector) = [
	polar_vector[0]*cos(polar_vector[1]),  
	polar_vector[0]*sin(polar_vector[1])
];


//    Circle involute function:
//    Returns the polar coordinates of an involute of a circle
//    r = radius of the base circle
//    rho = roll-off angle in degrees
function circle_involute(r,rho) = [
	r/cos(rho),
	radians_to_degrees(tan(rho)-degrees_to_radians(rho))
];