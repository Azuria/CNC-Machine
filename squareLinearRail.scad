use <Library.scad>;

module squareLinearRail(length=100, size=25, blockspacing = 10) {
	difference() {
		rotate([90,0,90]) translate([-10,-10,-length/2]) linear_extrude(height=length) difference() {
			square(20);
			translate([-2,10,0]) circle(5);
			translate([22,10,0]) circle(5);
		}
		for (x = [-length/2+10: 35 : length/2 - 10])
			translate([x, 0, -10]) cylinder(d=11, h=length);
	}
	
	translate([-blockspacing/2-104/2,0,0]) squareRailBlock();
	translate([blockspacing/2+104/2,0,0]) squareRailBlock();
	
}

module squareRailBlock() {
	difference() {
		translate([0,0,6]) cube([104, 70, 36-5.5], center=true);
		mirror_copy() translate([45/2,57/2,-1]) cylinder(d=11, h=100);
		mirror_copy() translate([-45/2,57/2,-1]) cylinder(d=11, h=100);
	}
}



squareLinearRail(length=500, blockspacing = 50);