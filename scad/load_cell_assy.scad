
//$fn=50;

AL_PLATE_RD = 103/2;
AL_PLATE_TN = 1.8;

module plate(){
    difference(){
        cylinder(h = AL_PLATE_TN, r = AL_PLATE_RD);

        // offset screwhole as per manufacturer
        translate([AL_PLATE_RD -30 , 0, -0.2]){
            cylinder(h = AL_PLATE_TN * 2, r = 4/2);
        }
        // centered screwhole
        translate([0, 0, -0.2]){
            cylinder(h = AL_PLATE_TN * 2, r = 4/2);
        }
        
    }
}

// load cell

module load_cell_bar(){
    CELLHOLE_OS = 3.5;
    BAR_LN = 80;
    BAR_HT = 12.5;
    BAR_WD = 12.5;

    difference() {
        cube([BAR_LN, BAR_WD, BAR_HT], center=true);
        // big holes thru bar
        translate([-CELLHOLE_OS, 8, 0]){
            rotate([90, 0, 0]){
                cylinder(h = 20, r = 10/2);
            }
        }
        translate([CELLHOLE_OS, 8, 0]){
            rotate([90, 0, 0]){
                cylinder(h = 20, r = 10/2);
            }
        }

        // screwholes
        translate([BAR_LN/2 -5, 0, -8]){
            cylinder(h = 15, r = 4/2);
        }
        translate([-BAR_LN/2 +5, 0, -8]){
            cylinder(h = 15, r = 4/2);
        }

        translate([BAR_LN/2 - 20, 0, -8]){
            cylinder(h = 15, r = 4/2);
        }
        translate([-BAR_LN/2 +20, 0, -8]){
            cylinder(h = 15, r = 4/2);
        }

    }


    // THE WIRES
    wire_defs = [
        [-1.5,"black"],
        [-0.5,"red"],
        [0.5,"white"],
        [1.5,"green"],
    ];

    for (wire_def = wire_defs){
        color(wire_def[1],1.0){
            translate([10, -86.5, wire_def[0]]){
                rotate([0, 0, -30]){
                    rotate_extrude(angle =120){
                        translate([80, 0, 0]){
                            circle(r = 0.8/2);
                        }
                    }
                }
            }
        }
    }
    // the glue/gunge... ish
    color("yellow",1.0)
    translate([14, -5.5, 0]){
        rotate([90, 0, 0]){
            cylinder(h = 1.5, r = 5);
        }
    }
}

module spacer(){
    difference() {
        cube([8,8 ,3 ], center=true);
        translate([0, 0, -2]){
            cylinder(h = 6, r = 4/2);
        }

    }
}



module load_cell_assy(){
    translate([20, 0, 9]){
        plate();
    }

    rotate([0, 0, 180]){
        translate([-1.5 , 0, -10.8]){
            plate();
        }
    }

    translate([20, 0, 7.5]){
        spacer();
    }
    translate([-20, 0, -7.5]){
        spacer();
    }
    load_cell_bar();
}

// load_cell_assy();