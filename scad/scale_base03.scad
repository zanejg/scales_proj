include <Round-Anything/polyround.scad>
include <model_1602_display.scad>
include <display01.scad>
include <load_cell_assy.scad>
include <main_PCB.scad>
include <battery_pack.scad>
include <battery_straps.scad>

$fn=80;


RT2 = sqrt(2);
PLATE_RD = 120/2;
SIDE_HT= 40;
SIDE_ANG = 40;
FACE_WD=90;
BASE_RING_HT = 12;
CELL_PLATE_RD = 103/2;

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


mount_ring_inner_rd = CELL_PLATE_RD * 1.03 -2;
mount_ring_outer_rd = mount_ring_inner_rd + 4;
module mount_cup(){

    rotate_extrude(angle=360) {
        polygon(polyRound(mount_cup_pts,60));
    }

    // mounting ring
    translate([0, 5, MOUNT_CUP_TN * 0.99]){
        difference(){
            cylinder(h = 14, r = mount_ring_outer_rd);
            cylinder(h = 15, r = mount_ring_inner_rd);
            translate([0, -mount_ring_inner_rd, MOUNT_CUP_TN + 6]){
                cube([14, 10, 14], center=true);
            }
        }
        difference(){
            cylinder(h = 3, r = mount_ring_inner_rd);
            cylinder(h = 4, r = mount_ring_inner_rd-6);
            
        }

    }
    

}
intersection() {
    !mount_cup();
    translate([0, 5, 0]){
        difference(){
            cylinder(h = 20, r = mount_ring_outer_rd-2);
            #translate([0, 0, -0.1]){
                cylinder(h = 11, r = mount_ring_inner_rd-4);
            }
        }
    }
}


//####################################################################
//############# BOTTOM BASE CUP         ######################



bot_cup_outer_rd = bot_base_rd - 4;
bot_cup_inner_rd = bot_base_rd - 7;
bot_cup_ht = BASE_RING_HT ;

bot_cup_pts = [
    [0,0,0],
    [bot_cup_outer_rd, 0, MOUNT_CUP_EDGE_RD],
    [bot_cup_outer_rd, bot_cup_ht, 0],
    [bot_cup_inner_rd + MOUNT_CUP_TN/2, bot_cup_ht, 0],
    [bot_cup_inner_rd, MOUNT_CUP_TN, MOUNT_CUP_EDGE_RD - MOUNT_CUP_TN],
    [0, MOUNT_CUP_TN,0]
];

module PCB_mount_bollards(){
    difference() {
        cylinder(h = 10, r = 7/2);
        cylinder(h = 11, r = 2/2);
    }
}
bollard_angles = [ 70, // these two
                  120, // are around the display
                  5,  
                  185,
                  235,
                  310
                  ];


module bottom_base_cup(){
    // main cup
    difference(){
        translate([0,0,-51]){
            rotate([0,0,0]){
                rotate_extrude(angle=360) {
                    polygon(polyRound(bot_cup_pts,60));
                }
            } 
        }
        // base screwholes
        for (this_ang = bollard_angles){
            rotate([0,0,this_ang - 90]){
                translate([(PLATE_RD*1.2) + 5, -5,-52]){
                    cylinder(h = 12, r = 3/2);
                    translate([0, 0, 2.8]){
                        rotate([180, 0,0]){
                            countersink_cone(ht = 5);
                        }
                    }
                }
            }
        }

    }
    // battery cradle
    difference(){
        translate([-36, 0, -42]){
            cube([50, 60, 12], center=true);
        }
        // subtract the batt pack for the cradle
        translate([-30, 50, -35]){
            rotate([90, 90, 0]){
                scale([1.02, 1, 1]){
                    battery_pack();
                    //cube([15,90 ,15 ], center=true);
                }
            }
        }
        translate([-36, 0, -42]){
            cube([60, 40, 15], center=true);
        }

        // screwholes
        BATT_SCREW_Y = -45;
        translate([-16.5, -25, BATT_SCREW_Y]){
            cylinder(h = 10, r = 2.4/2);
        }
        translate([-56.5, -25, BATT_SCREW_Y]){
            cylinder(h = 10, r = 2.4/2);
        }
        translate([-16.5, 25, BATT_SCREW_Y]){
            cylinder(h = 10, r = 2.4/2);
        }
        translate([-56.5, 25, BATT_SCREW_Y]){
            cylinder(h = 10, r = 2.4/2);
        }

    }

    // PCB mount bollards
    translate([25, 0, -48]){
        rotate([0, 0, 90]){
            place_PCB_screwholes(){
                PCB_mount_bollards();
            }
        }
    }

    



}


// // difference(){
//     bottom_base_cup();
// //     translate([0, -100, -40]){
// //         cube([200,100 ,40 ], center=true);
// //     }
// // }

// translate([-36, -27, -38]){
//     rotate([0, -90, -90]){
//         battery_strap();
//     }
// }



// intersection(){
    
//     #translate([-35, 25, -45]){
//         cube([50, 5, 20], center=true);
//     }
// }
    



// // Main PCB model !!! NOT PRINTED !!!
// translate([25, 0, -37]){
//     rotate([0, 0, 90]){
//         main_PCB();
//     }
// }

// // Battery Pack model !!! NOT PRINTED !!!
// translate([-30, 50, -35.2]){
//     rotate([90, 90, 0]){
//         #battery_pack();
//     }
// }
// // measuring plug clearance
// // translate([-30, -58, -35]){
// //     cube([5, 35, 5], center=true);
// // }




