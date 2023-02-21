// NOT FOR PRINTING
// FOR MODEL TESTING
// Small cylindrical push button switch with a coloured button
$fn=60;

BODY_LN = 20;
BODY_RD = 11.5/2;

TOP_RD = 14.3/2;
TOP_LIP_HT = 2.5;
BUTTON_RD = 9/2;
BUTTON_HT = 3.0; // also button travel

THREAD_LN = 9.5;
THREAD_HT = 0.5;
THREAD_DIST = 1.0; // distance between each revolution

TAB_LN = 5.6;
TAB_WD = 2;
TAB_TN = 0.6;

NUT_RING_RD = 16.2/2;
NUT_RING_HT = 2.2;
NUT_HT = 5.2;




module coloured_push_button(colour, nut_posi){
    // colour as string colour name
    // nut_posi = distance from top lip (0-THREAD_LN)
    // main cylinder
    cylinder(h = BODY_LN, r = BODY_RD);

    // top lip
    translate([0,0,BODY_LN - TOP_LIP_HT]){
        cylinder(h = 1, r = TOP_RD);
    }

    translate([0,0,BODY_LN - (TOP_LIP_HT - 1)]){
        cylinder(h = 1.5, r1 = TOP_RD, r2 = BODY_RD);
    }

    // button
    translate([0,0,BODY_LN]){
        color(colour,1.0){
            cylinder(h = BUTTON_HT, r = BUTTON_RD);
        }
    } 

    // thread approximation
    // Not doing full helix but a sequence of rings
    intersection(){ // it has 2 flattened sides
        thread_top = BODY_LN - TOP_LIP_HT;
        thread_bottom = thread_top - THREAD_LN;


        for(ht = [thread_bottom: 0.9: thread_top]){
            translate([0,0,ht]){ 
                rotate_extrude(angle= 360){
                    translate([BODY_RD + 0.25,0,0]){
                        circle(r = 0.25, $fn=3);
                    } 
                }
            }
        }

        translate([0,0,thread_top - (THREAD_LN/2)]) {
            cube([BODY_RD * 2, BODY_RD * 3, THREAD_LN ], center=true);
        }
    }

    // tabs
    translate([3, TAB_WD/2, -TAB_LN/2]){
        cube([TAB_TN, TAB_WD, TAB_LN], center=true);
    }
    translate([-3, TAB_WD/2, -TAB_LN/2]){
        cube([TAB_TN, TAB_WD, TAB_LN], center=true);
    }
    
    // nut
    nut_position = BODY_LN - TOP_LIP_HT - NUT_HT -nut_posi;
    translate([0,0,nut_position]){
        cylinder(h = NUT_HT-NUT_RING_HT, r = NUT_RING_RD, $fn=6);
        translate([0,0,NUT_RING_HT]){
            cylinder(h = NUT_HT-NUT_RING_HT, r = NUT_RING_RD);
        } 
        
    } 

}

//coloured_push_button("yellow", 2);

