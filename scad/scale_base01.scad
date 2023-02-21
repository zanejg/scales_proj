
RT2 = sqrt(2);
PLATE_RD = 100/2;
SIDE_HT= 40;
SIDE_ANG = 40;
top_base_side = 2* PLATE_RD * 1.2;

translate([0,0,2]){
    difference(){
        cube([top_base_side, top_base_side, 10],center=true);
        translate([0,0,1]){
            cylinder(r=PLATE_RD * 1.02,h=5);
        }
    }
}

cyl_os = SIDE_HT/(4* cos(SIDE_ANG));


hull(){
    translate([-(RT2 * PLATE_RD + cyl_os),
                -(RT2 * PLATE_RD + cyl_os),
                -(SIDE_HT * cos(SIDE_ANG))]){
        rotate([0,SIDE_ANG,45]){
            cylinder(h = SIDE_HT, r = 5);
        }
    }

    translate([-(RT2 * PLATE_RD + cyl_os),
                (RT2 * PLATE_RD + cyl_os),
                -(SIDE_HT * cos(SIDE_ANG))]){
        rotate([0,SIDE_ANG,-45]){
            cylinder(h = SIDE_HT, r = 5);
        }
    }


    translate([(RT2 * PLATE_RD + cyl_os),
                (RT2 * PLATE_RD + cyl_os),
                -(SIDE_HT * cos(SIDE_ANG))]){
        rotate([0,-SIDE_ANG,45]){
            cylinder(h = SIDE_HT, r = 5);
        }
    }


    translate([(RT2 * PLATE_RD + cyl_os),
                -(RT2 * PLATE_RD + cyl_os),
                -(SIDE_HT * cos(SIDE_ANG))]){
        rotate([0,-SIDE_ANG,-45]){
            cylinder(h = SIDE_HT, r = 5);
        }
    }
}