$fn=60;
PLATEHOLDER_HT = 5;
PLATEHR_TN = 2.5;


AL_PLATE_RD = 103/2;
AL_PLATE_TN = 1.8;

platehdr_otr_rd = AL_PLATE_RD + 10;

rotate([0, -90, 0]){
    translate([53.65, 30, 0]){
        difference() {
            // main positive block
            cylinder(h = PLATEHOLDER_HT, r = platehdr_otr_rd);
            // create outer phlange
            translate([0, 0, PLATEHR_TN]){
                difference() {
                    cylinder(h = PLATEHOLDER_HT , r = platehdr_otr_rd+1);
                    translate([0, 0, -1]){
                        cylinder(h = PLATEHOLDER_HT * 1.4, r = AL_PLATE_RD + PLATEHR_TN );
                    }
            
                }
            }
            // create upper lip
            translate([0, 0, -(PLATEHOLDER_HT-(AL_PLATE_TN + 0.1))]){
                cylinder(h = PLATEHOLDER_HT, r = AL_PLATE_RD+1);
            }
            // remove centre
            translate([0, 0, 1]){
                cylinder(h = PLATEHOLDER_HT, r = AL_PLATE_RD - 8);
            }
    
            // only want a small bit of the round
            translate([-100, -30, -1]){
                cube([200, 200, 10], center=false);
            }
        }
    }
}


// supports
// support feet
x_sup_dist = 15;
translate([x_sup_dist - 3, -5, 0]){
    cube([15, 10, 2], center=true);
}
translate([-x_sup_dist, -10, 0]){
    cube([15, 20, 2], center=true);
}

translate([0, -25, 0]){
    cube([10, 28, 2], center=true);
}  

translate([20, -28, 0]){
    cube([10,10 ,2 ], center=true);
}




// // lower struts
translate([-9, -6, 0.65]){
    rotate([0, 15, 0]){
        cylinder(h = 15, r2 = 1/2, r1 = 2/2);
    }
}
translate([5, -6, 0.65]){
    rotate([0, -40, 0]){
        cylinder(h = 8, r2 = 1/2, r1 = 2/2);
    }
}

translate([-1, -17, 0.65]){
    rotate([-30, 0, 0]){
        cylinder(h = 10, r2 = 1/2, r1 = 2/2);
    }
}

translate([-1, -37, 0.05]){
    rotate([-25, 0, 0]){
        cylinder(h = 29, r2 = 1/2, r1 = 4/2);
    }
}

// upper struts
translate([-18, -15, 0]){
    rotate([0, 20, 0]){
        cylinder(h = 40, r2 = 1/2, r1 = 5/2);
    }
}
translate([20, -28, 0.2]){
    rotate([0, -25, 0]){
        cylinder(h = 50, r2 = 1/2, r1 = 5/2);
    }
}
