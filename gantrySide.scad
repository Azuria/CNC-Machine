//Sideplate for the Gantry.

use <Library.scad>;

module gantrySide(height=250, topwidth=100, topheight=100, bottomwidth=80, bottomheight=50, topoffset=-100, railDiameter=10, width=5) {
	
	bottom = -72.5;
	holedistance = 30;
	m5 = 4.9;
	
	linear_extrude(width) 
	difference() {
		union() {
			hull() {
				translate([0,bottom,0]) square([bottomwidth/2, 20]);
				square([bottomwidth, bottomheight]);
			}
			translate([topoffset, height-topheight, 0]) square([topwidth, topheight]);
			hull() {
				translate([0, bottomheight,0]) square([bottomwidth, 1]);
				translate([topoffset, height-topheight,0]) square([topwidth, 1]);
			}
		}
		//Big hole for screwball
		translate([topoffset+topwidth/2, height-topheight/2, 0]) circle(railDiameter);
		
		//Small holes
		translate([holedistance/2, bottom+15]) circle(d=m5);
		translate([holedistance*1.5, bottom+15]) circle(d=m5);
		
		//Holes over extrusion for connecting to inner bracket
		//translate([15, bottom+15+30]) circle(d=5);
		//translate([15+30, bottom+15+30]) circle(d=5);
	}
}

//gantrySide();
gantry_topoffset = -50;
gantry_bottomwidth = 150;
cnc_height = 250;
gantrySide(height=cnc_height, topoffset=gantry_topoffset, bottomwidth=gantry_bottomwidth, bottomheight=50);