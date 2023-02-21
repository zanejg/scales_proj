



module cyl(){
    cylinder(r=4,h=10);
}

module cb(){
    cube([5,5,20]);
}

module trans(mod){
    rotate([25,30,0]){
        mod();
    }
}

trans(cyl);
trans(cb);
