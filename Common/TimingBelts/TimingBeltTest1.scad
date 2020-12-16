fitting = 0.2;
numTeeth = 126;
width = 11;
pitch = 5;

gearD = (numTeeth*pitch/PI)-2*fitting;
echo(gearD);
gearR = 0.5*gearD;
teethD = 3.5;
teethR = teethD*0.5;

difference()
{
    union()
    {
        translate([0,0,-5])
        cylinder(d=205, h=5, $fn=256);
        difference()
        {
            cylinder(r=gearR-fitting, h=width, $fn=256);
            for(i=[0:numTeeth-1])
            {
                rotate([0,0,i*(360/numTeeth)])
                translate([0,gearR-fitting,0])
                cylinder(r=teethR+fitting, h=width+2, $fn=32);
            }
        }
        
        /*
        for(i=[0:7])
        {
            rotate([0,0,i*(360/8)])
            translate([0,gearR-fitting-10,0])
            cylinder(d=5, h=width+2, center=true, $fn=32);
        }
        */
    }
    translate([0,0,-6])
    cylinder(d=175, h=width+7,$fn=256);
    
    //cylinder(d=6, h=width+2, center=true, $fn=256);
}