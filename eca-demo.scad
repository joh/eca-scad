use <eca/eca.scad>

//init = [0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0];
init = [for (i=[0:200]) (i==100) ? 1 : 0];
rule = 22;
steps = len(init);
cell_size = 2;
state = evolve([init], steps, rule);
visualize(state);
