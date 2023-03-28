// Small pcb with micro-USB socket and connectors etc
$fn=60;

PCB_WD = 13.6;
PCB_LN = 15;
PCB_TN = 1.5;

BIG_HOLE_RD = 3.2/2;
SM_HOLE_RD = 1.0/2;
SM_HOLE_DIST = 2.5;

USB_HT = 2.6;
USB_WD = 7.5;
USB_LN = 6.1;

module micro_USB_skt_PCB(){
    difference() {
        // main PCB body
        cube([PCB_WD, PCB_LN, PCB_TN], center=true);

        // big screwholes
        translate([PCB_WD/2 - BIG_HOLE_RD -1,
                    PCB_LN/2 - BIG_HOLE_RD - 4, 
                    -PCB_TN]){
            cylinder(h = PCB_TN * 2, r = BIG_HOLE_RD);
        }
        translate([-PCB_WD/2 + BIG_HOLE_RD +1,
                    PCB_LN/2 - BIG_HOLE_RD - 4, 
                    -PCB_TN]){
            cylinder(h = PCB_TN * 2, r = BIG_HOLE_RD);
        }
        // little wire holes
        start_hole_seq = -PCB_WD/2 + SM_HOLE_RD + 1.4;
        for(hole_x = [start_hole_seq: SM_HOLE_DIST: start_hole_seq + (5 * SM_HOLE_DIST)]){
            translate([hole_x,PCB_LN/2-1.2,-PCB_TN]){
                cylinder(h = PCB_TN * 2, r = SM_HOLE_RD);
            }
        }
    }

    USB_CYL_RD = 0.95;
    module USB_hull(){
        hull(){
            translate([USB_WD/2 - USB_CYL_RD,
                        0,
                        PCB_TN/2+USB_HT-USB_CYL_RD]){
                rotate([90,0,0]){
                    cylinder(r=USB_CYL_RD, h= USB_LN);
                }
            }
            
            translate([-USB_WD/2 + USB_CYL_RD,
                        0,
                        PCB_TN/2+USB_HT-USB_CYL_RD]){
                rotate([90,0,0]){
                    cylinder(r=USB_CYL_RD, h= USB_LN);
                }
            }

            translate([USB_WD/2 - USB_CYL_RD-0.5,
                        0,
                        PCB_TN/2 + USB_CYL_RD]){
                rotate([90,0,0]){
                    cylinder(r=USB_CYL_RD, h= USB_LN);
                }
            }
            
            translate([-USB_WD/2 + USB_CYL_RD +0.5,
                        0,
                        PCB_TN/2 + USB_CYL_RD]){
                rotate([90,0,0]){
                    cylinder(r=USB_CYL_RD, h= USB_LN);
                }
            }
        }
    }

    USB_SHELL_SCALE = 0.9;
    vert_shell_shift = (USB_HT - (USB_HT * USB_SHELL_SCALE)) /2;

    translate([0,-2,0]){ 
        difference() {
            USB_hull();
            translate([0,1,vert_shell_shift]){ 
                scale([USB_SHELL_SCALE,1.5,USB_SHELL_SCALE]){
                    USB_hull();
                }
            }
        }
    }
}
//micro_USB_skt_PCB();