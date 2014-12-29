module  bearingBlock(h=33, w=45, m=45, r=10) {
    screw_depth = 12;
    difference() {
        minkowski() {
            rotate([0,90,0]) cube([h,w,m], center=true);
            sphere(1);
        }
        rotate([90, 0, 90]) cylinder(r=r, m*2, center=true); //inner
        translate([w/2, 0, 0]) rotate([90, 0, 90]) cylinder(r=r+3, 5, center=true); //outer
        translate([0,0,h/2]) cube([m*2, w/3, 3], center=true);
        translate([0, 0, -h/2]) rotate([45,0,0]) cube([m*2, w/2, w/2], center=true);
        for (z = [0:360/4:360])
            rotate([0, 0, z+45]) translate([20, 0, h/2-screw_depth/2+1]) cylinder(d=5, h=12, center=true);
    }
    
}

module supportedLinearRail(length = 200, shaftdimension = 16, blockspacing = 10) {
    difference() {
    union() {
        rotate([0,90,0]) cylinder(h=length, d=shaftdimension, center=true);
    
        translate([-length/2,0,-1*shaftdimension+1]) 
            rotate([90,00,90]) 
            linear_extrude(height=length, convexity=2)
            polygon(
                points = [
                    [-16, -6], [-16,-3], [-8,-3], [-8,0],[-8,2],[-7,2],[-2,8], [0, 7], [2,8], [7,2], [8, 2], [8,0], [8,-3], [16, -3], [16, -6]
                ],
                paths = [
                    [0,1,2,3,4,5,6,7,8, 9,10,11,12,13,14]
                ]);
        
    }
    //Holes for screws along the rail
    for (y = [-12, 12]) 
        for (x = [-length/2: 2*25.4: length/2])
            translate([x, y, -25]) cylinder(10, r=2);
    }
    translate([(blockspacing / 2)+45/2, 0, 0]) bearingBlock();
    translate([(-blockspacing / 2)-45/2, 0, 0]) bearingBlock();
}

supportedLinearRail(300, $fn=20, blockspacing = 5);

$fn = 20;