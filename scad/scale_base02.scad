include <Round-Anything/polyround.scad>
include <model_1602_display.scad>

$fn=80;

RT2 = sqrt(2);
PLATE_RD = 120/2;
SIDE_HT= 40;
SIDE_ANG = 40;
FACE_WD=90;
BASE_RING_HT = 10;

top_base_rd = PLATE_RD * 1.2;
bot_base_rd = top_base_rd +20;

module main_cone(){

    translate([0,0,-38]){
        cylinder(h = 40, r2 = top_base_rd, r1 = bot_base_rd);
    }  

}


module display_screw_bollards(){
    // 68 X 28
    BOLLARD_RD = 3;
    for (posi = screwhole_coords){
        translate([posi[0], posi[1], 0]){
            difference(){
                cylinder(h = 10, r = BOLLARD_RD);
                
                translate([0,0,2.1]){
                    cylinder(h = 8, r = 3/2);
                }
            }
        }
    }
}
//display_screw_bollards();


module display_face(neg){
    translate([0,PLATE_RD * 1.25,-25]){
        rotate([28,0,0]){
            union(){
                difference(){
                    hull(){
                        hull(){
                            cube([FACE_WD, 20, 34],center=true);
                            // translate([0,-5,-19]){
                            //     cube([FACE_WD * 0.8, 1, 1],center=true);
                            // }

                            translate([0,-bot_base_rd,-27]){ 
                                rotate([0,0,90-SPAN_ANGLE/2]){
                                    rotate_extrude(angle = SPAN_ANGLE){
                                        translate([bot_base_rd,0,0]) {
                                            circle(r = 1);
                                        }
                                    }
                                }
                            }
                        }
                        SPAN_ANGLE = 45;
                        translate([0,-top_base_rd * 1.1,36]){ 
                            rotate([0,0,90-SPAN_ANGLE/2]){
                                rotate_extrude(angle = SPAN_ANGLE){
                                    translate([top_base_rd,0,0]) {
                                        circle(r = 1);
                                    }
                                }
                            }
                        }
                    }
                    // display hole
                    if (neg != true){
                        translate([0,6.5,0]){
                            cube([DISPLAY_WD,8,DISPLAY_HT], center=true);
                        }
                    }
                }
                // display hole
                if (neg == true){
                    translate([0,8,-0.4]){
                        cube([DISPLAY_WD,8,DISPLAY_HT * 1.07], center=true);
                    }
                }
                
            }
        }
    }
}

MOUNT_CUP_EDGE_RD = 4;
MOUNT_CUP_TN = 3;
MOUNT_CUP_CLEARANCE = 4;

mnt_cup_outer_rd = PLATE_RD + 
                    MOUNT_CUP_EDGE_RD*2 + 
                    MOUNT_CUP_TN + 
                    MOUNT_CUP_CLEARANCE;
mnt_cup_inner_rd = PLATE_RD + 
                    MOUNT_CUP_EDGE_RD*2 
                    + MOUNT_CUP_CLEARANCE;

mount_cup_pts = [
    [0,0,0],
    [mnt_cup_outer_rd, 0, MOUNT_CUP_EDGE_RD],
    [mnt_cup_outer_rd, BASE_RING_HT * 1.5, 0],
    [mnt_cup_inner_rd + MOUNT_CUP_TN/2, BASE_RING_HT * 1.5, 0],
    [mnt_cup_inner_rd, MOUNT_CUP_TN, MOUNT_CUP_EDGE_RD - MOUNT_CUP_TN],
    [0, MOUNT_CUP_TN,0]
];

module mount_cup(){
    rotate_extrude(angle=360) {
        polygon(polyRound(mount_cup_pts,60));
    }
    
    for (spike_ang = [0,120,240]){
        rotate([0,0,spike_ang]){
            translate([30,0,0]){
                cylinder(h=10,r1=5,r2=3);
            } 
        } 
    }

    


}

