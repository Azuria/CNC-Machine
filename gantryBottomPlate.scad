use <mirror_copy.scad>;

module gantryBottomPlate(length=100, width=50, thickness=15) {
	
	m5 = 4.9;
	holedistance = 30;
	
	difference() {
		cube([width, length, thickness], center=true);
		
		//M5 screwholes at the ends
		for (x = [-1,1]) 
			mirror_copy() translate([x*holedistance/2,length/2, 0]) rotate([90,0,0]) cylinder(d=m5, h=50, center=true);
		
		//M5(?) screwholes at the center
		for (x=[-1,1])
            mirror_copy() translate([x*(35/2-6.5),48/2-5,-thickness]) cylinder(h=thickness*2, center=false, d=m5);
	}
}

gantryBottomPlate(500);