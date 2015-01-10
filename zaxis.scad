//Model of one of the Z-axis's sold by ebay seller 'jbcrd1'
use <nema.scad>;
use <shaftCoupler.scad>;

inch = 25.4;
aluwidth = 3/8*inch;
totalWidth = 2.625*inch;
totalHeight = 10*inch;

module zaxis() {
	translate([totalWidth/2-aluwidth/2,0,0]) frontplate();
	translate([-totalWidth/2+aluwidth/2,0,0]) backplate();
	translate([0,0,totalHeight/2+aluwidth/2]) endwall(holesize=35);
	translate([0,0,-totalHeight/2-aluwidth/2]) endwall();
	translate([5,0,5*inch/2-aluwidth/2]) spacerwall();
	translate([5,0,-3*inch/2]) spacerwall();
	for (y = [-1,1])
		translate([0,y*1.5*inch, 0]) rail();
	translate([0,0,-.5*inch]) zscrew();
	translate([0,0,9.8*inch]) rotate([180,0,0]) nema23();
}

module frontplate(width=4*inch, height=5*inch) {
	rotate([0,90,0]) cube([height, width, aluwidth], center=true);
	//TODO - screwholes, size 5/32 (ca M4)
}

module backplate(width=4*inch, height=10*inch) {
	rotate([0,90,0]) cube([height, width, aluwidth], center=true);
	//TODO - screwholes
}

module endwall(width=totalWidth, height=4*inch, holesize=12) {
	difference() {
		cube([width, height, aluwidth], center=true);
		cylinder(h=aluwidth*2, d=holesize, center=true);
	}
}

module spacerwall() {
	cube([totalWidth-2*aluwidth, 4*inch, aluwidth], center=true);
}

module rail() {
	cylinder(h=totalHeight, d=16, center=true);
}

module zscrew() {
	translate([0,0,(totalHeight)/2]) shaftCoupler();
	cylinder(h=totalHeight+.5*inch, d=12, center=true);
}

zaxis();