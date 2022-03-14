
$fn=100;
fn=50;

battpack_width = 125;
battpack_length = 65;
battpack_height = 15;
battpack_wallwidth = 3;

battpack_box_height = battpack_height+battpack_wallwidth*2;

leg_length = 110;
leg_width = 15;
leg_thickness = 3;
leg_end_rad = 4;

display_box_width = 100;
display_box_depth = 50;
display_box_height = battpack_height/4;
display_box_front_cnr_rad = 10;
display_box_wall_width=2;



display_lid_width = display_box_width + display_box_wall_width;
display_lid_cnr_rad = display_box_front_cnr_rad + 
                        display_box_wall_width;
display_lid_depth = display_box_depth - display_box_wall_width - 1;

display_lid_height = 50;


// Legs
leg_points = [
    [leg_width/2,0,0],
    [leg_width/2,leg_length,leg_end_rad],
    [-leg_width/2,leg_length,leg_end_rad],
    [-leg_width/2,0,0],
    
];

// DISPLAY BOX
display_box_points = [
    [display_box_width/2,battpack_length/2,0],
    [-display_box_width/2,battpack_length/2,0],
    [-display_box_width/2,
      battpack_length/2+display_box_depth,
      display_box_front_cnr_rad],
    [display_box_width/2,
      battpack_length/2+display_box_depth,
      display_box_front_cnr_rad],
];

