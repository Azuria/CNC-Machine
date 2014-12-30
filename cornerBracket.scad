//Frode Lillerud, 08.des.2014

module cornerBracket(height=20, width=20, depth=(2*25.4),screwdiameter=6) {
    //color("lightgrey") 
    difference() {
        translate([0, depth/2, 0])
        rotate([90, 0, 0])
        linear_extrude(height=depth, convexity=2)
        difference() {
            polygon(
                points = [
                    [0,0],[width,0], [width,1], [1, height], [0,height]
                ],
                paths = [
                    [0,1,2,3,4]
                ]);
            polygon(
            points = [
                [3,3], [width-5, 3], [3, height-5]
            ],
            paths = [
                [0,1,2]
        ]);
        }
        union() {
            //The four screwholes
            translate([width/1.5, depth/4, -1]) cylinder(height*2, r=screwdiameter, $fn=20);
            mirror([0,1,0]) translate([width/1.5, depth/4, -1]) cylinder(height*2, r=screwdiameter, $fn=20);
            translate([-1, depth/4, width/1.5]) rotate([0, 90, 0]) cylinder(height*2, r=screwdiameter, $fn=20);
            mirror([0,1,0]) translate([-1, depth/4, width/1.5]) rotate([0, 90, 0]) cylinder(height*2, r=screwdiameter, $fn=20);
        }
        //!linear_extrude(height=depth)
        
    }
}

cornerBracket();