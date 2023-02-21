include <Round-Anything/polyround.scad>
include <model_1602_display.scad>
include <display01.scad>
include <load_cell_assy.scad>
include <main_PCB.scad>
include <battery_pack.scad>


$fn=80;


RT2 = sqrt(2);
PLATE_RD = 120/2;
SIDE_HT= 40;
SIDE_ANG = 40;
FACE_WD=90;
BASE_RING_HT = 12;

top_base_rd = PLATE_RD * 1.2;
bot_base_rd = top_base_rd +20;

module main_cone(){

    translate([0,0,-38]){
        cylinder(h = 40, r2 = top_base_rd, r1 = bot_base_rd);
    }  

}


module countersink_cone(ht){
    cylinder(h = ht, r1 = 0.01 , r2= ht, center=true);
}

// countersink_cone(5);

MOUNT_CUP_EDGE_RD = 4;
MOUNT_CUP_TN = 3;
MOUNT_CUP_CLEARANCE = 6;
MOUNT_CUP_HT_COEFF = 2.4;

mnt_cup_outer_rd = PLATE_RD + 
                    MOUNT_CUP_EDGE_RD*2 + 
                    MOUNT_CUP_TN + 
                    MOUNT_CUP_CLEARANCE;
mnt_cup_inner_rd = PLATE_RD + 
                    MOUNT_CUP_EDGE_RD*2 
                    + MOUNT_CUP_CLEARANCE;
mnt_cup_ht = BASE_RING_HT * MOUNT_CUP_HT_COEFF;


mount_cup_pts = [
    [0,0,0],
    [mnt_cup_outer_rd, 0, MOUNT_CUP_EDGE_RD],
    [mnt_cup_outer_rd, mnt_cup_ht, 0],
    [mnt_cup_inner_rd + MOUNT_CUP_TN/2, mnt_cup_ht, 0],
    [mnt_cup_inner_rd, MOUNT_CUP_TN, MOUNT_CUP_EDGE_RD - MOUNT_CUP_TN],
    [0, MOUNT_CUP_TN,0]
];

module mount_cup(){
    difference(){
        rotate_extrude(angle=360) {
            polygon(polyRound(mount_cup_pts,60));
        }
        cylinder(h = 10, r = 4/2);
        translate([0, 0, -0.1]){
            cylinder(h = 3.5, r1 = 9/2, r2 = 3.5/2);
        }
    }


    // for (spike_ang = [0,120,240]){
    //     rotate([0,0,spike_ang]){
    //         translate([30,0,0]){
    //             cylinder(h=10,r1=5,r2=3);
    //         } 
    //     } 
    // }
    

}



//####################################################################
//############# BOTTOM BASE CUP         ######################



bot_cup_outer_rd = bot_base_rd - 4;
bot_cup_inner_rd = bot_base_rd - 7;

