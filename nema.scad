//Frode Lillerud, 29.nov 2014
//Nema 17 stepper motor

$fn = 50;
//nema_width = 40;
//nema_bodyheight = 30;
//nema_plateheight = 9;

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

module bottom(width=40, height=9) {
    difference() {
        //difference() {
            color("lightgrey") roundedBox(width,width,height,5);
            /*translate([width/2,width/2,-1]) //Screwholes
                rotate(a=45)
                    for (i=[0:360/4:360]) {
                        rotate(a=i, v=[0,0,1])
                        translate([width/2,0,0])
                        cylinder(d=3, h=5);
                    }
			*/
        //}
        translate([width/2,width/2,-1]) cylinder(r=5, h=5);
    }
}

module middle(height=30, width=40) {
    color("grey") roundedBox(width, width, height, 10);
}

module top(width=40, height=9) {
    color("lightgrey")
    difference() {
        union() {
            difference() {
                     roundedBox(width,width,height,5);
             
            }
            translate([width/2,width/2,height]) cylinder(r=width/4, h=2); //Big circle on top
        }
        translate([width/2,width/2,height]) cylinder(r=4.5, h=3); //Circle carve around shaft
    }
	
	//Shaft
	translate([0,0,1])
	difference() {
        color("lightgrey") translate([width/2,width/2,0]) cylinder(r=2.5, h=25);
            translate([width/2, width/2, width/4]) cylinder(r=1, h=15);
    }
    
}

module nema17_screwholes(width=40, height=45) {
    translate([0,0,-2])
                    rotate(a=45)
                        for (i=[0:360/4:360]) { //Four screwholes
                            rotate(a=i, v=[0,0,1])
                            translate([width/2,0,0])
                            cylinder(r=1.5, h=height*2);
                        }
}

module nema17() {
	nema17_width = 40;
	difference() {
		translate([-nema17_width/2,-nema17_width/2,0])
			union() {
				bottom();
				translate([0,0,9]) middle();
				translate([0,0,39]) top();
				//translate([0,0,40]) shaft();
        }
		nema17_screwholes(nema17_width);
	}
}

module nema23() {
	nema23_width = 56;
	//translate([-nema23_width/2, -nema23_width/2,0]) cube(56, center=true);
	
	difference() {
		translate([-nema23_width/2, -nema23_width/2, 0]) {
			translate([0,0,89+11]) top(height=11, width=nema23_width);
			translate([0,0,11]) middle(height=89, width=nema23_width);
			bottom(width=nema23_width, height=11);
		}
		//Side groves
		for (z = [0:360/4:359])
			color("grey") rotate([0,0,z+45]) translate([nema23_width/2+10,0,-1]) cylinder(d=10, h=89+11+11/2);
		nema17_screwholes(height=1000, width=70);
	}
}

//render() 
nema17();
translate([60, 0, 0]) nema23();
