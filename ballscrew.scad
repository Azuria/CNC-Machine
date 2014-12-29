//Frode Lillerud, 29.nov 2014

//rod_diameter = 16;
//rod_lenght = 300;

use <ballscrewMount.scad>;
use <ballnutMount.scad>;

module ballscrew_rod(rod_length = 300, rod_diameter = 16) {
    rotate([0,90,0]) cylinder(r=rod_diameter/2, h=rod_length, $fn=20, center=true);
}

module ballscrew_nut(nut_diameter = 16) {
    difference() {
        rotate([0,0,90]) union() {
            difference() {
                difference() {
                    intersection() {
                        cube([40,100,10], center=true);
                        cylinder(d=48,h=10,center=true);
                    }
                    #cylinder(d=nut_diameter, h=11, center=true);
                }
            
                union() {
                    for(a = [-45,0,45]) {
                        rotate(a=a) translate([0,20,-10]) cylinder(d=5.5,h=20, $fn=20);
                    }
                    for(a = [-45,0,45]) {
                    rotate(a=a) translate([0,-20,-10]) cylinder(d=5.5,h=20, $fn=20);
                    }
                }
            }
            cylinder(d=28,h=42,center=false);
        }
        translate([0,0,-1])cylinder(r=nut_diameter/2, h=42+2, $fn=20, center=false);
        
    }
    translate([0,0,23]) rotate([0,90,90]) ballnutMount();
}

module ballscrew(rod_length=100, rod_diameter=8) {   
    color("lightgrey")
        rotate([$t*360,0,0]) ballscrew_rod(rod_length, rod_diameter);
    color("lightgrey")
        translate([$t*rod_length/2,0,0]) rotate([90,0,90]) ballscrew_nut(rod_diameter);
    translate([rod_length/2-10, 0, -4]) ballscrewMount();
    translate([-rod_length/2+10, 0, -4]) ballscrewMount();
}

ballscrew(rod_length=300, rod_diameter=10);