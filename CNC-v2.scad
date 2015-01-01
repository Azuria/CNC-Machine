use <TSlot_Fractional.scad>;
use <Library.scad>;
use <supportedLinearRail.scad>;
use <ballscrew.scad>;
use <shaftCoupler.scad>;
use <nema17.scad>;
use <teeJoiningPlate.scad>;
use <MScrew.scad>;
use <THKKR33.scad>;
use <TSlotProfile.scad>;

inch = 25.4;
cnc_length = 750;
cnc_width = 450-5*inch;
cnc_height = 300;
cnc_feet = 70;

zplate_width = 100;
zplate_height = 150;
zplate_depth = 10;

$t = 0; //Reset animation

module frame() {
    //#mirror_copy() translate([0, cnc_width/2+inch/2, 0]) rotate([90,0,90]) 1030Profile(cnc_length);
    mirror_copy([1,0,0]) translate([cnc_length/2+inch/2,0,0]) rotate([90,0,0]) 1030Profile(cnc_width+2*inch);
	mirror_copy() translate([0,cnc_width/2,0]) rotate([90,0,90]) TSlotProfile(series = 30, profile = 6060, length=cnc_length);
    %mirror_copy() translate([0,-cnc_width/2-2*inch,0]) rotate([90,0,0]) supportedLinearRail(cnc_length, blockspacing=0, holedistance=30);
    
    //Feet
    mirror_copy() mirror_copy([1,0,0]) translate([cnc_length/2+.5*inch, cnc_width/2, -cnc_feet+cnc_feet/2-1.5*inch]) TSlotProfile(series=30, profile=6060, length=cnc_feet);
}

module gantry() {
    translate([0,0,-3*inch]) rotate([90,90,0]) 1030Profile(cnc_width+2*inch+3*inch);
    mirror_copy() translate([0,cnc_width/2+3*inch,cnc_height/2-3.5*inch]) rotate([0,0,90]) 1030Profile(cnc_height);
    translate([-1*inch,0,cnc_height/2]) rotate([90,0,0]) 1030Profile(cnc_width+5*inch);
    
    mirror_copy() translate([0,-cnc_width/2-3.5*inch,-3.7*inch]) rotate([0,0,90]) teeJoiningPlate();
    translate([0,-cnc_width/2-2*inch,-3.9*inch]) color("black") screw("M5", "cap", 10);
}

module actuators() {
    //Y-axis
    translate([0,0,-1.5*inch]) rotate([180,0,0]) ballscrewAndMotor(cnc_length);
    //X-axis
    translate([inch/2,0,cnc_height/2]) rotate([270,0,270]) ballscrewAndMotor(cnc_width+5*inch);

}

module zaxis() {
    translate([1.5*inch, 0, cnc_height-5*inch]) cube([zplate_depth, zplate_width, zplate_height], center=true);
    //Z-axis
    translate([2.5*inch, 0, cnc_height-2.5*inch]) rotate([0,90,0]) thkKR33(length=280); //ballscrewAndMotor(cnc_height/2);
}

module tabletop () {
    translate([0,0,2*inch-6]) cube([cnc_length+2*inch,cnc_width+2*inch, 10], center=true);
}

module ballscrewAndMotor(length) {
    ballscrew(length);
    translate([length/2+3*inch,0,0]) rotate([0,270,0]) 
    union() {
        nema17();
        translate([0,0,70]) shaftCoupler();
    }
}

gantry();
zaxis();
frame();
%tabletop();
actuators();


