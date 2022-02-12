use <MCAD/regular_shapes.scad>
include <Round-Anything/polyround.scad>
include <utils.scad>

include <display_lid01.scad>
include <dimensions.scad>


// $fn=100;
// fn=50;

// battpack_width = 125;
// battpack_length = 65;
// battpack_height = 15;
// battpack_wallwidth = 3;

// battpack_box_height = battpack_height+battpack_wallwidth*2;

// leg_length = 110;
// leg_width = 15;
// leg_thickness = 3;
// leg_end_rad = 4;

// display_box_width = 100;
// display_box_depth = 50;
// display_box_height = battpack_height;
// display_box_front_cnr_rad = 10;
// display_box_wall_width=2;

// // Legs
// leg_points = [
//     [leg_width/2,0,0],
//     [leg_width/2,leg_length,leg_end_rad],
//     [-leg_width/2,leg_length,leg_end_rad],
//     [-leg_width/2,0,0],
    
// ];

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



module display_box(){
    difference(){
        linear_extrude(height=display_box_height){
            polygon(polyRound(display_box_points,fn));
        };
        translate([0,0,display_box_wall_width]){
            linear_extrude(height=display_box_height){
                polygon(polyRound(scale_points(display_box_points,
                                            display_box_wall_width),
                                fn));
            }
        };

    }
}

//echo(scale_points(display_box_points,2));
display_box();



// invrt2 = 1/sqrt(2);
// disp_height = 40;
// disp_bottx = 1;
// disp_botty = 8;
// disp_front_rad = 10;
// disp_front_thickness = 2;

// disp_topx = disp_bottx+(disp_height*invrt2);
// disp_topy = disp_botty+(disp_height*invrt2);

// display_top_points = [
//     [0,0,0],
//     [disp_bottx,disp_botty,disp_front_rad],
//     [disp_topx,disp_topy,disp_front_rad],
//     [disp_topx+10,disp_topy,0],
//     [disp_topx+10,disp_topy-disp_front_thickness,0],
//     [disp_topx+disp_front_thickness,
//         disp_topy-disp_front_thickness,
//         disp_front_rad-disp_front_thickness],
//     [disp_bottx+disp_front_thickness,
//         disp_botty-disp_front_thickness,
//         disp_front_rad-disp_front_thickness],
//     [disp_front_thickness,0,0]
// ];
// translate([50,
//            display_box_depth+battpack_length/2,
//            display_box_height]){
//     rotate(90,[1,0,0]){
//         rotate(-90,[0,1,0]){
//             linear_extrude(height=100){
//                 polygon(polyRound(display_top_points,30));
//             }
//         }
//     }
// }

// THE LEGS
module leg_shape(){
    linear_extrude(height=leg_thickness){
        polygon(polyRound(leg_points));
    }    
    translate([0,leg_length,leg_thickness]){
        rotate(90,[1,0,0]){
            linear_extrude(height=leg_length){
                polygon([[-2,0],
                    [2,0],
                    [0,2]
                    ]);
            }
        }
    }

}

leg_shape();
rotate(120,[0,0,1]){
    leg_shape();
}
rotate(240,[0,0,1]){
    leg_shape();
}

// Battery box
translate([0,0,battpack_box_height/2]){
    difference(){
        cube(size=[battpack_width+battpack_wallwidth*2,
                battpack_length+battpack_wallwidth*2,
                battpack_box_height],
                center=true);
        translate([0,0,battpack_wallwidth]){
            cube(size=[battpack_width,
                battpack_length,
                battpack_height],center=true);
        }
    }
}