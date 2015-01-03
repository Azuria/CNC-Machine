inch = 25.4;

module JoiningPlate30_4351() {
	linear_extrude(height=4)
	difference() {
		square(90, center=true);
		translate([1.9*inch, 1.9*inch,0]) rotate(45) square(100, center=true);
		translate([-30,0,0]) circle(d=6.3);
		translate([-30,30,0]) circle(d=6.3);
		translate([-30,-30,0]) circle(d=6.3);
		translate([0,-30,0]) circle(d=6.3);
		translate([30,-30,0]) circle(d=6.3);
	}
}

JoiningPlate30_4351();