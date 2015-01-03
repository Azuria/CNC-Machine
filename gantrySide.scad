//Sideplate for the Gantry.

module gantrySide(height=250, topwidth=100, topheight=100, bottomwidth=80, bottomheight=50, topoffset=-100, railDiameter=10, width=5) {
	linear_extrude(width) 
	difference() {
		union() {
			hull() {
				translate([0,-50,0]) square([bottomwidth/2, 20]);
				square([bottomwidth, bottomheight]);
			}
			translate([topoffset, height-topheight, 0]) square([topwidth, topheight]);
			hull() {
				translate([0, bottomheight,0]) square([bottomwidth, 1]);
				translate([topoffset, height-topheight,0]) square([topwidth, 1]);
			}
		}
		translate([topoffset+topwidth/2, height-topheight/2, 0]) circle(railDiameter);
	}
}

//gantrySide();
gantry_topoffset = -50;
gantry_bottomwidth = 150;
cnc_height = 250;
gantrySide(height=cnc_height, topoffset=gantry_topoffset, bottomwidth=gantry_bottomwidth, bottomheight=50);