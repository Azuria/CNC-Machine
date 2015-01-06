module nemaMotorMount() {
	$fn=100;
	width = 55;
	length = 43;
	difference() {
		cube([width, width, length], center=true);
		cylinder(d=30, center=true, h=60);
		translate([0,0,-29]) cylinder(d=40, center=true, h=20);
		translate([0,width/2,20]) cube([30, 60, 60], center=true);
		for (i = [0:360/4:359])
			rotate([0,0,i]) translate([width/2-3, width/2-3, 0]) cylinder(d=5, h=60, center=true);
	}
}

nemaMotorMount();