// NOT FOR PRINTING
// FOR MODEL TESTING
$fn=50;


BODY_WD = 13;
BODY_TN = 8.5;
BODY_HT = 10;

// contact stanchions
module contact_stanchion(){
    cube([2.5 ,7 ,1 ], center=true);
    translate([0, 0, 0.5]){
        cube([2.5 ,3.5 ,1 ], center=true);
    }
}
//contact_stanchion();


module contact(){
    difference() {
        cube([0.3, 3.7, 7], center=true);
        translate([0, 0, 3.5 - 1.1 - 0.6]){
            cube([1 ,1.2 ,2.8 ], center=true);
        }
        translate([0, 1.8, 3.2]){
            rotate([38, 0 , 0]){
                cube([2,1 ,2 ], center=true);
            }
        }
        translate([0, -1.8, 3.2]){
            rotate([-38, 0 , 0]){
                cube([2,1 ,2 ], center=true);
            }
        }
    }
}


module small_rocker_switch(colour){
    color(colour,1.0){
        // main body
        cube([BODY_WD, BODY_TN, BODY_HT], center=true);

        // top fascia
        translate([0, 0, BODY_HT/2 + 0.49]){
            hull(){
                cube([15, 10.5, 1], center=true);
            
                translate([0, 0, 1.25]){
                    cube([12.5, 8, 0.1], center=true);
                }
            }
        }

 
        // Bottom contact stanchions etc
        translate([0, 0, -5]){
            rotate([180, 0, 0]){
                contact_stanchion();
                
            }
        }
        translate([5, 0, -5]){
            rotate([180, 0, 0]){
                contact_stanchion();
                
            }
        }
        translate([-5, 0, -5]){
            rotate([180, 0, 0]){
                contact_stanchion();
            }
        }


        // rocker
        difference(){
            translate([0, 3.15, 4]){
                rotate([90, 0, 0]){
                    cylinder(r= 12/2, h=6.3 );
                }
            }
            // the bite for the concave surface
            translate([0, 3.2, 14]){
                rotate([90, 0, 0]){
                    cylinder(r= 12/2, h=7 );
                }
            }
        }
    }
    // Bottom contacts
    color("lightgray",1.0)
        translate([0, 0, -5]){
            rotate([180, 0, 0]){
                
                translate([0, 0, 3.4]){
                    contact();
                }
            }
        }
        translate([5, 0, -5]){
            rotate([180, 0, 0]){
                
                translate([0, 0, 3.4]){
                    contact();
                }
            }
        }
}



//small_rocker_switch("black");