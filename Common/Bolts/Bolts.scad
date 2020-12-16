// Author: Tobias Grundtvig

include <Common/Util/Shapes.scad>

//BoltCutout(diameter=3, length=20, head_diameter=5, head_height=3, head_in = true, center=false,fix_overhang=true, fitting=1, $fn=16);

//Bolt(diameter=3, length=20, head_diameter=5, head_height=3, head_in = false, center=true, $fn=16);

//M3_Bolt(length=18, $fn=16);
//translate([0,0,20])
//Hex_Nut_Cutout(thread_diameter=3, wrench_size=5.5, height=3, turned=true, center=false, fix_overhang=true, fitting=0.2);
difference()
{
    translate([0,0,-15])
    cube([10,5,30]);
    translate([5,0,0])
    Rod_And_Hex_Nuts_Cutout(rod_length=20,
                            nut_distance=10,
                            rod_diameter=3,
                            nut_wrench_size=5.5,
                            nut_height=3,
                            turned=true,
                            center=true,
                            distance_type="center",
                            fix_overhang=true,
                            overhang_factor=0.8,
                            fitting=0.2,
                            $fn=32             );
}

translate([5,0,0])
Rod_And_Hex_Nuts(   rod_length=20,
                    nut_distance=10,
                    rod_diameter=3,
                    nut_wrench_size=5.5,
                    nut_height=3,
                    turned=true,
                    center=true,
                    distance_type="center", 
                    $fn=32             );

//Hex_Nut(thread_diameter=3, wrench_size=5.5, height=3, turned= false, center=false);

///////////////////////////////////////////////////////////////////////////////////////
// Bolt
// A round headed bolt.
// 
///////////////////////////////////////////////////////////////////////////////////////

module M3_Bolt(length, head_in=false, center=false, $fn=$fn)
{
    color("grey")
    Bolt(head_diameter=5, head_height=3, bolt_diameter=3, bolt_length=length, head_in=head_in, center=center, $fn = $fn);
}



module M3_Bolt_Cutout(length, head_in=false, center=false, fix_overhang=false, fitting=0, $fn=$fn)
{
    Bolt_Cutout(    head_diameter=5,
                    head_height=3,
                    bolt_diameter=3,
                    bolt_length=length,
                    head_in=head_in,
                    center=center,
                    fix_overhang=false,
                    fitting, $fn = $fn);
}

module Bolt(head_diameter, wrench_size, head_height, bolt_diameter, bolt_length,  head_in = false, center=false, $fn=$fn)
{
    t = center ? 
        (head_in ?
            (head_height + bolt_length)/2 :  //center, head in
            head_height + bolt_length/2      //center, head out
        ) :                    
        (head_in ?                     
            0 :                         //no center, head in
            head_height                 //no center, head out
        );
    translate([0,0,-t])
    union()
    {
        difference()
        {
            cylinder(d=head_diameter, h=head_height, $fn=$fn);
            translate([0,0,-1])
            cylinder(d=head_diameter, h=head_height/2+1, $fn=6);
        } 
        translate([0,0,head_height])
        cylinder(d=bolt_diameter, h=bolt_length, $fn=$fn);
    }
}

module Bolt_Cutout(head_diameter, head_height, bolt_diameter, bolt_length,  head_in = false, center=false, fix_overhang=false, fitting=0, $fn=$fn)
{
    t = center ? 
        (head_in ?
            fitting+(head_height+bolt_length)/2 :    //center, head in
            fitting + head_height + bolt_length/2    //center, head out
        ) :                    
        (head_in ?                     
            fitting :                           //no center, head in
            2*fitting+head_height               //no center, head out
        );
    translate([0,0,-t])
    union()
    {
        cylinder(d=head_diameter+2*fitting, h=head_height+2*fitting, $fn=$fn); 
        translate([0,0,head_height+2*fitting])
            cylinder(d=bolt_diameter+2*fitting, h=bolt_length, $fn=$fn);
        if(fix_overhang)
        {
            hull()
            {
                cylinder(d=head_diameter+2*fitting, h=head_height+2*fitting, $fn=$fn);
                translate([0,0,head_height+2*fitting])
                    cylinder(d=bolt_diameter+2*fitting, h=(head_diameter-bolt_diameter), $fn=$fn);
            }
        }
    }
}

module M3_Hex_Nut(turned=false, center=false)
{
    color("grey")
    Hex_Nut(thread_diameter=3, wrench_size=5.5, height=3, turned=turned, center=center);
}

module Hex_Nut(thread_diameter, wrench_size, height, turned= false, center=false)
{
    rot = turned ? 30 : 0;
    t = center ? 0 : height/2;
    translate([0,0,t])
    rotate([0,0,rot])
    difference()
    {
        cylinder(d=2*wrench_size/sqrt(3), h=height, center=true, $fn=6);
        cylinder(d=thread_diameter, h=height+1, center=true, $fn=32);
    }
}

