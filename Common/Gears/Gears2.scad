segment_angle = 10;
radius_base = 10;
max_rolloff_angle = 33.3548;


//Involute_Gear_2D(16);
Involute_Tooth_Segment_2D(segment_angle, radius_base, max_rolloff_angle);

module Involute_Gear_2D(number_of_teeth, modul=(10/8), pressure_angle=20, helix_angle=0, fitting=0)
{
    diameter = modul * number_of_teeth;
	radius = diameter / 2;
    alpha_stirn = atan(tan(pressure_angle)/cos(helix_angle)); 
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