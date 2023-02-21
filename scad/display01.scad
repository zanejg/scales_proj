include <Round-Anything/polyround.scad>

include <model_1602_display.scad>
include <coloured_button_sw.scad>
include <small_black_rocker_switch.scad>


DISPLAY_ANG=30;
DISPLAY_BOX_WD=120;
BOT_WD=40;
TOP_WD=30;
HT=49;
SKIRT_HT=10;
disp_ht= HT-SKIRT_HT; // only the vert comp
topx = BOT_WD - (disp_ht * (sin(DISPLAY_ANG)/cos(DISPLAY_ANG))) ;


SCREEN_WD = 71.5;
SCREEN_HT = 24.5;


PLATE_RD = 120/2;

top_base_rd = PLATE_RD * 1.2;
bot_base_rd = top_base_rd +20;



module main_cone(){

    translate([0,0,-38]){
        cylinder(h = 40, r2 = top_base_rd, r1 = bot_base_rd);
    }  
    // base ring
    translate([0,0,-47.9]){
        cylinder(h=10, r=bot_base_rd);
    }
}

BACK_DIST = 20;

cross_section_pts = [
    [0 - BACK_DIST,0,0],
    [BOT_WD - 5, 0, 0],
    [BOT_WD, SKIRT_HT, 3],
    [topx, HT, 4],
    [topx - BOT_WD - BACK_DIST, HT, 2],
    [0 - BACK_DIST, SKIRT_HT, 2],
];

module main_body(){
    translate([0, DISPLAY_BOX_WD/2, 0]){
        rotate([90, 0, 0]){
            linear_extrude(height = DISPLAY_BOX_WD){
                polygon(points = polyRound(cross_section_pts,40));
            }
        }
    }
}
module disp_screw_bollards(){
    BOLLARD_RD = 6/2;
    SCREWHOLE_RD = 2/2;

    difference() {
        cylinder(h = 8.5, r = BOLLARD_RD);
        translate([0, 0, 1]){
            cylinder(h = 8, r = SCREWHOLE_RD);
        }
    }
    

}


module display_position() {
    translate([28, 5, 28]){
        rotate([0, -DISPLAY_ANG, 0]){
            children();
        }
    }
}
//#############################################################
// Bezel for Display Frame
FRAME_OUTER_WD = SCREEN_WD;
FRAME_OUTER_HT = SCREEN_HT;
FRAME_OUTER_TN = 2.1;

frame_ingress = (FRAME_OUTER_TN * 1.8);


module display_frame(){
    difference(){
        difference(){    
            cube([FRAME_OUTER_WD, FRAME_OUTER_HT, FRAME_OUTER_TN], center=true);
            
            translate([0, 0, FRAME_OUTER_TN * 0.99]){
                hull(){
                    cube([FRAME_OUTER_WD, FRAME_OUTER_HT, FRAME_OUTER_TN], center=true);
            
                    translate([0, 0, -FRAME_OUTER_TN]){
                        cube([FRAME_OUTER_WD - frame_ingress, 
                                FRAME_OUTER_HT - frame_ingress , 
                                FRAME_OUTER_TN], center=true);
                    }
                }
            }
        }
    }
}



module brass_bush_holes_placement(bush_hole_os){
// brass bush screwholes
    
    translate([-26.9, -50, 44]){
        rotate([0, 90, -40]){
            translate([0, 0, -bush_hole_os]){
                children();
            }
        }
    }
    
    translate([-26.9, 50, 44]){
        rotate([0, 90, 40]){
            translate([0, 0, -bush_hole_os]){
                children();
            }
        }
    }

    translate([-5, 51, 5]){
        rotate([0, 90, 20]){
            translate([0, 0, -bush_hole_os]){
                children();
            }
        }
    }
    translate([-5, -51, 5]){
        rotate([0, 90, -20]){
            translate([0, 0, -bush_hole_os]){
                children();
            }
        }
    }
}


module brass_bush_holes(rad){
    BUSH_HOLE_LN = 20;
    bush_hole_os = BUSH_HOLE_LN - 12;

    brass_bush_holes_placement(bush_hole_os){
        cylinder(h = BUSH_HOLE_LN, r = rad);
    }
}


