//Items from tnutz.com
//Frode Lillerud, january 2015

use <Library.scad>;

inch = 25.4;

module teeJoiningPlate() {
    
    p2 = [[0,0],[0,1.5*inch],[1.5*inch,1.5*inch],[3*inch,.5*inch], [3*inch,0]];

    difference() {
        mirror_copy() linear_extrude(height=.188*inch) polygon(p2);
        for (x = [.5,1.5,2.5])
            translate([x*inch,0,0]) cylinder(d=.281*inch, h=inch, center=true);
        for (y = [-1,1])
            translate([.5*inch,y*inch,0]) cylinder(d=.281*inch, h=inch, center=true);
    }
}

module ninetyDegreeJoiningPlate() {
	linear_extrude(height=.188*inch)
	difference() {
		square(3*inch, center=true);
		translate([1.8*inch, 1.8*inch,0]) rotate(45) square(100, center=true);
		translate([-1*inch,0,0]) circle(d=.281*inch);
		translate([-1*inch,inch,0]) circle(d=.281*inch);
		translate([-1*inch,-1*inch,0]) circle(d=.281*inch);
		translate([0,-1*inch,0]) circle(d=.281*inch);
		translate([inch,-1*inch,0]) circle(d=.281*inch);
	}
}

teeJoiningPlate();
translate([0,80,0]) ninetyDegreeJoiningPlate();