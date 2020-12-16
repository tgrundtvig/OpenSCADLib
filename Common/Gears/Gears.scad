include <Common/Util/Shapes.scad>

gearDist = 15;
totalTeeth = 32;
width=7;
fitting = 0.2;

//GearSet(width, gearDist, 8, 8, 8.4, fitting);
/*
for(i = [8:4:32])
{
    translate([0,(i-16)*20,0])
        Gear(width, 30, 24, i, 8.4, 0.2, text=true);
}
*/
Gear(7, 30, 24, 16, 8, 0.2, text=true);
//Axel3Lock();
//translate([20,0,0])
//Axel3Spacer();
//Axel3(8,30,0.2);
/*
translate([0,-10,0])
Axel3Print(8.4, 20, 0.2);
Axel3Print(8.6, 25, 0.2);
translate([0,10,0])
Axel3Print(8.8, 30, 0.2);
*/
/*
difference()
{
    cylinder(d=15,h=7.5,center=true,$fn=64);
    Axel3Cutout(8.4,8,0.4);
}
/*
InsideGear(width, gearDist, totalTeeth, 32, fitting);
translate([10,0,0])
rotate([0,0,180/16])
Gear(width, gearDist, totalTeeth, 16, fitting);

GearSet(width, gearDist, 8, 8, fitting);
//PlateOfGears();
*/
/*
translate([0,10,0])
difference()
{
    cylinder(d=4.8, h=10, $fn=128, center=true);
    cylinder(d=3.2, h=12, $fn=128, center=true);
}

difference()
{
    cylinder(d=10, h=10, $fn=128, center=true);
    cylinder(d=5.2, h=12, $fn=128, center=true);
}
*/

/*
difference()
{
    Gear(width, gearDist, totalTeeth, 32, fitting, text=true);
    cylinder(d=3.4,h=width+2,center=true,$fn=16);
}
*/

/*
for(i = [0:4])
{
    translate([i*30,0,0])
    Axel2(5,28-2*i,0.4+i*0.05);
    translate([i*30,10,0])
    difference()
    {
        cylinder(d=(28-3*i)*0.5 ,h=4,$fn=16);
        Axel2Cutout(5,20,0.4+i*0.05);
    }
}
*/

/*
translate([0,0,0])
difference()
{
    cylinder(d=8,h=7.5,center=true,$fn=32);
    Axel3Cutout(6, 9.5, 0.4);
}
*/

/*

translate([-25,15,0])
Axel(3,20,-0.05);
translate([-25,0,0])
difference()
{
    cylinder(d=20,h=4,$fn=16);
    AxelCutout(3,20,-0.05);
}

translate([0,15,0])
Axel(3,22,0);
difference()
{
    cylinder(d=22,h=4,$fn=16);
    AxelCutout(3,20,0);
}


translate([25,15,0])
Axel(3,24,0.2);
translate([25,0,0.05])
difference()
{
    cylinder(d=24,h=4,$fn=16);
    AxelCutout(3,20,0.05);
}
*/

module PlateOfGears()
{
    translate([-85,95,0.5*width])
    LinearGear(width, 2, gearDist, totalTeeth, 20, fitting);

    rotate([0,0,180])
    translate([5,95,0.5*width])
    LinearGear(width, 2, gearDist, totalTeeth, 20, fitting);

    translate([-80,0,0])
    SomeGears();

    rotate([0,0,180])
    translate([-80,38,0])
    SomeGears();

    rotate([0,0,180])
    translate([-80,-38,0])
    SomeGears();

    translate([-80,76,0])
    SomeGears();

    translate([-80,-76,0])
    SomeGears();
}


module SomeGears()
{
    translate([0,0,0.5*width])
    difference()
    {
        Gear(width, gearDist, totalTeeth, 8, fitting);
        cylinder(d=3.4,h=width+2,center=true,$fn=16);
    }

    translate([20,0,0.5*width])
    difference()
    {
        Gear(width, gearDist, totalTeeth, 16, fitting);
        cylinder(d=3.4,h=width+2,center=true,$fn=16);
    }

    translate([50,0,0.5*width])
    difference()
    {
        Gear(width, gearDist, totalTeeth, 24, fitting);
        cylinder(d=3.4,h=width+2,center=true,$fn=16);
    }

    translate([90,0,0.5*width])
    difference()
    {
        Gear(width, gearDist, totalTeeth, 32, fitting);
        cylinder(d=3.4,h=width+2,center=true,$fn=16);
    }