module display_box(){
    difference(){
        union(){
            
            difference(){
                union(){
                    difference() {
                    
                        main_body();
                    
                        translate([-1, 0, 1]){   
                            scale([0.96,0.96,0.95]){
                                main_body();
                            }
                        }
                    
                        display_position(){
                            // holes for display and switches etc
                            // main display hole
                            cube([15, SCREEN_WD, SCREEN_HT ], center=true);
                            // rocker switch hole
                            translate([0, 47, -5]){
                                cube([8, 9, 13.5], center=true);
                            }
                            // top push button
                            translate([0, -50.6, 9]){
                                rotate([0, 90, 0]){
                                    cylinder(h = 15, r = 12.5/2, center=true);
                                }
                            }
                            // bottom push button
                            translate([0, -50.6, -10]){
                                rotate([0, 90, 0]){
                                    cylinder(h = 15, r = 12.5/2, center=true);
                                }
                            }
                        }
                    }
                    // corner attachment screw stanchions
                    // top
                    translate([-30, -53, 43]){
                        hull(){
                            cube([30, 10, 10], center=true);
                            translate([25, 0, 5]){
                                cube([1, 10 ,0.1], center=true);
                            }
                        }
                    }
                    translate([-30, 53, 43]){
                        hull(){
                            cube([30, 10, 10], center=true);
                            translate([25, 0, 5]){
                                cube([1, 10 ,0.1], center=true);
                            }
                        }
                    }

                    // bottom
                    translate([-5, 53, 5]){
                        hull(){
                            cube([30, 10, 8], center=true);
                            translate([30, 5, 5]){
                                cube([0.1,0.1,0.1], center=true);
                            }
                        }
                    }
                    translate([-5, -53, 5]){
                        hull(){
                            cube([30, 10, 8], center=true);
                            translate([30, -5, 5]){
                                cube([0.1,0.1,0.1], center=true);
                            }
                        }
                    }
                    
                }
                translate([-(PLATE_RD + 20), 0, 47.5]){
                    main_cone();
                }
                brass_bush_holes(4.2/2);
                
            }
                        
                
            
            


            TOP_OS = 4.0;
            BOT_OS = 1;
            X_OS = 2.5;
            Y_OS = 1.5;
        
            bollard_posis = [
                // Tp 
                [-(SCREEN_WD/2 + X_OS),  (SCREEN_HT/2 + Y_OS + TOP_OS)],
                [ (SCREEN_WD/2 + X_OS),  (SCREEN_HT/2 + Y_OS + TOP_OS)],
                // bottom
                [ (SCREEN_WD/2 + X_OS), -(SCREEN_HT/2 + Y_OS + BOT_OS)],
                [-(SCREEN_WD/2 + X_OS), -(SCREEN_HT/2 + Y_OS + BOT_OS)]
            ];
            display_position(){
                rotate([0, -90, 0]){
                    rotate([0, 0, -90]){
                        translate([-0.5, -0.5, 0]){
                            for(bp=bollard_posis){
                                translate([bp[0], bp[1], 0]){
                                    rotate([0, 0, 0]){
                                        disp_screw_bollards();
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
            display_position(){
                translate([0, 0, 0]){
                    rotate([0, 90, 0]){
                        rotate([0, 0, 90]){
                            translate([0, 0, 0.32]){
                                
                                display_frame();
                            }
                        }
                    }
                }
            }   
        }
        
        // // Cross section chop out
        // translate([-30, -125, -5]){
        //     rotate([0, 0, 0]){
        //         cube([70, 120, 70]);
        //     }
        // }
    }
}




// display_box();

// //#####################################################
// // UNPRINTABLE BELOW
// //#########################################################
// translate([20.13, 5.5, 24.75]){
//     rotate([0, 60, 0]){   
//         rotate([0, 0, 90]){
//             translate([0, 0, -0.5]){
//                 display_model_1602();
//             }
//         }
//     }
// }





// translate([19, -SCREEN_WD/2 - 10, 12]){
//     rotate([0, 90 - DISPLAY_ANG, 0]){
//         coloured_push_button("green", 3);
//     }
// }

// translate([10, -SCREEN_WD/2 - 10, 28]){
//     rotate([0, 90 - DISPLAY_ANG, 0]){
//         coloured_push_button("yellow", 3);
//     }
// }

// translate([28, DISPLAY_BOX_WD/2 -8, 22]){
//     rotate([0, 90 - DISPLAY_ANG, 0]){
//        small_rocker_switch("white");
//     }
// }



