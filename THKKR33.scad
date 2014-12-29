//THK KR33

use <shaftCoupler.scad>;

$fn = 100;

module thkKR33(length=350) {
    //color("grey")
    difference() {
        cube([length, 60, 40], center=true);
        translate([0,0,15]) cube([length-10, 50, 60], center=true);
        translate([-length/2-10, 0, 0]) rotate([0,90,0]) cylinder(h=20, d=30);
    }
    color("lightgrey") rotate([0, 90, 0]) cylinder(h=length, d=8, center=true);
    translate([-length/2, 0, 0]) rotate([0,90,180]) shaftCoupler();
    
    sled();
}

module sled() {
    translate([0,0,10]) cube([75, 47, 20], center=true);
}

thkKR33();