/*
function x(a) = 10 * sin(a);
function y(a) = 30 * cos(a);
points = [ for (a = [0 : 5 : 359]) [ x(a), y(a) ] ];
//echo(points);
//polygon(points);

p = [ for (x = [0:5]) for (y = [0:6]) [y,x]];
echo (p);
polygon(p);
*/

use <mirror_copy.scad>;

module teeJoiningPlate() {
    inch = 25.4;
    p2 = [[0,0],[0,1.5*inch],[1.5*inch,1.5*inch],[3*inch,.5*inch], [3*inch,0]];

    difference() {
        mirror_copy() linear_extrude(height=.188*inch) polygon(p2);
        for (x = [.5,1.5,2.5])
            translate([x*inch,0,0]) cylinder(d=.281*inch, h=inch, center=true);
        for (y = [-1,1])
            translate([.5*inch,y*inch,0]) cylinder(d=.281*inch, h=inch, center=true);
    }
}

teeJoiningPlate();