module Hex_Nut_Cutout(thread_diameter, wrench_size, height, turned=false, center=false, fix_overhang=false, overhang_factor=1, fitting=0)
{
    wrench_size = wrench_size + 2*fitting;
    rot = turned ? 30 : 0;
    t = center ? 0 : 0.5*height;
    translate([0,0,t])
    rotate([0,0,rot]) 
    if(fix_overhang)
    {
        hull()
        {
            ch = height + 2*fitting + 
                 (wrench_size-thread_diameter)*overhang_factor;
            
            cylinder(   d=thread_diameter+2*fitting,
                        h=ch, center=true, $fn=32);
            
            cylinder(   d=2*wrench_size/sqrt(3),
                        h=height+2*fitting,
                        center=true,
                        $fn=6);
        }
    }
    else
    {
        cylinder(d=2*wrench_size/sqrt(3), h=height+2*fitting, center=center, $fn=6);
    }    
}

module Square_Nut(thread_diameter, wrench_size, height, center=false)
{
    difference()
    {
        cube([wrench_size, wrench_size, height], center=center);
        cylinder(d=thread_diameter, h=height+1, center=center, $fn=32);
    }
}

module Square_Nut_Cutout(thread_diameter, wrench_size, height, center=false, fitting=0)
{
    t = center ? 0 : fitting;
    translate([0,0,-t])
    difference()
    {
        cube([wrench_size+2*fitting, wrench_size+2*fitting, height+2*fitting], center=true);
        cylinder(d=thread_diameter, h=height+1, center=true, $fn=32);
    }
}

module Washer(inner_diameter, outer_diameter, height, center=false, $fn=$fn)
{
    Flat_Ring(inner_diameter=inner_diameter, outer_diameter=outer_diameter, height=height, center=center, $fn=$fn);
}

module Washer_Cutout(inner_diameter, outer_diameter, height, center=false, fitting=0, $fn=$fn)
{
    t = center ? 0 : fitting;
    translate([0,0,-t])
    Flat_Ring(inner_diameter=inner_diameter, outer_diameter=outer_diameter, height=height+2*fitting, center=true, $fn=$fn);
}

///////////////////////////////////////////////////////////////////////////////////////
// Rod_And_Hex_Nuts
// A threaded rod with two hex nuts on it.
// 
///////////////////////////////////////////////////////////////////////////////////////


module Rod_And_Hex_Nuts(rod_length,
                        nut_distance,
                        rod_diameter,
                        nut_wrench_size,
                        nut_height,
                        turned=false,
                        center=false,
                        distance_type="center", 
                        $fn=$fn             )
{
    color("grey")
    Rod_And_Hex_Nuts_Cutout( rod_length=rod_length,
                                nut_distance=nut_distance,
                                rod_diameter=rod_diameter,
                                nut_wrench_size=nut_wrench_size,
                                nut_height=nut_height,
                                turned=turned,
                                center=center,
                                distance_type=distance_type, 
                                $fn=$fn                             );
}

module Rod_And_Hex_Nuts_Cutout( rod_length,
                                nut_distance,
                                rod_diameter,
                                nut_wrench_size,
                                nut_height,
                                turned=false,
                                center=false,
                                distance_type="center", 
                                fix_overhang=false,
                                overhang_factor=1,
                                fitting=0,
                                $fn=$fn             )
{
    delta = distance_type == "inner" ? nut_height*0.5 :
            distance_type == "outer" ? -nut_height*0.5 : 0; 
    t = center ? 0 : nut_distance/2;
    translate([0,0,t])
    p_add_rod(rod_length=rod_length+2*fitting, rod_diameter=rod_diameter+2*fitting, dist=nut_distance, $fn=$fn)
    translate([0,0,delta])
    Hex_Nut_Cutout( thread_diameter=rod_diameter,
                    wrench_size= nut_wrench_size,
                    height=nut_height,
                    turned=turned,
                    center=true,
                    fix_overhang=fix_overhang,
                    overhang_factor=overhang_factor,
                    fitting=fitting);
}

///////////////////////////////////////////////////////////////////////////////////////
//*************************************************************************************
// Private modules and functions
//*************************************************************************************
///////////////////////////////////////////////////////////////////////////////////////

module p_add_rod(rod_length, rod_diameter, dist, $fn=$fn)
{
    union()
    {
        cylinder(d=rod_diameter, h = rod_length, center=true, $fn=$fn);  
        translate([0,0,dist/2])
        children();
        rotate([180,0,0])
        translate([0,0,dist/2])
        children();
    }
}