bot_cup_outer_rd = bot_base_rd - 4;
bot_cup_inner_rd = bot_base_rd - 7;

bot_cup_pts = [
    [0,0,0],
    [bot_cup_outer_rd, 0, MOUNT_CUP_EDGE_RD],
    [bot_cup_outer_rd, BASE_RING_HT * 1.5, 0],
    [bot_cup_inner_rd + MOUNT_CUP_TN/2, BASE_RING_HT * 1.5, 0],
    [bot_cup_inner_rd, MOUNT_CUP_TN, MOUNT_CUP_EDGE_RD - MOUNT_CUP_TN],
    [0, MOUNT_CUP_TN,0]
];

module bottom_base_cup(){
    translate([0,0,-51]){
        rotate([0,0,0]){
            rotate_extrude(angle=360) {
                polygon(polyRound(bot_cup_pts,60));
            }
        } 
    } 
}
//bottom_base_cup();

module screw_bollard(){
    shape_pts = [
        [0,0],
        [10,0],
        [10,10],
        [12,25],
        [-1.7,49],
        [-12,49],
        [0,25]
    ];

    translate([PLATE_RD*1.2,0,-50]){
        rotate([90,0,0]){
            linear_extrude(height = 10){
                polygon(points = shape_pts);
            }
        }
    }

}

//############################################################################
// base ring
module top_base_ring(){
    translate([0,0,2]){
        difference(){
            cylinder(h = BASE_RING_HT, r = top_base_rd);
            translate([0,0,5.5]){
                cylinder(r=PLATE_RD * 1.02,h=BASE_RING_HT/2);
            }
        }
    }
}

//top_base_ring();


module bottom_base_ring(){
    translate([0,0,-48]){
        difference(){
            cylinder(h=10, r=bot_base_rd);
            translate([0,0,-1]){ 
                cylinder(h=12, r=bot_base_rd-3);
            }
        }
    }
}

//bottom_base_ring();

bollard_angles = [ 45, // these two
                  135, // are around the display
                  5,
                  185,
                  235,
                  310
                  ];
//########################################################################
// Main bottom body
difference(){
    union(){
        difference() {
            union(){
                main_cone();
                display_face(false);
                // base ring
                translate([0,0,-48]){
                    cylinder(h=10, r=bot_base_rd);
                }
                
            }

            // scale([0.97,0.97,1.05]){
            //     main_cone();
            // }
            // negative main cone
            translate([0,0,-39]){
                cylinder(h = 42, r2 = top_base_rd -4, r1 = bot_base_rd -1.5);
            }

            translate([0,1,-2]){
                scale([0.97,0.97,0.92]){
                    display_face(true);
                }
            }
            // // get rid of the gunge below the cone
            // #translate([0,PLATE_RD * 1.23-10,-40]){
            //     cube([FACE_WD * 1, 10, 18],center=true);
            // }

            // negative base ring
            translate([0,0,-48]){
                translate([0,0,-1]){ 
                    cylinder(h=12, r=bot_base_rd-3);
                }
            }


            translate([0,0,-3]){
                scale([1.01,1.01,1]){
                    top_base_ring();
                }
            }
        }

        // bollards
        for (this_ang = bollard_angles){
            rotate([0,0,this_ang]){
                screw_bollard();
            }
        }
    }
    // shave the bottom off the bollards for printability
    translate([0,0,-58]){
        cube([200,200,20],center=true);
    } 

    // DEV CROSS SECTION
    translate([0,-77,0]){
        rotate([0,0,90]){
            cube([150,250,150], center=true);
        } 
    } 

}
// // mount plate
// translate([0,0,15]){
//     rotate([0,180,0]){
//         mount_cup();
//     }
// } 


translate([0,PLATE_RD * 1.38,-20]){
    rotate([118,0,0]){
        display_screw_bollards();
    }
}


// DISPLAY MODEL !!! NOT PRINTED !!!
translate([-0.4,73,-24.8]){ 
    rotate([62,0,180]){
        display_model_1602();
    }
}


