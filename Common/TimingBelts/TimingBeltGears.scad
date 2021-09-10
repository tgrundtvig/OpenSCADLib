include <Common/Util/Shapes.scad>
use <Common/Gears/GearUtil.scad>
/*
difference()
{
    SimpleTimingGear(gearHeight=6, numberOfTeeth=20, pitch=2, toothDia=1, fitting=0.3, gearRes=256, toothRes=64);
    translate([0,0,-1])
    cylinder(d=8, h=8, $fn=64);
}
*/
difference()
{
    union()
    {
        translate([0,0,1])
        SimpleTimingGear(gearHeight=12, numberOfTeeth=16, pitch=5, toothDia=3.5, fitting=0.3, gearRes=256, toothRes=64);
        cylinder(d=28,h=1, $fn=256);
        translate([0,0,13])
        cylinder(d=5, h=0.4, $fn=64);
    }
    translate([0,0,1])
    axis_width_M3_fastener_cutout(  axis_dia = 3.4,
                                    gear_height=12,
                                    gear_dia=28,
                                    angular_resolution=64 );
    translate([0,0,-1])
    Cylinder(diameter=5.4, height=4, t_z="pos", angular_resolution=64);
    
}
/*
difference()
{
    SimpleTimingGear(gearHeight=10, numberOfTeeth=20, pitch=5, toothDia=3.2, fitting=0.4, gearRes=256, toothRes=64);
    translate([0,0,-1])
    cylinder(d=24, h=12, $fn=64);
}
*


//Driver2GT16T();
//Driver2GT64T();
//Driver2GT96T();
                
                
/*
DriverGear( baseHeight=6,
            baseDia=22,
            boreDia=5.4,
            nutWidth=5.9,
            nutHeight=2.7,
            nutHoleDia=3.6,
            nutHoleRes=32,
            gearHeight=14,
            numberOfTeeth=20,
            pitch=2,
            toothDia=1,
            fitting=0.3,
            gearRes=64,
            toothRes=32 );
*/

function OuterGearRadius(numberOfTeeth, pitch) = numberOfTeeth*pitch/(2*PI);
function InnerGearRadius(numberOfTeeth, pitch, toothDia) =
    OuterGearRadius(numberOfTeeth, pitch) - (toothDia*0.5);

module SimpleTimingGear(gearHeight, numberOfTeeth, pitch, toothDia, fitting, gearRes, toothRes)
{
    gearR = OuterGearRadius(numberOfTeeth, pitch);
    echo(str("Gear Diameter = ",gearR*2));
    teethR = toothDia*0.5;
    difference()
    {
        cylinder(r=gearR-fitting, h=gearHeight, $fn=gearRes);
        for(i=[0:numberOfTeeth-1])
        {
            rotate([0,0,i*(360/numberOfTeeth)])
            translate([0,gearR-fitting,-1])
            cylinder(r=teethR+fitting, h=gearHeight+2, $fn=toothRes);
        }
    }
}

module Driver2GT16T()
{
    DriverGear( baseHeight=6,
                baseDia=16,
                boreDia=5.4,
                nutWidth=5.9,
                nutHeight=2.7,
                nutHoleDia=3.6,
                nutHoleRes=32,
                gearHeight=7,
                numberOfTeeth=16,
                pitch=2,
                toothDia=1,
                fitting=0.3,
                gearRes=64,
                toothRes=32 );
}

module Driver2GT64T()
{
    DriverGear( baseHeight=6,
                baseDia=16,
                boreDia=5.4,
                nutWidth=5.9,
                nutHeight=2.7,
                nutHoleDia=3.6,
                nutHoleRes=32,
                gearHeight=7,
                numberOfTeeth=64,
                pitch=2,
                toothDia=1,
                fitting=0.3,
                gearRes=64,
                toothRes=32 );
}

module Driver2GT96T()
{
    rotate([180,0,0])
    difference()
    {
        DriverGear( baseHeight=6,
                    baseDia=16,
                    boreDia=5.4,
                    nutWidth=5.9,
                    nutHeight=2.7,
                    nutHoleDia=3.6,
                    nutHoleRes=32,
                    gearHeight=7,
                    numberOfTeeth=96,
                    pitch=2,
                    toothDia=1,
                    fitting=0.3,
                    gearRes=64,
                    toothRes=32 );
        for(i=[0:5])
        {
            rotate([0,0,i*60])
            translate([18,0,5])
            cylinder(d=16, h=9, $fn=64);
        }
    }
}


module SimpleTimingGear2GT(gearHeight, numberOfTeeth, gearRes, toothRes)
{
    SimpleTimingGear(gearHeight=gearHeight, numberOfTeeth=numberOfTeeth, pitch=2, toothDia=1.2, fitting=0.2, gearRes=gearRes, toothRes=toothRes);
}

module GearWithBase(    baseHeight,
                        baseDia,
                        boreDia,
                        gearHeight,
                        numberOfTeeth,
                        pitch,
                        toothDia,
                        fitting,
                        gearRes,
                        toothRes)
{
    difference()
    {
        union()
        {
            cylinder(d=baseDia, h=baseHeight, $fn=gearRes);
            translate([0,0,baseHeight])
            SimpleTimingGear(   gearHeight=gearHeight,
                                numberOfTeeth=numberOfTeeth,
                                pitch=pitch,
                                toothDia=toothDia,
                                fitting=fitting,
                                gearRes=gearRes,
                                toothRes=toothRes );
        }
        translate([0,0,-1])
        cylinder(d=boreDia, h=baseHeight+gearHeight+2, $fn=gearRes);
    }
}

module DriverGear(  baseHeight,
                    baseDia,
                    boreDia,
                    nutWidth,
                    nutHeight,
                    nutHoleDia,
                    nutHoleRes,
                    gearHeight,
                    numberOfTeeth,
                    pitch,
                    toothDia,
                    fitting,
                    gearRes,
                    toothRes)

{
    difference()
    {
        GearWithBase(   baseHeight=baseHeight,
                        baseDia=baseDia,
                        boreDia=boreDia,
                        gearHeight=gearHeight,
                        numberOfTeeth=numberOfTeeth,
                        pitch=pitch,
                        toothDia=toothDia,
                        fitting=fitting,
                        gearRes=gearRes,
                        toothRes=toothRes);
        translate([-nutWidth*0.5, boreDia*0.5+1, -1])
        cube([nutWidth, nutHeight, 0.5*baseHeight+0.5*nutWidth+1]);
        translate([0,0,0.5*baseHeight])
        rotate([-90,0,0])
        cylinder(d=nutHoleDia, h=baseDia*0.5+1, $fn=nutHoleRes);
    }
}