//Frode Lillerud, 1.des 2014

module chainwall(pegdirection=true) {
    difference() {
        union() {
            union() {
                cube([20,1,10], center=false);
                if(pegdirection)
                    translate([0,-0.5,5]) rotate(a=90, v=[1,0,0]) cylinder(r=5, center=true);
                else
                    translate([0,1.5,5]) rotate(a=90, v=[1,0,0]) cylinder(r=5, center=true);
            }
            if (pegdirection==true)
                translate([0,3,5]) rotate(a=90, v=[1,0,0]) cylinder(r=2, h=3, $fn=20);
            else
                translate([0,1,5]) rotate(a=90, v=[1,0,0]) cylinder(r=2, h=3, $fn=20);
        }
        translate([15,2,5]) rotate(a=90, v=[1,0,0]) cylinder(r=2, h=3, $fn=20);
    }
}

module base() {
    cube([10,20,1]);
}

module chainlink() {
    color([.25,.25,.25]) {
        base();
        chainwall(false);
        translate([0,20,0]) chainwall(true);
    }
}

module cablechain(links=10) {
    for (i = [0:links-1]) {
        translate([i*16, 0, 0]) chainlink();
    }
}

cablechain(30);