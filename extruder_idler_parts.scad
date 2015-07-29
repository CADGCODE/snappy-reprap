include <config.scad>
use <GDMUtils.scad>
use <NEMA.scad>
use <joiners.scad>


$fa=1;
$fs=1;

width = extruder_shaft_len/2;
thick = 3;
topthick = 4;
motor_width = nema_motor_width(17);
frontside = (10+jhead_barrel_diam+8)/2+5;
backside = (jhead_barrel_diam+8)/2+8;
topside = motor_width*0.25+topthick;
botside = motor_width/2;



module extruder_idler()
{
	color("Tan")
	prerender(convexity=10)
	difference() {
		union() {
			// Top bar
			up(topside-topthick/2) {
				back((frontside+backside)/2-frontside) {
					cube([width, frontside+backside, topthick], center=true);
				}
			}

			// Vertical bar
			back(backside-thick/2) {
				up((topside+botside)/2-botside) {
					cube([width, thick, topside+botside], center=true);
				}
			}

			// bearing supports
			back((backside-extruder_idler_diam/2+extruder_idler_axle/3)/2+(extruder_idler_diam/2-extruder_idler_axle/3)) {
				up(topside/4) {
					cube([width, backside-extruder_idler_diam/2+extruder_idler_axle/3+0.05, extruder_idler_diam*2/3/2+topside], center=true);
				}
			}
		}

		// Filament hole
		cylinder(d=filament_diam*2, h=100, $fn=12);

		// spring/rubber-band mount hole
		fwd(frontside-4) {
			cube([width-4, 6, 100], center=true);
		}

		// Clearance for idler bearing
		back(extruder_idler_diam/2) {
			yrot(90) cylinder(d=extruder_idler_axle, h=extruder_idler_width+10, center=true);
			yrot(90) cylinder(d=extruder_idler_diam+2, h=extruder_idler_width, center=true);
			difference() {
				yrot(90) cylinder(d=extruder_idler_diam+2, h=extruder_idler_width+1, center=true);
				yrot(90) cylinder(d=extruder_idler_axle+4, h=extruder_idler_width+1.1, center=true);
			}
		}

		// Bottom clip
		back(backside-2/2) {
			down(botside-2.5/2) {
				up(2.5) {
					back(2/2) cube([width+0.1, min(2*2,thick), 2.5], center=true);
				}
				xspread(width-2) {
					up(2.5/2) cube([2.1, thick*2.1, 5.05], center=true);
				}
			}
		}
	}
}
//!extruder_idler();


module idler_bearing()
{
	difference() {
		union() {
			color("silver") {
				difference() {
					yrot(90) cylinder(d=extruder_idler_diam, h=extruder_idler_width, center=true);
					yrot(90) cylinder(d=extruder_idler_diam-2, h=extruder_idler_width+1, center=true);
				}
			}
			color("darkgray") {
				yrot(90) cylinder(d=extruder_idler_diam-0.5, h=extruder_idler_width-0.5, center=true);
			}
			color("silver") {
				yrot(90) cylinder(d=extruder_idler_axle+2, h=extruder_idler_width, center=true);
			}
		}
		color("silver") {
			yrot(90) cylinder(d=extruder_idler_axle, h=extruder_idler_width+10, center=true);
		}
	}
}
//!idler_bearing();


module extruder_idler_axle() {
	color("Tan") {
		cylinder(h=1, d=extruder_idler_axle+2);
		up(1-0.05) {
			difference() {
				cylinder(h=width+0.05, d=extruder_idler_axle);
				up(width/2) {
					cylinder(h=width+0.1, d=extruder_idler_axle-3);
				}
				cylinder(h=width+2, d=2);
			}
		}
	}
}
//!extruder_idler_axle();



module extruder_idler_axle_cap() {
	color("Tan") {
		cylinder(h=1, d=extruder_idler_axle+2);
		up(1-0.1) cylinder(h=width/2, d=extruder_idler_axle-3);
	}
}
//!extruder_idler_axle_cap();



module extruder_idler_parts() { // make me
	up(backside) {
		xrot(-90) extruder_idler();
	}
	left(20) extruder_idler_axle();
	right(20) extruder_idler_axle_cap();
}



extruder_idler_parts();


// vim: noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
