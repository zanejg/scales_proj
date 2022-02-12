// this function takes the passed vector and reduces its absolute number
// by num thereby moving the number closer to zero and producing
// a shape that can be used for a negative for boxes etc
function reduce_num(vec,num) =[for (i = [0:len(vec)-1]) 
                                if (vec[i]<0)vec[i]+num
                                else  if (vec[i]==0)  vec[i]
                                        else   vec[i]-num];

// this function takes an array of vectors and applies the reduce_num
// function to it
function scale_points(the_points,num) = [for (i=[0:len(the_points)-1]) 
                                        reduce_num(the_points[i],num)];




