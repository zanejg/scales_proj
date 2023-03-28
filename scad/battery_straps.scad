

include <battery_pack.scad>


STRAP_WD = 12;
STRAP_TN = 3;
TAB_DIST = 20;

module inner_cavity(){
    scale([1.02, 1.0, 1]){
        battery_pack();
    }
}


module battery_strap(){
    translate([0.6, 7, -36]){
        intersection(){
            difference(){
                scale([1.15,1.15,1]){
                    inner_cavity();
                }
                translate([-0.5, -1, 0]){
                    inner_cavity();
                }
            }
            translate([17, 0, 38]){
                cube([30, 60 , STRAP_WD], center=true);
            }
        }
        
    }

    // screw tabs
    translate([3.5, TAB_DIST, 2]){
        difference(){
            cube([STRAP_TN, 10, STRAP_WD], center=true);
            translate([0, -0.5, 0]){
                rotate([0, 90, 0]){
                    translate([0, 0, -3]){
                        cylinder(h = 8, r = 3.1/2);
                    }
                    translate([0, 0, -1.5]){
                        cylinder(h = 4, r1 = 0.01,r2=4);
                    }
                }
            }
        }
    }
    translate([3.5, -TAB_DIST, 2]){
        difference(){
            cube([STRAP_TN, 10, STRAP_WD], center=true);
            translate([0, -0.5, 0]){
                rotate([0, 90, 0]){
                    translate([0, 0, -3]){
                        cylinder(h = 8, r = 3.1/2);
                    }
                    translate([0, 0, -1.5]){
                        cylinder(h = 4, r1 = 0.01,r2=4);
                    }
                }
            }
        }
    }
}

// battery_strap();