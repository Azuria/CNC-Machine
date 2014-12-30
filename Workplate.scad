//Frode Lillerud, 29.nov 2014.

module workarea(length=400, width=200) {
    //color("grey")
    difference() {
        cube([length, width, 10], center=true);
        
        //1" x 1" M3 holepattern
        for (x = [-length/2*.95:25.4:length/2*.95])
        {
            for (y = [-width/2*.95:25.4:width/2*.95])
            {
                translate([x,y,-5])
                    cylinder(r=1.5,h=20, $fn=5);
            }
        }
    }
}

workarea();