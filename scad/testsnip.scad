

module testch(){
    translate([10, 20, 30]){
        rotate([30,20,10]){
            children();
        }
    }
}



testch(){
    cube([10,20,30],center=true);
}



testch(){
    cylinder(h=50,r=5);
}


