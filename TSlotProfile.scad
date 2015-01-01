//T-slots from 8020
//By Frode Lillerud
$fn=32;
module warning(message) {
	echo(str("<span style='background-color: yellow;'>WARNING: " , message, "</span>"));
}

module TSlotProfile(series = 20, profile=2020, length=100) {
	//echo(str("series = ", series));
	if (series == 20) {
		if (profile == 2020) 20_2020(length);
	 	if (profile == 2040) 20_2040(length);
	}
	else if (series == 25) {
	}
		
	else if (series == 30) {
		if (profile == 3030) 30_3030(length);
		if (profile == 3060) 30_3060(length);
	}
	else {
		warning(str("Unknown series: ", series));
	}
}

// 30-series

module 30_3030Profile($fn=32) {
	radius = 1;
	//#translate([0,0,-10]) square([30,30], center=true);
	difference() {
		hull() {
			for (i = [0:360/4: 359]) 
				rotate(i) translate([30/2, 30/2, 0]) circle(radius);
		}
		for (i = [0:360/4: 359]) 
			rotate(i) translate([0,11.67/2,0]) 30seriesTslot();
		
		circle(3);
		rotate(45) roundedSquare(7, .8);
		rotate(-45) roundedSquare(7, .8);
	}	
}

module 30seriesTslot() {
	translate([0,0,0]) hull() {
		translate([0,6.8-1.5,0]) square([16.5, 2], center=true);
		square([8.13, .001], center=true);
	}
	translate([0,7,0]) square([8.13, 10], center=true);
	translate([0,.3,0]) rotate(45) square(1, center=true);
}

module 30_3060Profile() {
	square([30, 60], center=true);
}

module profile2D(x, y) {
	
	/*difference() {
		minkowski() {
			square([x-1,y-1], center=true);
			circle(1);
		}
		for (a = [0 : 360/4: 359])
			rotate(a) translate([4.3,0,0]) tslot();
		centerhole();
	}
	*/
	difference() {
		union() {
			square(4, center=true);
			for (a = [0 : 360/4: 359])
			{
				rotate(a+45) translate([4.3,0,0]) armB();
				mirror() rotate(a+45) translate([4.3,0,0]) armB();
			}
		}
		centerhole();
	}
}



module tslot(maxwidth=7.31, minwidth=5.26) {
	minkowski() {
		union() {
			hull() {
				square([1,minwidth-4], center=true);
				translate([8, 0, 0]) square([1,maxwidth+2], center=true);
			}
			translate([8,0,0]) square([minwidth-2,minwidth-2], center=true);
		
		}
		circle(.3);
	}
}

module arm(length=6) {
	//offset(r=-.1) {
	union() {
		//square([7, 1], center=true);
		roundedSquare(length);
		translate([length/2-1,length/5,0]) rotate(-45) roundedSquare(3);
		//translate([3, -.5, 0]) square([1,1]);
	//}
	circle(.3);
	}
}

module armB(length=5) {
	roundedSquare(length, .6);
	translate([length/2,0,0]) rotate(45) translate([1,0,0]) roundedSquare(length/3, .6);
	translate([length, 0,0]) rotate(135) translate([length/2, 0,0]) roundedSquare(length, .6);

}

module roundedSquare(length, width=.5) {
		hull(){
		translate([-length/2,0,0]) circle(width);
		translate([length/2,0,0]) circle(width);
	}
}

module centerhole(length=100) {
	circle(1.5);
	for (a = [0: 360/4: 359])
		rotate(a+45) translate([2,0,0]) circle(.5);
}

/*module fillet(rad){
	translate([-rad,-rad,0])
	difference(){
		//translate([0,0,0]) square([rad+0.01,rad+0.01]);
                translate([0,0,0]) square([rad,rad]);
		circle(r=rad,center=true,$fn=32);
	}
}*/

module 20_2020(length) {
	echo("BOM: 20_2020");
	linear_extrude(height=length, center=true) profile2D(20, 20);
}

module 20_2040(length) {
	linear_extrude(height=length, center=true) profile2D(20, 40);
}

module 30_3030(length) {
	echo("BOM: 30-3030");
	linear_extrude(height=length, center=true) 30_3030Profile();
}

module 30_3060(length) {
	linear_extrude(height=length, center=true) 30_3060Profile();
}

TSlotProfile(series = 20, profile = 2020, length=10);
translate([30,0,0]) TSlotProfile(series = 30, profile = 3030, length=10);
translate([70,0,0]) TSlotProfile(series = 30, profile = 3060, length = 10);