bot_cup_pts = [
    [0,0,0],
    [bot_cup_outer_rd, 0, MOUNT_CUP_EDGE_RD],
    [bot_cup_outer_rd, mnt_cup_ht, 0],
    [bot_cup_inner_rd + MOUNT_CUP_TN/2, mnt_cup_ht, 0],
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
bottom_base_cup();



// Main PCB model !!! NOT PRINTED !!!
translate([25, 0, -35]){
    rotate([0, 0, 90]){
        main_PCB();
    }
}

// Battery Pack model !!! NOT PRINTED !!!
translate([-30, 50, -35]){
    rotate([90, 90, 0]){
        battery_pack();
    }
}
translate([-30, -58, -35]){
    cube([5, 35, 5], center=true);
}




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
TOP_BASE_TN = 3;
CELL_PLATE_RD = 103/2;
inner_ring_rd = top_base_rd /3;

module top_base_ring(){
    translate([0,0,5]){
        // outer ring and floor
        difference(){
            cylinder(r = top_base_rd, h = BASE_RING_HT);
            // form the outer ring and floor
            translate([0,0,TOP_BASE_TN]){
                cylinder(r = top_base_rd - 3, h=BASE_RING_HT);
            }
            // cable hole
            rotate([0, 0, 60]){ // choosing the most convenient place
                translate([0,40,-5]){
                    cylinder(r = 15/2, h=BASE_RING_HT);
                }
            }

        }

        difference(){
            union(){
                // inner ring
                difference(){
                    cylinder(r = inner_ring_rd, h = BASE_RING_HT);
                    
                    cylinder(r = inner_ring_rd - 3, h=BASE_RING_HT * 1.1);
        
                }
        
                // radial struts
                out_in_diff = top_base_rd - inner_ring_rd;
                for (ang = [0:60:360]){
                    rotate([0, 0, ang]){
                        translate([out_in_diff, 0, BASE_RING_HT/2]){
                            cube([out_in_diff ,3 ,BASE_RING_HT ], center=true);
                        }
                    }
                }
            }
            // Cradle for the load cell plate
            translate([17.5, 0, BASE_RING_HT - 4]){
                cylinder(h = BASE_RING_HT, r = CELL_PLATE_RD);
            }

        }


    }
}



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

// bottom_base_ring();

bollard_angles = [ 70, // these two
                  120, // are around the display
                  5,
                  185,
                  235,
                  310
                  ];
//########################################################################
// Main bottom body
module main_bottom_body(){
    difference(){
        union(){
            difference() {
                union(){
                    main_cone();
                    
                    // base ring
                    translate([0,0,-48]){
                        cylinder(h=10, r=bot_base_rd);
                    }

                    translate([80, 0, -48]){
                        display_box();
                    }
                    
                }

                

                // scale([0.97,0.97,1.05]){
                //     main_cone();
                // }
                // negative main cone
                translate([0,0,-39]){
                    cylinder(h = 42, r2 = top_base_rd -4, r1 = bot_base_rd -1.5);
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


                // translate([0,0,-3]){
                //     scale([1.01,1.01,1]){
                //         top_base_ring();
                //     }
                // }
            }

            // bollards
            for (this_ang = bollard_angles){
                rotate([0,0,this_ang - 90]){
                    screw_bollard();
                }
            }
        }

        translate([80, 0, -48]){
            brass_bush_holes(3.2/2);
            brass_bush_holes_placement(1){
                rotate([180, 0, 0]){
                    countersink_cone(5);
                }
            }

        }
        

        // Display wire hole
        translate([58, -38, -30]){
            rotate([0, 60, -35]){
                cylinder(h = 20, r = 12.5/2);
            }
        }

        // shave the bottom off the bollards for printability
        translate([0,0,-58]){
            cube([200,200,20],center=true);
        } 

        // // DEV CROSS SECTION
        // translate([0,-77,0]){
        //     rotate([0,0,90]){
        //         cube([150,250,150], center=true);
        //     } 
        // } 

    }
}
main_bottom_body();
//###############################################################################



// translate([0,PLATE_RD * 1.38,-20]){
//     rotate([118,0,0]){
//         display_screw_bollards();
//     }
// }


// // DISPLAY MODEL !!! NOT PRINTED !!!
// translate([-0.4,73,-24.8]){ 
//     rotate([62,0,180]){
//         display_model_1602();
//     }
// }








// the stuff on top
// union(){
//     // color("red",0.2){
//          top_base_ring();
//     // }

//     translate([19, 0, 25]){
//         rotate([0, 0, 180]){
//             load_cell_assy();
//         }
//     }

//     // mount plate
//     color("red",0.3){
        
//     translate([0,0,39]){
//         rotate([0,180,0]){
//             intersection(){
//                 mount_cup();
//                 //cube([50,25 ,50 ], center=true);
//             }
//         }
//     }
    

//     }

//     translate([-60, 0, 36]){
//         cube([35.5/2, 5 , 2], center=true);
//     }
//     translate([60, 0, 36]){
//         cube([35.5/2, 5, 2], center=true);
//     }
// }


PLATEHOLDER_HT = 5;
PLATEHR_TN = 2.5;

platehdr_otr_rd = PLATE_RD + 10;


// // plate holder
// translate([0, 0, 80]){
//     difference() {
//         // main positive block
//         cylinder(h = PLATEHOLDER_HT, r = platehdr_otr_rd);
//         // create outer phlange
//         translate([0, 0, PLATEHR_TN]){
//             difference() {
//                 cylinder(h = PLATEHOLDER_HT , r = platehdr_otr_rd+1);
//                 translate([0, 0, -1]){
//                     cylinder(h = PLATEHOLDER_HT * 1.4, r = PLATE_RD + PLATEHR_TN );
//                 }
        
//             }
//         }
//         // create upper lip
//         translate([0, 0, -(PLATEHOLDER_HT-(AL_PLATE_TN+0.5))]){
//             cylinder(h = PLATEHOLDER_HT, r = PLATE_RD+1);
//         }
//         // remove centre
//         translate([0, 0, 1]){
//             cylinder(h = PLATEHOLDER_HT, r = PLATE_RD - 8);
//         }

//         // only want a small bit of the round
//         translate([-100, -30, -1]){
//             cube([200, 200, 10], center=false);
//         }
//     }
    
    
    
// }