    translate([140,0,0.5*width])
    difference()
    {
        Gear(width, gearDist, totalTeeth, 40, fitting);
        cylinder(d=3.4,h=width+2,center=true,$fn=16);
    }
}


//NewTooth2(width,height,minR,maxR);

module GearSet(width, gearDist, t1, t2, axelDiameter, fitting)
{
    totalTeeth = t1 + t2;
    Gear(width, gearDist, totalTeeth, t1, axelDiameter, fitting);
    translate([0,gearDist,0])
    if(t2%2==0)
    {
        rotate([0,0,180/t2])
        Gear(width, gearDist, totalTeeth, t2, axelDiameter, fitting);
    }
    else
    {
        Gear(width, gearDist, totalTeeth, t2, axelDiameter, fitting);
    }
}


module Gear(width, gearDist, totalTeeth, numTeeth, axelDiameter, fitting, text=false)
{
    teethR = 0.5*gearDist*PI/totalTeeth;
    gearR = numTeeth*gearDist/totalTeeth;
    difference()
    {
        union()
        {
            for(i=[0:numTeeth-1])
            {
                rotate([0,0,i*(360/numTeeth)])
                translate([0,gearR,0])
                cylinder(r=teethR-fitting, h=width, center=true, $fn=32);
            }
            cylinder(r=gearR, h=width, $fn=64, center=true);
        }
        for(i=[0:numTeeth-1])
        {
            rotate([0,0,(i+0.5)*(360/numTeeth)])
            translate([0,gearR,0])
            cylinder(r=teethR+fitting, h=width+2, center=true, $fn=32);
        }
        if(text)
        {
            numberCutout(width, gearDist, totalTeeth, numTeeth);
        }
        Axel3Cutout(axelDiameter,width+2,fitting);
        
    }
    
        
}

module numberCutout(width, gearDist, totalTeeth, numTeeth)
{
    gearR = numTeeth*gearDist/totalTeeth;
    for(a=[0:0])
    {
        rotate([0,180*a,0])
        for(b=[0:1])
        {
            t = numTeeth > 8 ? 0.61*gearR : 0.75*gearR;
            rotate([0,0,180*b])
            translate([0,t,width*0.5-1])
            linear_extrude(2)
            text(text=str(numTeeth), size=gearR*0.3, halign="center", valign="center");
        }
    }
}
    

module LinearGear(width, height, gearDist, totalTeeth, numTeeth, fitting)
{
    teethR = 0.5*gearDist*PI/totalTeeth;
    gearLength = 4*numTeeth*teethR;
    difference()
    {
        translate([0,-height,-0.5*width])
        cube([gearLength,height+teethR, width]);
        LinearGearCutout(width+2, height, gearDist, totalTeeth, numTeeth, fitting);
    }
}

module LinearGearCutout(width, height, gearDist, totalTeeth, numTeeth, fitting)
{
    teethR = 0.5*gearDist*PI/totalTeeth;
    gearLength = 4*numTeeth*teethR;
    difference()
    {
        union()
        {
            for(i=[0:numTeeth])
            {
                translate([(i*4)*teethR,0,0])
                cylinder(r=teethR+fitting, h=width, center=true, $fn=16);
            }
            translate([0,0,-0.5*width])
            cube([gearLength,height, width]);
        }
        for(i=[0:numTeeth-1])
        {
            translate([(i*4+2)*teethR,0,0])
            cylinder(r=teethR-fitting, h=width+2, center=true, $fn=16);
        }
    }
}

module InsideGear(width, gearDist, totalTeeth, numTeeth, fitting, text=false)
{
    teethR = 0.5*gearDist*PI/totalTeeth;
    gearR = numTeeth*gearDist/totalTeeth;
    difference()
    {
        union()
        {
            for(i=[0:numTeeth-1])
            {
                rotate([0,0,i*(360/numTeeth)])
                translate([0,gearR,0])
                cylinder(r=teethR-fitting, h=width, center=true, $fn=16);
            }
            difference()
            {
                cylinder(r=gearR+4*teethR, h=width, $fn=64, center=true);
                cylinder(r=gearR, h=width+2, $fn=64, center=true);
            }
        }
        for(i=[0:numTeeth-1])
        {
            rotate([0,0,(i+0.5)*(360/numTeeth)])
            translate([0,gearR,0])
            cylinder(r=teethR+fitting, h=width+2, center=true, $fn=16);
        }
    }
    
        
}


