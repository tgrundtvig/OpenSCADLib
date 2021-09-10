include <Common/Util/Shapes.scad>

MR83_M3_axis_cutout(gear_height=15, bottom_in=1, fix_overhang=true);

module axis_with_M3_fastener_cutout(   axis_dia,
                                       gear_height,
                                       gear_dia,
                                       angular_resolution=32 )
{
    axis_with_fastener_cutout(  axis_dia=axis_dia,
                                gear_height=gear_height,
                                gear_dia=gear_dia,
                                fastener_dia=3.4,
                                sq_nut_width=5.9,
                                sq_nut_height=2.4,
                                angular_resolution=angular_resolution);
}

module MR83_M3_axis_cutout( gear_height, bottom_in=0, top_in=0, fix_overhang=false, angular_resolution=64)
{
    ballbearing_axis_cutout(bottom_bb_dia=8.2,
                            bottom_bb_height=3+bottom_in,
                            top_bb_dia=8.2,
                            top_bb_height=3+top_in,
                            axis_dia=4,
                            gear_height=gear_height,
                            fix_overhang=fix_overhang,
                            angular_resolution=angular_resolution);
}

module ballbearing_axis_cutout( bottom_bb_dia,
                                bottom_bb_height,
                                top_bb_dia,
                                top_bb_height,
                                axis_dia,
                                gear_height,
                                fix_overhang=false,
                                angular_resolution=64)
{
    union()
    {
        Cylinder(diameter=axis_dia, height=gear_height, t_z="pos", angular_resolution=angular_resolution);
        translate([0,0,-1])
        Cylinder(diameter=bottom_bb_dia, height=bottom_bb_height+1, t_z="pos", angular_resolution=angular_resolution);
        translate([0,0,gear_height+1])
        Cylinder(diameter=top_bb_dia, height=top_bb_height+1, t_z="neg", angular_resolution=angular_resolution);
        
        if(fix_overhang)
        {
            h = bottom_bb_dia-axis_dia;
            translate([0,0,bottom_bb_height])
            Cone(   bottom_diameter=bottom_bb_dia,
                    top_diameter=axis_dia,
                    height=h,
                    t_z="pos",
                    angular_resolution=angular_resolution);
            translate([0,0,gear_height-top_bb_height])
            Cone(   bottom_diameter=axis_dia,
                    top_diameter=top_bb_dia,
                    height=h,
                    t_z="neg",
                    angular_resolution=angular_resolution);
        }
    }
}

module axis_with_fastener_cutout(   axis_dia,
                                    gear_height,
                                    gear_dia,
                                    fastener_dia,
                                    sq_nut_width,
                                    sq_nut_height,
                                    angular_resolution)
{
    union()
    {
        translate([0,0,-1])
        Cylinder(diameter=axis_dia, height=gear_height+2, t_z="pos", angular_resolution=angular_resolution);
        translate([0,0,gear_height*0.5])
        rotate([0,90,0])
        Cylinder(diameter=fastener_dia, height=gear_dia*0.5+1, t_z="pos", angular_resolution=angular_resolution);
        translate([axis_dia*0.5+0.8, 0, gear_height*0.5-sq_nut_width*0.5])
        Box([sq_nut_height, sq_nut_width, gear_height*0.5+sq_nut_width*0.5 + 1], t_x="pos", t_z="pos"); 
    }
}
    

module ring_of_cylinders(inner_diameter, outer_diameter, height, angular_resolution=32)
{
    diameter = (outer_diameter - inner_diameter)*0.5;
    min_dist = diameter*0.2;
    
    count = floor(PI*(inner_diameter+outer_diameter)*0.5 / (diameter+min_dist));
    if(count > 1)
    {
        for(i = [0:count-1])
        {
            rotate([0,0,i*(360/count)])
            translate([(inner_diameter+outer_diameter)*0.25,0,0])
            Cylinder(diameter=diameter, height=height, t_z="pos", angular_resolution=angular_resolution);
        }
    }
}
