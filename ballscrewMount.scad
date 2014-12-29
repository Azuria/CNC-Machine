use <ballBearing.scad>;

module ballscrewMount(depth=20, height=43, width=60, outerhole=20, innerhole=10) {
    difference() {
        cube([depth, width, height], center=true);
        translate([0,0,height/10]) rotate([0,90, 0]) cylinder(d=outerhole, h=depth*2, center=true);
        translate([0, -width/2+(width/8.1), height/2.75]) cube([depth+1, width/4, height/3], center=true);
        translate([0, width/2-(width/8.1), height/2.75]) cube([depth+1, width/4, height/3], center=true);
        for (x = [-4,12])
            for (y = [-22,22])
                rotate([0,90,0]) translate([x,y,0]) cylinder(d=5.5, h=depth+1, center=true);
        translate([0,-width/2+8,0]) cylinder(d=6.6, h=height+1, center=true);
        mirror([0,1,0]) translate([0,-width/2+8,0]) cylinder(d=6.6, h=height+1, center=true);
    }
    translate([0,0,height/10]) rotate([0,90,0]) ballbearing(innerhole, outerhole, depth/2);
}

ballscrewMount();