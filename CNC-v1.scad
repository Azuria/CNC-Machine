use <Library.scad>;
use <nema17.scad>;
use <workplate.scad>;
use <ballscrew.scad>;
use <supportedLinearRail.scad>;
use <cablechain.scad>;
//use <aluminumextrusion.scad>;
use <TSlot_Fractional.scad>;
//use <Sidewall.scad>;
use <cornerBracket.scad>;
use <8020toKR33bracket.scad>;
use <THKKR33.scad>;

cnc_length = 800;
cnc_width = 400;
cnc_height = 300;

actuators = (true ? "THKKR33" : "Ballscrew"); //true/false changes actuators

//Stepper motors
translate([-cnc_length/2-(1.2*25.4),0,(2*25.4)]) rotate([0,90,0]) nema17();
move(x=-cnc_length/2+(5*25.4), y=-cnc_width/2-(3*25.4), z=cnc_height) rotate([270, 0, 0]) nema17();
move(z=cnc_height+(9.5*25.4), x=-cnc_length/2+(7*25.4)) rotate([0,180,0]) nema17();

//Workarea
move(z=3*25.4, x=5*25.4*$t) workarea(cnc_length/2, cnc_width-(2*25.4*1.1));
//move(x=-cnc_length/2+(6*25.4), z=cnc_height) rotate([0, 90, 0]) workarea(120, 120);



//move(y=cnc_width/2+40) cablechain(links=20);

//rotate([0,90,0]) move(y=-cnc_width/2) aluminiumextrusion(300);
//rotate([0,90,0]) move(y=cnc_width/2) aluminiumextrusion(300);

//Aluminum extrusion in X-axis
move(y=-cnc_width/2) rotate([0, 90, 0]) 2020Profile(cnc_length);
move(y=cnc_width/2) rotate([0, 90, 0]) 2020Profile(cnc_length);

//Uprights
move(x=-cnc_length/2+(3*25.4), y=-cnc_width/2, z=cnc_height/2+25.4) 2020Profile(cnc_height);
mirror ([0,1,0]) move(x=-cnc_length/2+(3*25.4), y=-cnc_width/2, z=cnc_height/2+25.4) 2020Profile(cnc_height);

//Cross-sections in base
move(x=-cnc_length/2+(2*25.4)) rotate([90, 0, 0]) 2020Profile(cnc_width-(2*25.4));
move(x=cnc_length/2-(2*25.4)) rotate([90, 0, 0]) 2020Profile(cnc_width-(2*25.4));

//Corner brackets
move(x=-cnc_length/2+(4*25.4), y=cnc_width/2, z=25.4) cornerBracket();
mirror([0,1,0]) move(x=-cnc_length/2+(4*25.4), y=cnc_width/2, z=25.4) cornerBracket();
move(x=-cnc_length/2+(2*25.4), y=cnc_width/2, z=25.4) rotate([0,0,180]) cornerBracket();
mirror([0,1,0]) move(x=-cnc_length/2+(2*25.4), y=cnc_width/2, z=25.4) rotate([0,0,180]) cornerBracket();
translate([-cnc_length/2+(3*25.4), cnc_width/2-(1*25.4), 0]) rotate([90,0,0]) cornerBracket();
translate([-cnc_length/2+(3*25.4), -cnc_width/2+(1*25.4), 0]) rotate([90,0,90]) cornerBracket();
translate([cnc_length/2-(3*25.4), -cnc_width/2+(1*25.4), 0]) rotate([90,0,180]) cornerBracket();
translate([cnc_length/2-(3*25.4),  cnc_width/2-(1*25.4), 0]) rotate([90,0,270]) cornerBracket();

//TODO - add two more





//move(y=cnc_width/2) sidewall(height=200); //right side
//mirror([0,1,0]) move(y=cnc_width/2) sidewall(height=200); //left side

//THK KR33 actuators
if (actuators == "THKKR33") {
    move(x=-cnc_length/2+(5*25.4), z=cnc_height) rotate([90, 0, 90]) thkKR33();
    move(z=2*25.4) thkKR33(length=400);
    move(z=cnc_height+(2*25.4), x=-cnc_length/2+(7*25.4)) rotate([0, 90, 0]) thkKR33(length=280);

    //Brackets between 8020 and Kr33
    move(x=-cnc_length/2+(4*25.4), y=cnc_width/2, z=cnc_height) color("lightgrey") 8020toKR33bracket();
    mirror([0,1,0]) move(x=-cnc_length/2+(4*25.4), y=cnc_width/2, z=cnc_height) color("lightgrey") 8020toKR33bracket();
    move(x=-cnc_length/2+(2*25.4), z=25.4) rotate([0,270,90]) 8020toKR33bracket();
    move(x=cnc_length/2-(2*25.4), z=25.4) rotate([0, 270, 90]) 8020toKR33bracket();
    //TODO - add under the X-axis


}
else if (actuators == "Ballscrew") {
    move(x=-cnc_length/2+(3*25.4), z=cnc_height) rotate([90, 0, 0]) 2020Profile(cnc_width-(2*25.4));
    translate([-cnc_length/2+(5*25.4),0,cnc_height]) rotate([90,0,90])  ballscrew(rod_length=300, rod_diameter=16);
    move(x=-cnc_length/2+(3*25.4), z=cnc_height+(2*25.4)) rotate([0,0,90]) supportedLinearRail(300);
    move(z=25.4*2, y=cnc_width/2-(25.4*2)) supportedLinearRail(cnc_length);
    move(z=25.4*2, y=-cnc_width/2+(25.4*2)) supportedLinearRail(cnc_length);
    move(z=25.4*2) ballscrew(rod_length=cnc_length-(4*25.4));
}