include <Common/Util/Shapes.scad>



//example
intersection()
{
    translate([0,7,0])
    cylinder(d=20, h=8, center=true, $fn=64);
    difference()
    {
        translate([0,0,-1.5])
        cube([20,20,3], center=true);
        BB_623_cutout(fitting=0.2);
        translate([-5,5,0])
        cylinder(d=3.4, h=16, center=true, $fn=32);
        translate([5,5,0])
        cylinder(d=3.4, h=16, center=true, $fn=32);
    }
}
//BB_623();

/*
difference()
{
    translate([0,3.75,0])
    Box([15,7.5,20]);
    LM6UU_Cutout(fitting=0.2);
}
*/

//Linear_Ballbearing_Cutout(outer_diameter=12, length=20, groove_depth=0.5, groove_width=1.1, groove_dist=15, fitting=0.2);

module BB_623()
{
    color("grey")
    Ballbearing(3, 10, 4);
}

module BB_623_cutout(playroom=0.2, fitting=0.2, axel_cutout=false)
{
    Ballbearing_Cutout(3, 10, 4, 5, playroom, fitting, axel_cutout);
}

module BB_608()
{
    color("grey")
    Ballbearing(8, 22, 7);
}

module BB_608_cutout(playroom=0.5, fitting=0.2, axel_cutout=false)
{
    
    //TODO: check center diameter...
    Ballbearing_Cutout(8, 22, 7, 9, playroom, fitting, axel_cutout);
}

module LM5UU()
{
    color("grey")
    Linear_Ballbearing(  inner_diameter=5,
                        outer_diameter=10,
                        length=15,
                        groove_depth=0.4,
                        groove_width=1.1,
                        groove_dist=10.2        );
}

module LM5UU_Cutout(fitting)
{
    Linear_Ballbearing_Cutout(    outer_diameter=10,
                                length=15,
                                groove_depth=0.4,
                                groove_width=1.1,
                                groove_dist=10.2,
                                fitting=fitting);
}

module LM6UU()
{
    color("grey")
    Linear_Ballbearing(  inner_diameter=6,
                        outer_diameter=12,
                        length=19,
                        groove_depth=0.5,
                        groove_width=1.1,
                        groove_dist=13.5);
}

module LM6UU_Cutout(fitting)
{
    Linear_Ballbearing_Cutout(    outer_diameter=12,
                                length=19,
                                groove_depth=0.5,
                                groove_width=1.1,
                                groove_dist=13.5,
                                fitting=fitting     );
}

module LM8UU()
{
    color("grey")
    Linear_Ballbearing(  inner_diameter=8,
                        outer_diameter=15,
                        length=24,
                        groove_depth=0.7,
                        groove_width=1.1,
                        groove_dist=17.5);
}

module LM8UU_Cutout(fitting)
{
    Linear_Ballbearing_Cutout(    outer_diameter=15,
                                length=24,
                                groove_depth=0.7,
                                groove_width=1.1,
                                groove_dist=17.5,
                                fitting=fitting     );
}

module LM10UU()
{
    color("grey")
    Linear_Ballbearing(  inner_diameter=10,
                        outer_diameter=19,
                        length=29,
                        groove_depth=1,
                        groove_width=1.3,
                        groove_dist=22);
}

module LM10UU_Cutout(fitting)
{
    Linear_Ballbearing_Cutout(    outer_diameter=19,
                                length=29,
                                groove_depth=1,
                                groove_width=1.3,
                                groove_dist=22,
                                fitting=fitting     );
}

module LM12UU()
{
    color("grey")
    Linear_Ballbearing(  inner_diameter=12,
                        outer_diameter=21,
                        length=30,
                        groove_depth=1,
                        groove_width=1.3,
                        groove_dist=23);
}

module LM10UU_Cutout(fitting)
{
    Linear_Ballbearing_Cutout(    outer_diameter=21,
                                length=30,
                                groove_depth=1,
                                groove_width=1.3,
                                groove_dist=23,
                                fitting=fitting     );
}

module Linear_Ballbearing(inner_diameter, outer_diameter, length, groove_depth, groove_width, groove_dist)
{
    difference()
    {
        Cylinder(diameter=outer_diameter, height=length, angular_resolution=64);
        Cylinder(diameter=inner_diameter, height=length+2, angular_resolution=64);
        translate([0,0,-groove_dist/2+groove_width/2])
        Flat_Ring(   inner_diameter=outer_diameter-2*groove_depth,
                    outer_diameter=outer_diameter+1,
                    height=groove_width,
                    center=true,
                    $fn=64                                          );
        translate([0,0,groove_dist/2-groove_width/2])
        Flat_Ring(   inner_diameter=outer_diameter-2*groove_depth,
                    outer_diameter=outer_diameter+1,
                    height=groove_width,
                    center=true,
                    $fn=64                                          );
        
    }
        
}

module Linear_Ballbearing_Cutout(outer_diameter, length, groove_depth, groove_width, groove_dist, fitting)
{
    difference()
    {
        Cylinder(diameter=outer_diameter+fitting, height=length+2*fitting, angular_resolution=64);
        translate([0,0,-groove_dist/2+groove_width/2])
        Flat_Ring(  inner_diameter=outer_diameter-2*groove_depth+2*fitting,
                    outer_diameter=outer_diameter+2*fitting+1,
                    height=groove_width-2*fitting,
                    angular_resolution=64                                           );
        translate([0,0,groove_dist/2-groove_width/2])
        Flat_Ring(  inner_diameter=outer_diameter-2*groove_depth+2*fitting,
                    outer_diameter=outer_diameter+2*fitting+1,
                    height=groove_width-2*fitting,
                    angular_resolution=64                                           );
        
    }
}
    
module Ballbearing(inner_diameter, outer_diameter, width)
{
    difference()
    {
        Cylinder(diameter=outer_diameter, height=width, angular_resolution=64);
        Cylinder(diameter=inner_diameter, height=width+2, angular_resolution=64);
    }
}

module Ballbearing_Cutout(inner_diameter, outer_diameter, width, center_diameter, playroom=0.5, fitting=0.2, axel_cutout=false)
{
    difference()
    {
        Cylinder(diameter=outer_diameter+2*playroom+2*fitting, height=width+2*playroom+2*fitting, angular_resolution=64);
        
        rotate([180,0,0])
        translate([0,0,-2*playroom-0.5*width-fitting])
        Cone(   bottom_diameter=center_diameter+4*playroom,
                top_diameter=center_diameter,
                height=2*playroom,
                t_z="pos",
                angular_resolution=64);
        
        translate([0,0,-2*playroom-0.5*width-fitting])
        Cone(   bottom_diameter=center_diameter+4*playroom,
                top_diameter=center_diameter,
                height=2*playroom,
                t_z="pos",
                angular_resolution=64);
        
        
        if(!axel_cutout)
        {
            Cylinder(diameter=inner_diameter-2*fitting, height=outer_diameter, angular_resolution=64);
        }
        
    }
}
 
        