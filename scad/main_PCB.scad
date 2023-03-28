
include <strip_connectors.scad>

MAIN_PCB_WD = 90;
MAIN_PCB_LN = 67;

PCB_TN = 1.7;

HX711_WD = 16;
HX711_LN = 24;

module place_PCB_screwholes(){
    translate([42, 30, 0]){
        children();
    }
    translate([-42, 30, 0]){
        children();
    }
    translate([81.5/2, -30, 0]){
        children();
    }
    translate([-81.5/2, -30, 0]){
        children();
    }
}



module main_PCB(){
    difference(){
        union(){
            color("green",1.0){
                // main PCB
                cube([MAIN_PCB_WD, MAIN_PCB_LN, PCB_TN], center=true);
                
                // HX711
                translate([-((MAIN_PCB_WD/2 - HX711_WD/2)-5), 
                        (MAIN_PCB_LN/2 - HX711_LN/2) - 11.5, 
                        10]){
                    cube([HX711_WD, HX711_LN, PCB_TN], center=true);
                }
                
                // RPI PICO
                translate([-6, 10, 9.73]){
                    rotate([90, 0, -90]){
                        import("Pico-R3.stl", convexity=10);
                    }
                }
                
            }
        
            // RPI PICO connectors
            translate([-4, 9, -2.5]){
                multi_female_connector(20);
            }
            translate([-4, -9, -2.5]){
                multi_female_connector(20);
            }
        
        
            // HX711 connectors
            translate([-35, 20, -2.5]){
                rotate([0, 0, 0]){
                    multi_female_connector(4);
                }
            }
        
            translate([-38, 0, -2.5]){
                rotate([0, 0, 0]){
                    multi_female_connector(6);
                }
            }
        
        
            // switch connectors
            translate([-(MAIN_PCB_WD/2-17.2), -(MAIN_PCB_LN/2-3) , -2.3]){
                rotate([0, 0, 0]){
                    multi_male_connector(2);
                }
            }
            translate([-(MAIN_PCB_WD/2-27.2), -(MAIN_PCB_LN/2-3) , -2.3]){
                rotate([0, 0, 0]){
                    multi_male_connector(2);
                }
            }
            translate([(MAIN_PCB_WD/2-9.5), -(MAIN_PCB_LN/2-3) , -2.3]){
                rotate([0, 0, 0]){
                    multi_male_connector(2);
                }
            }
            translate([(MAIN_PCB_WD/2-21.5), -(MAIN_PCB_LN/2-3) , -2.3]){
                rotate([0, 0, 0]){
                    multi_male_connector(2);
                }
            }
        
            // load cell connector
            translate([-(MAIN_PCB_WD/2 - 9.5), -(MAIN_PCB_LN/2 - 19) , -2.3]){
                rotate([0, 0, 0]){
                    multi_male_connector(4);
                }
            }
        
            // display connector
            translate([(MAIN_PCB_WD/2 - 10), (MAIN_PCB_LN/2 - 8) , -2.3]){
                rotate([0, 0, 0]){
                    multi_male_connector(4);
                }
            }
        }
        
        translate([0, 0, -2]){   
            place_PCB_screwholes(){
                cylinder(h = 6, r = 3/2);
            }
        }
    }
}




// main_PCB();
