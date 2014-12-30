//Bracket

module 8020toKR33bracket(size=2*25.4, spacer=14) {
    $fn=20;
    translate([0,0,-25.4])
    difference() {
        translate([0, -size/2, 0]) 
        union() {
            cube([10, size, size]);
            cube([spacer, size, 5]);
            translate([0, 0, size-5]) cube([14, size, 5]);
            rotate([0,270,0]) translate([0, 36, 0]) cube([size, 5, 3]);
            rotate([0,270,0]) translate([0, 10, 0]) cube([size, 5, 3]);
        }
        
        union() { 
            //Big holes
    
            translate([-10, 13, 10]) rotate([0, 90,0]) cylinder(30, d=6);
            translate([-10, 13, 40]) rotate([0, 90,0]) cylinder(30, d=6);
            translate([-10, -13, 10]) rotate([0, 90,0]) cylinder(30, d=6);
            translate([-10, -13, 40]) rotate([0, 90,0]) cylinder(30, d=6);
            //Small holes
            translate([-10, 20, 35]) rotate([0, 90,0]) cylinder(30, d=2);
            translate([-10, 20, 15]) rotate([0, 90,0]) cylinder(30, d=2);
            translate([-10, -20, 35]) rotate([0, 90,0]) cylinder(30, d=2);
            translate([-10, -20, 15]) rotate([0, 90,0]) cylinder(30, d=2);
        }
    }
}

8020toKR33bracket();

//TODO - fix backside