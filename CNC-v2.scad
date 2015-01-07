use <EightyTwentyParts.scad>;
use <Library.scad>;
use <supportedLinearRail.scad>;
use <ballscrew.scad>;
use <shaftCoupler.scad>;
use <nema.scad>;
use <nemaMotorMount.scad>;
use <teeJoiningPlate.scad>;
//use <MScrew.scad>;
//use <THKKR33.scad>;
use <TSlotProfile.scad>;
use <tnutz.scad>;
use <gantrySide.scad>;
use <gantryBottomPlate.scad>;
use <squareLinearRail.scad>;

inch = 25.4;
cnc_length = 900;
cnc_width = 450;
cnc_height = 250;
cnc_feet = 100;

gantry_topoffset = -100;
gantry_bottomwidth = 150;
gantry_topwidth = 100;
gantry_width = 15;

zplate_width = 150;
zplate_height = 250;
zplate_thickness = 10;

$t = 0; //Reset animation

module frame() {
	
	nemaspacing = 142*1.5; //length of nema23 + 20%
	
    //Ends
	mirror_copy([1,0,0]) translate([cnc_length/2-15,0,0]) rotate([90,0,0]) TSlotProfile(series=30,profile=3060, length=cnc_width-60);
	//Middle
	translate([-cnc_length/2+nemaspacing,0,0]) rotate([90,0,0]) TSlotProfile(series=30,profile=3060, length=cnc_width-60);
	translate([cnc_length/2-nemaspacing,0,0]) rotate([90,0,0]) TSlotProfile(series=30,profile=3060, length=cnc_width-60);
	//Sides
	mirror_copy() translate([0,cnc_width/2,0]) rotate([90,0,90]) TSlotProfile(series = 30, profile = 6060, length=cnc_length);
	
	//Rails
    mirror_copy() translate([0,-cnc_width/2-2*inch,0]) rotate([90,0,0]) supportedLinearRail(cnc_length, blockspacing=60, holedistance=30);
	//squareLinearRail(length=500, blockspacing = 50);
    
    //Feet
    mirror_copy() mirror_copy([1,0,0]) translate([cnc_length/2-30, cnc_width/2, -cnc_feet+cnc_feet/2-30]) TSlotProfile(series=30, profile=6060, length=cnc_feet);
	
	//Brackets
	for (x = [-1,1])
		color("lightgrey") mirror_copy() translate([x*cnc_length/2+(2*x),-cnc_width/2+15,-15]) rotate([0,90,0]) JoiningPlate30_4351();
	
	//Y-axis ballscrew
    translate([-nemaspacing/2+10,0,-55]) rotate([180,0,0]) ballscrewAndMotor(cnc_length-nemaspacing, nut_offset=22);
}

module gantry() {
	//Top
	translate([gantry_topoffset,0,cnc_height-45]) rotate([90,0,0]) TSlotProfile(series = 30, profile = 3060, length=cnc_width+5*inch);
	
	translate([gantry_topoffset,0,cnc_height-45-60]) rotate([90,0,0]) TSlotProfile(series = 30, profile = 3060, length=cnc_width+5*inch);
	
	//Linear rails on top
	//translate([gantry_topoffset+11,0,cnc_height-30]) rotate([90,0,90]) squareLinearRail(cnc_width+5*inch);
	//translate([gantry_topoffset+11,0,cnc_height-130]) rotate([90,0,90]) squareLinearRail(cnc_width+5*inch);
	translate([gantry_topoffset+38,0,cnc_height-45]) rotate([90,0,90]) supportedLinearRail(cnc_width+5*inch, blockspacing=50);
	translate([gantry_topoffset+38,0,cnc_height-45-60]) rotate([90,0,90]) supportedLinearRail(cnc_width+5*inch, blockspacing=50);
	
	//Sidewalls
	%mirror_copy() translate([-gantry_bottomwidth/2,cnc_width/2+83, -15]) rotate([90,0,0]) gantrySide(height=cnc_height, topoffset=gantry_topoffset, topwidth=gantry_topwidth, bottomwidth=gantry_bottomwidth, bottomheight=50, width=gantry_width);
	
	//Bottom
    //translate([-45,0,-80]) rotate([90,90,0]) TSlotProfile(series = 30, profile = 3060, length=cnc_width+2*inch+3*inch);
	translate([-45,0,-72.5]) gantryBottomPlate(cnc_width+136);
    
	//mirror_copy() translate([0,cnc_width/2+3*inch,cnc_height/2-3.5*inch]) rotate([0,0,90]) TSlotProfile(series = 10, profile = 1030, length=cnc_height);
    
    //X-axis
    translate([gantry_topoffset-42,0,cnc_height-50]) rotate([90,0,270]) ballscrewAndMotor(cnc_width+5*inch, nut_rotate=270);
	
    //mirror_copy() translate([0,-cnc_width/2-3.5*inch,-3.7*inch]) rotate([0,0,90]) teeJoiningPlate();
    //translate([0,-cnc_width/2-2*inch,-3.9*inch]) color("black") screw("M5", "cap", 10);
}

module zaxis() {
    translate([gantry_topoffset+20, 0, cnc_height-5*inch]) cube([zplate_thickness, zplate_width, zplate_height], center=true);
    //Z-axis
    //translate([2.5*inch, 0, cnc_height-2.5*inch]) rotate([0,90,0]) thkKR33(length=280); //ballscrewAndMotor(cnc_height/2);
	translate([gantry_topoffset+50,0,cnc_height-5*inch]) rotate([0,270,180]) ballscrewAndMotor(zplate_height);
	translate([gantry_topoffset+75,0,cnc_height-5*inch]) cube([10,150,150], center=true);
	
	//Linear rails
	mirror_copy() translate([gantry_topoffset+46,50,cnc_height-5*inch]) rotate([0,90,0]) supportedLinearRail(length=zplate_height, blockspacing=20);
}

module tabletop () {
    translate([0,0,40]) cube([cnc_length,cnc_width+130, 10], center=true);
}

module ballscrewAndMotor(length, nut_offset=0, nut_rotate=0) {
    ballscrew(length, nut_offset=nut_offset, nut_rotate=nut_rotate);
    translate([length/2+3*inch,0,0]) rotate([0,270,0]) 
    union() {
        translate([0,0,-93]) nema23();
        translate([0,0,70]) shaftCoupler();
		translate([0,0,40]) rotate([0,0,90]) nemaMotorMount();
    }
}

translate([0,0,-10]) gantry();
translate([40,0,88]) zaxis();
frame();
%tabletop();

//!ballscrewAndMotor(zplate_height);