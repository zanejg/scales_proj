use <MCAD/regular_shapes.scad>
include <Round-Anything/polyround.scad>
include <utils.scad>
//include <base01.scad>

$fn=50;



module wand(){
    hull(){
        translate([-50,0,0]){
            sphere(10);
        }
        translate([50,0,0]){
            sphere(10);
        }
    };
}


hull(){
    translate([0,50,50]){wand();};
    translate([0,-50,0]){wand();};

    translate([0,50,0]){
        cube([100,10,10],center=true);
    }
};


