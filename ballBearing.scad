
module ballbearing(id, od, width) {
    difference() {
        union() {
            difference() {
                color("lightgrey") cylinder(d=od, h=width+.5, center=true);
                color("lightgrey") cylinder(d=od-1, h=width+2, center=true);
            }
            color("black") cylinder(d=od-1, h=width, center=true);
            color("lightgrey") cylinder(d=id+1, h=width+.5, center=true);
        }
        
        color("lightgrey") cylinder(d=id, h=width*2, center=true);
    }
    
}

$fn=30;
ballbearing(3,8,2.5);