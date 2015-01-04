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
                    translate([0,0,height/2]) fillet(cornerRadius, height+2);
                }
                translate([0, depth, height/2])
                rotate(a=270, v=[0,0,1]) 
                fillet(cornerRadius, height+2);
            }
            translate([width, depth, height/2])
            rotate(a=180, v=[0,0,1])
            fillet(cornerRadius,height+2);
        }
        translate([width, 0,height/2])
        rotate(a=90, v=[0,0,1])
        fillet(cornerRadius,height+2);
    }
	
	/*
	difference() {
		cube([width,depth,height], center=false);
		for (a = [0,90,180,270])
			#rotate([0,0,a]) translate([width,depth,height/2]) fillet(cornerRadius, height+2);
	}*/
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

module middle(height=30) {
    color("grey") roundedBox(40, 40, height, 10);
}

module top() {
    color("lightgrey")
    difference() {
        union() {
            difference() {
                translate([0,0,0]) 
                     roundedBox(40,40,9,5);
                translate([20,20,7]) //Screwholes
                    rotate(a=45)
                        for (i=[0:360/4:360]) { //Four screwholes
                            rotate(a=i, v=[0,0,1])
                            translate([22.2,0,0])
                            cylinder(r=1.5, h=5);
                        }
            }
            translate([20,20,9]) cylinder(r=21.9/2, h=2); //Big circle on top
        }
        translate([20,20,9]) cylinder(r=4.5, h=3); //Circle carve around shaft
    }
    
}

module shaft() {
    difference() {
        color("lightgrey") translate([20,20,0]) cylinder(r=2.5, h=25);
            translate([20, 20, 20]) cylinder(r=1, h=15);
    }
}

module nema17(center=false) {
	nema17_width = 40;
    translate([-nema17_width/2,-nema17_width/2,0])
    //difference() {
        union() {
            bottom();
            translate([0,0,9]) middle();
            translate([0,0,39]) top();
            translate([0,0,40]) shaft();
        }
    //}
}

module nema23() {
	nema23_width = 40; //TODO- check this
	
	translate([-nema23_width/2, -nema23_width/2, 0]) {
		translate([0,0,89+9+1]) shaft();
		translate([0,0,89+9]) top();
		translate([0,0,9]) middle(89);
		bottom();
	}
}

//render() 
nema17();
translate([45, 0, 0]) nema23();