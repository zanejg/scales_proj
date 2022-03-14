use <MCAD/regular_shapes.scad>
include <Round-Anything/polyround.scad>
include <dimensions.scad>

include <utils.scad>


// fn=50;

// battpack_width = 125;
// battpack_length = 65;
// battpack_height = 15;

// display_box_width = 100;
// display_box_depth = 50;
// display_box_height = battpack_height;
// display_box_front_cnr_rad = 10;
// display_box_wall_width=2;



// display_lid_width = display_box_width + display_box_wall_width;
// display_lid_cnr_rad = display_box_front_cnr_rad + 
//                         display_box_wall_width;
// display_lid_depth = display_box_depth - display_box_wall_width - 1;

// display_lid_height = 50;



//##########################################################################
// display_box_points = [
//     [display_box_width/2,battpack_length/2,0],
//     [-display_box_width/2,battpack_length/2,0],
//     [-display_box_width/2,
//       battpack_length/2+display_box_depth,
//       display_box_front_cnr_rad],
//     [display_box_width/2,
//       battpack_length/2+display_box_depth,
//       display_box_front_cnr_rad],
// ];


// module display_box(){
//     difference(){
//         linear_extrude(height=display_box_height){
//             polygon(polyRound(display_box_points,fn));
//         };
//         translate([0,0,display_box_wall_width]){
//             linear_extrude(height=display_box_height){
//                 polygon(polyRound(scale_points(display_box_points,
//                                             display_box_wall_width),
//                                 fn));
//             }
//         };

//     }
// }
// display_box();
//###########################################################################


module hulled_rod(){
    right_sphere_center = display_lid_width/2 - display_lid_cnr_rad;
    left_sphere_center = -(display_lid_width/2 - display_lid_cnr_rad);
    hull(){
        translate([left_sphere_center,0,0]){
            sphere(display_lid_cnr_rad);
        }
        translate([right_sphere_center,0,0]){
            sphere(display_lid_cnr_rad);
        }
    };
}


hull(){
    translate([0,battpack_length/2+display_box_depth-display_lid_cnr_rad,
                display_box_height+display_lid_cnr_rad]){
        hulled_rod();
    }

    // translate([0,battpack_length/2+display_lid_cnr_rad,
    //             display_box_height+display_lid_height-display_lid_cnr_rad]){
    //     hulled_rod();
    // }
    translate([-display_lid_width/2,
                battpack_length/2,
                display_box_height+
                    display_lid_height-display_lid_cnr_rad]){
        rotate(90,[1,0,0]){
            rotate(90,[0,1,0]){
                linear_extrude(height=display_lid_width){
                    polygon([[0,8],[0,0],[2,0]]);
                }
            }
        }
    }

    


    //cube([display_box_width,10,10]);
    translate([0,0,display_box_height]){
            linear_extrude(height=5){
                polygon(polyRound(scale_points(display_box_points,
                                            -display_box_wall_width),
                                fn));
            }
        };
}


difference(){
    translate([0,0,display_box_height]){
        linear_extrude(height=5){
            polygon(polyRound(scale_points(display_box_points,
                                        -display_box_wall_width),
                            fn));
        }
    };
    translate([0,0,display_box_height]){
        linear_extrude(height=display_box_height){
                polygon(polyRound(display_box_points,fn));
        };
    };
}


