include <Round-Anything/polyround.scad>
include <model_1602_display.scad>
include <display01.scad>
include <load_cell_assy.scad>
include <main_PCB.scad>
include <battery_pack.scad>
include <battery_straps.scad>

$fn=180;


RT2 = sqrt(2);
PLATE_RD = 120/2;
SIDE_HT= 40;
SIDE_ANG = 40;
FACE_WD=90;
BASE_RING_HT = 12;

top_base_rd = PLATE_RD * 1.2;
bot_base_rd = top_base_rd +20;



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
        translate([0, 0, -0.5]){
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


bollard_angles = [ 70, // these two
                  120, // are around the display
                  5,  
                  185,
                  235,
                  310
                  ];




//############################################################################
// base ring
TOP_BASE_TN = 3;
CELL_PLATE_RD = 103/2;
inner_ring_rd = top_base_rd /3;
plateholder_screwhole_rad = top_base_rd -8.5;
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
            rotate([0, 0, 165]){ // choosing the most convenient place
                translate([0,55,-5]){
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
                    translate([plateholder_screwhole_rad , 0, 0]){
                        cylinder(h = BASE_RING_HT, r = 8/2);
                    }
                }
                rotate([0, 0, -60]){
                    translate([plateholder_screwhole_rad , 0, 0]){
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
                translate([plateholder_screwhole_rad , 0, 3]){
                    cylinder(h = BASE_RING_HT, r = 2.5/2);
                }
            }
            rotate([0, 0, -60]){
                translate([plateholder_screwhole_rad , 0, 3]){
                    cylinder(h = BASE_RING_HT, r = 2.5/2);
                }
            }


        }


    }
}

// rotate([0, 0, -30]){
//     translate([0, plateholder_screwhole_rad-4.9, 20]){
//         plateholder_clip();
//     }
// }

top_base_ring();

    



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



//####################################################################
//######  Plateholder clips

module plateholder_clip(){
    CLIP_LN = 20;
    CLIP_WD = 10;
    CLIP_TN = 3;
    difference(){
        cube([CLIP_WD, CLIP_LN, CLIP_TN ], center=true);
        translate([0, CLIP_LN/2 - 5, -CLIP_TN]){
            cylinder(h = CLIP_TN * 2, r = 2.5/2);
            translate([0, 0, 4]){
                countersink_cone(5);
            }
        }
        
    }
    
    
    translate([0, CLIP_LN/2 - (CLIP_TN*0.6)/2, -5/2]){
        difference() {
            cube([CLIP_WD,CLIP_TN*0.6 ,5 ], center=true);
            translate([0, 0, -5.5]){
                rotate([0, 45, 0]){
                    cube([CLIP_WD,CLIP_TN * 1.1 ,CLIP_WD ], center=true);
                }
            }
        }
        
    }
        
    
    translate([0, -CLIP_LN/2 + CLIP_TN/2, -5/2]){
            cube([CLIP_WD,CLIP_TN , 3 ], center=true);
        
    }
}


//!plateholder_clip();








