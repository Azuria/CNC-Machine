//Ball nut mount for ballscrew
use <Library.scad>;


module ballnutMount(height=40, width=48, depth=35, screwhole=4.9, hole=28.1, guidehole=17) {
    difference() {
        cube([depth, width, height], center=true);
    
        //top screwholes
        for (x=[-1,1])
            mirror_copy() translate([x*(depth/2-6.5),width/2-5]) cylinder(h=height*2, center=false, d=screwhole);
        
        //ballscrew screws
        mirror_copy()
        for (x = [-45,0,45])
           rotate([x,0,0]) translate([0,38/2,0]) rotate([0,90,0]) cylinder(d=screwhole, h=depth*1.1, center=true);
        
        //center hole
        rotate([0,90,0]) cylinder(d=hole, h=depth*1.1, center=true);
        //center hole cutout
        translate([0,0,-height/2]) cube([depth*1.1, guidehole, height/2], center=true); 
    }
}

ballnutMount();