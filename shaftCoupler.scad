//Frode Lillerud, 15.12.2014

module shaftCoupler(from=5, to=8, length=25, diameter=20) {
    difference() {
        cylinder(d=diameter, h=length, center=true);
        //Small hole
        union() {
            translate([0,0,length/2]) cylinder(d=from, h=length+1, center=true);
            translate([0,0,(length/2)-6]) cylinder(r1=1, r2=10, h=length); //chamfer, todo - change size when variable 'from' changes
        }
        //Big hole
        union() {
            translate([0,0,-length/2]) cylinder(d=to, h=length+1, center=true);
            translate([0,0,(-length/2)-length+10]) cylinder(r1=10, r2=1, h=length); //chamfer
        }
        //Rings
        difference() {
            for(x = [-length/5:3:length/5])
                translate([0,0,x]) cylinder(h=1,d=diameter+1);
            cylinder(d=to+2, h=length, center=true);
        }
        //Set screws
        for (z = [length/3,-length/3])
            translate([diameter/2,0,z]) rotate([0,90,0]) cylinder(d=2.5, h=diameter/2, center=true);
    }
}

shaftCoupler($fn=100, to=10);