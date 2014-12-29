//Frode Lillerud, 29.nov 2014
//Nema 17 stepper motor

$fn = 50;
nema_width = 40;
nema_bodyheight = 30;
nema_plateheight = 9;

module fillet(r, h) {
    translate([r / 2, r / 2, 0])
        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);
            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);
        }
}

module roundedBox(width, depth, height, cornerRadius) {
    difference() {
        difference() {
            difference() {
                difference() {
                    cube([width,depth,height], center=false);
                    fillet(cornerRadius, 60.1);
                }
                translate([0, depth, 0])
                rotate(a=270, v=[0,0,1]) 
                fillet(cornerRadius, 60.1);
            }
            translate([width, depth, 0])
            rotate(a=180, v=[0,0,1])
            fillet(cornerRadius,60.1);
        }
        translate([width, 0,0])
        rotate(a=90, v=[0,0,1])
        fillet(cornerRadius,60.1);
    }
}

module bottom() {
    difference() {
        difference() {
            color("lightgrey") roundedBox(40,40,9,5);
            translate([20,20,-1]) //Screwholes
                rotate(a=45)
                    for (i=[0:360/4:360]) {
                        rotate(a=i, v=[0,0,1])
                        translate([22.2,0,0])
                        cylinder(r=1.5, h=5);
                    }
        }
        translate([20,20,-1]) cylinder(r=5, h=5);
    }
}

module middle() {
    translate([0,0,9]) color("grey") roundedBox(40, 40, 30, 10);
}

module top() {
    color("lightgrey")
    difference() {
        union() {
            difference() {
                translate([0,0,9+30]) 
                     roundedBox(40,40,9,5);
                translate([20,20,45+1]) //Screwholes
                    rotate(a=45)
                        for (i=[0:360/4:360]) { //Four screwholes
                            rotate(a=i, v=[0,0,1])
                            translate([22.2,0,0])
                            cylinder(r=1.5, h=5);
                        }
            }
            translate([20,20,45+3]) cylinder(r=21.9/2, h=2); //Big circle on top
        }
        translate([20,20,45+3]) cylinder(r=4.5, h=3); //Circle carve around shaft
    }
    
}

module shaft() {
    difference() {
        color("lightgrey") translate([20,20,40]) cylinder(r=2.5, h=25);
            translate([20, 20, 60]) cylinder(r=1, h=15);
    }
}

module nema17() {
   
    translate([-40/2,-40/2,0])
    difference() {
        union() {
            bottom();
            middle();
            top();
            shaft();
        }
    }
}

//render() 
nema17();