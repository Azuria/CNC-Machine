/*
 * Generic modules for manipulating objects
 */

module mirror_copy(vec=[0,1,0]) { 
    children(); 
    mirror(vec) children(); 
}