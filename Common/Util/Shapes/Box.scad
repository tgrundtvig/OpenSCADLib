// Auther: Tobias Grundtvig
// Date: Oct 1, 2020
//
// A wrapper of the build-in cube module, to get consistent naming

Box([10,20,30], t_x="pos", t_y="neg", t_z="pos");

module Box(dimensions, t_x="center", t_y="center", t_z="center")
{
    tx = t_x == "neg" ? -dimensions[0]/2 : 
            t_x == "pos" ? dimensions[0]/2 : 0;
    ty = t_y == "neg" ? -dimensions[1]/2 : 
            t_y == "pos" ? dimensions[1]/2 : 0;
    tz = t_z == "neg" ? -dimensions[2]/2 : 
            t_z == "pos" ? dimensions[2]/2 : 0;
    translate([tx, ty, tz])
        cube(dimensions, center=true);
}
