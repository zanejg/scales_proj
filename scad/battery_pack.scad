
$fn=50;
module battery_pack(){
    color("DarkSlateGray",1.0){
        difference(){
            // main body
            intersection(){
                difference(){
                    hull(){    
                        hull(){
                            cylinder(h = 90, r = 9);
                            translate([2.5, 0, 0]){
                                cylinder(h = 90, r = 9);
                            }
                        }
                        translate([0, -13, 0]){
                            hull(){
                                cylinder(h = 90, r = 9);
                                translate([2.5, 0, 0]){
                                    cylinder(h = 90, r = 9);
                                }
                            }
                        }
                    }
                    translate([0, -31, 47]){
                        cube([40,20 ,95 ], center=true);
                    }
                    
                }
                
                hull(){
                    translate([0, 20, 45]){
                        cube([30,5,90 ], center=true);
                    }
                
                    translate([-15, -14.01, 83]){
                        rotate([0, 90, 0]){
                            cylinder(h = 30, r = 7);
                        }
                    }
                    translate([-15, -14.01, 7]){
                        rotate([0, 90, 0]){
                            cylinder(h = 30, r = 7);
                        }
                    }
                }
            }
            
            // USB A hole
            translate([-1.2, -5, 87]){
                cube([5.8,13 ,10 ], center=true);
            }
            // Micro USB hole
            translate([7, -8, 83]){
                hull() {
                    hull() {
                        cylinder(h = 10, r = 3/2);
                        translate([0, 5, 0]){
                            cylinder(h = 10, r = 3/2);
                        }
                    }
                    translate([0.7, 2.5, 5]){
                        cube([3/2, 8 ,10 ], center=true);
                    }
                }
                
            }
        }
    }
    // USB A tongue
    translate([-3, -5, 85]){
        color("white",1.0){
            cube([1.3,11 ,10 ], center=true);
        }
    }

}