module screw_bollard(){
    shape_pts = [
        [0,0],
        [10,0],
        [10,10],
        [12,25],
        [-1.7,49],
        [-12,49],
        [-12,39],
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

            // screwholes
            for(angb = bollard_angles){
                rotate([0, 0, angb  -90]){
                    translate([top_base_rd - 7, -5 , 0]){
                        cylinder(h = 8, r = 3.1/2);

                        translate([0, 0, 1.3]){
                            countersink_cone(ht = 3.7);
                        }
                    }

                    
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
                // screwhole bollards for plate holding
                rotate([0, 0, 60]){
                    translate([top_base_rd -7 , 0, 0]){
                        cylinder(h = BASE_RING_HT, r = 8/2);
                    }
                }
                rotate([0, 0, -60]){
                    translate([top_base_rd -7 , 0, 0]){
                        cylinder(h = BASE_RING_HT, r = 8/2);
                    }
                }
            }
            // Cradle for the load cell plate
            translate([17.5, 0, BASE_RING_HT - 4]){
                cylinder(h = BASE_RING_HT, r = CELL_PLATE_RD);
            }
            // screwholes for plate holding
            rotate([0, 0, 60]){
                translate([top_base_rd -7 , 0, 3]){
                    cylinder(h = BASE_RING_HT, r = 2.5/2);
                }
            }
            rotate([0, 0, -60]){
                translate([top_base_rd -7 , 0, 3]){
                    cylinder(h = BASE_RING_HT, r = 2.5/2);
                }
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

CHARGER_HOLE_RD = 2.9/2;
CHARGER_HOLE_WD = 8;
CHARGER_HLDR_SCREW_DIST = 8.5;
CHARGER_HLDR_SCREW_SIDE_OS = -2.5;
CHARGER_HLDR_SCREW_RD = 3/2;

module charger_hole(){
    // to define the hole through the main cone for the
    // micro USB charger plug

    
    chgr_hull_os = CHARGER_HOLE_WD - (2*CHARGER_HOLE_RD);

    translate([0, -1.6, 0]){
        hull() {
            cylinder(h = 10, r = CHARGER_HOLE_RD);
            translate([chgr_hull_os, 0, 0]){
                cylinder(h = 10, r = CHARGER_HOLE_RD);
            }
        }
    }
    translate([2.2, 0.55, 3]){
        cube([14, 1.8, 3], center=true);
    }
}
//charger_hole();



/// Done test print
module charger_socket_holder(){
    
    translate([-80, CHARGER_HOLE_RD * 2, -22.5]){
        rotate([0, -60, 0]){
            translate([0, 0.05, -5]){
                difference(){
                    cube([15, 3, 15], center=true);
                    translate([0, 0, 0]){
                        translate([CHARGER_HLDR_SCREW_DIST/2, 
                                    3, 
                                    CHARGER_HLDR_SCREW_SIDE_OS]){
                           rotate([90, 0, 0]){
                               cylinder(h = 6, r = CHARGER_HLDR_SCREW_RD);
                           }
                        }
                        translate([-CHARGER_HLDR_SCREW_DIST/2, 
                                    3, 
                                    CHARGER_HLDR_SCREW_SIDE_OS]){
                           rotate([90, 0, 0]){
                               cylinder(h = 6, r = CHARGER_HLDR_SCREW_RD);
                           }
                        }
                    }
                }
                translate([0, 5, 3.5]){
                    rotate([180, -90, 0]){
                        difference(){
                            cube([8, 8, 3], center=true);
                            translate([0, -5, 0]){
                                rotate([0, 0, 135]){
                                    cube([20,8 ,4], center=true);
                                }
                            }
                        } 
                    }
                }
            }
        }
    }
    
    

}

// color("yellow",1.0){
//     charger_socket_holder();
// }


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

                    // translate([80, 0, -48]){
                    //     display_box();
                    // }   
                }
                // #scale([0.97,0.97,1.05]){
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
                // CHARGER SOCKET HOLE
                translate([-80, 0, -25]){
                    rotate([0, -60, 0]){
                        charger_hole();
                    }
                }

                translate([0,0,-6]){
                    scale([1.01,1.01,1]){
                        translate([0,0,5]){
                            cylinder(r = top_base_rd, h = BASE_RING_HT);
                        }
                    }
                }
            }

            // CHARGER SOCKET HOLDER
            color("yellow",1.0){
                charger_socket_holder();
            }


            
            // bollards
            for (this_ang = bollard_angles){
                rotate([0,0,this_ang - 90]){
                    difference(){
                        screw_bollard();
                        translate([(PLATE_RD*1.2) + 5, -5,-52]){
                            cylinder(h = 12, r = 2.4/2);
                        }
                        translate([(top_base_rd - 12) + 5, -5,-10]){
                            cylinder(h = 15, r = 4.2/2);
                        }
                    }
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
// difference() {
//     union(){
         //main_bottom_body();
//         translate([0, 0, -6]){
//             top_base_ring();
//         }
//     }
    // translate([-78, 12, -20]){
    //     rotate([0, 0, 0]){
    //         cube([200, 100, 80 ], center=true);
    //     }
    // }
// }

//top_base_ring();

    

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
union(){
    // color("red",0.2){
         // top_base_ring();
    // }

    translate([19, 0, 25]){
        rotate([0, 0, 180]){
            //load_cell_assy();
        }
    }

    // mount plate
    color("white",1.0){
        
    translate([0,0,39]){
        rotate([0,180,0]){
            intersection(){
                //mount_cup();
                //cube([50,25 ,50 ], center=true);
            }
        }
    }
    

    }

    // // measurements for centering
    // translate([-60, 0, 36]){
    //     cube([35.5/2, 5 , 2], center=true);
    // }
    // translate([60, 0, 36]){
    //     cube([35.5/2, 5, 2], center=true);
    // }
}


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









