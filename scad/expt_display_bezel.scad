
FRAME_OUTER_WD = 100;
FRAME_OUTER_HT = 30;
FRAME_OUTER_TN = 3;

frame_ingress = (FRAME_OUTER_TN * 1.8);


module display_frame(){
    difference(){
        difference(){    
            cube([FRAME_OUTER_WD, FRAME_OUTER_HT, FRAME_OUTER_TN], center=true);
            
            translate([0, 0, 2.99]){
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