module LinearGearAdjusted(width, height, adjustedLength, gearDist, totalTeeth, fitting)
{
    teethR = 0.5*gearDist*PI/totalTeeth;
    difference()
    {
        translate([0,-height,-0.5*width])
        cube([adjustedLength, height+teethR, width]);
        LinearGearCutoutAdjusted(width+2, height, adjustedLength, gearDist, totalTeeth, fitting);
    }
}

module LinearGearCutoutAdjusted(width, height, adjustedLength, gearDist, totalTeeth, fitting)
{
    teethR = 0.5*gearDist*PI/totalTeeth;
    numTeeth = round(adjustedLength/(4*teethR));
    teethDist = adjustedLength/numTeeth;
    
    
    difference()
    {
        union()
        {
            for(i=[0:numTeeth])
            {
                translate([i*teethDist,0,0])
                cylinder(r=teethR+fitting, h=width, center=true, $fn=16);
            }
            translate([0,0,-0.5*width])
            cube([adjustedLength,height, width]);
        }
        for(i=[0:numTeeth-1])
        {
            translate([(i+0.5)*teethDist,0,0])
            cylinder(r=teethR-fitting, h=width+2, center=true, $fn=16);
        }
    }
}


module Axel2(diameter, length, fitting)
{
    translate([0,0,(diameter-fitting)*0.85*0.5])
    rotate([0,90,0])
    Axel2Cutout(diameter, length, -fitting);
}

module Axel3Cutout(diameter, length, fitting)
{
    difference()
    {
        intersection()
        {
            cube([diameter*0.9+2*fitting,diameter*0.9+2*fitting,length], center=true);
            cylinder(d=diameter+2*fitting,h=length, $fn=128, center=true);
        }
        for(i=[0:3])
        {
            rotate([0,0,i*90])
            translate([0,(diameter+0.5*fitting)*0.50,0])
            cylinder(d=diameter*0.35-0.5*fitting, h=length+1, $fn=32, center=true);
        }
    }
    
    for(i=[0:3])
    {
        rotate([0,0,i*90])
        translate([0,(diameter+0.5*fitting)*0.50,0])
        cylinder(d=diameter*0.35-0.5*fitting-1, h=length, $fn=32, center=true);
    }
}

module Axel3Print(diameter, length, fitting)
{
    translate([0,0,(diameter*0.85-2*fitting)*0.5])
    rotate([0,90,0])
    Axel3(diameter, length, fitting);
}

module Axel3(diameter, length, fitting)
{
    difference()
    {
        intersection()
        {
            cube([diameter*0.85-2*fitting,diameter*0.85-2*fitting,length], center=true);
            cylinder(d=diameter-2*fitting,h=length, $fn=128, center=true);
        }
        for(i=[0:3])
        {
            rotate([0,0,i*90])
            translate([0,(diameter-0.5*fitting)*0.50,0])
            cylinder(d=diameter*0.35+0.5*fitting, h=length+1, $fn=32, center=true);
        }
    }
}

module Axel2Cutout(diameter, length, fitting)
{
    dia = diameter+fitting;
    difference()
    {
        intersection()
        {
            cube([dia*0.85,dia*0.85,length], center=true);
            cylinder(d=dia,h=length, $fn=128, center=true);
        }
        for(i=[0:3])
        {
            rotate([0,0,i*90])
            translate([0,-dia*0.45,0])
            cylinder(d=dia*0.35, h=length+1, $fn=32, center=true);
        }
    }
}

module Axel(diameter, length, fitting)
{
    translate([0,0,0.5*(diameter*0.92-2*fitting)])
    rotate([0,90,0])
    intersection()
    {
        cylinder(d=diameter-2*fitting, h=length, center=true, $fn=64);
        cube([diameter*0.92-2*fitting, diameter*0.92-2*fitting, length], center=true);
    }
}

module AxelCutout(diameter, length, fitting)
{
    intersection()
    {
        cylinder(d=diameter+2*fitting, h=length, center=true, $fn=64);
        cube([diameter*0.93+2*fitting, diameter*0.93+2*fitting, length], center=true);
    }
}

module Axel3Lock()
{
    difference()
    {
        cylinder(d=16, h=7, center=true, $fn=32);
        rotate([0,0,0])
        Axel3Cutout(8,9,0.2);
        rotate([0,90,0])
        cylinder(d=3.4,h=8,$fn=32);
        translate([1.4,-2.8,-5])
        cube([4.4,5.8,10]);
    }
}

module Axel3Spacer()
{
    difference()
    {
        cylinder(d=15, h=7, center=true, $fn=32);
        Axel3Cutout(8,9,0.2);
    }
}