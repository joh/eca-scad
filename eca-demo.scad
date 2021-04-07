use <eca/eca.scad>

//init = [0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0];
init = [for (i=[0:200]) (i==100) ? 1 : 0];
//init = [0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0];
rule = 22;
steps = len(init);
cell_size = 2;
state = evolve([init], steps, rule);
visualize(state);

/*
//echo(evolve([init], steps, rule));
difference() {
cube([cell_size*(len(state[0])+4), cell_size*(len(state)+4), .2]);
translate([2*cell_size,2*cell_size,-.1])
visualize(state, cell_size);
}
*/
