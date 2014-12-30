/*
 * Generic modules for manipulating objects
 */

module mirror_copy(vec=[0,1,0]) { 
    children(); 
    mirror(vec) children(); 
}

module move(x=0, y=0, z=0) {
    translate([x, y, z]) children();
}