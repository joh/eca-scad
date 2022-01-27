/*
 * Elementary Cellular Automata in OpenSCAD
 *
 * by Johannes H. Jensen <joh@pseudoberries.com>
 * https://github.com/joh/eca-scad
 *
 * Copyright (c) 2021-2022 by Johannes H. Jensen
 * License: MIT, see LICENSE for more details.
 */

// periodic neighborhood
function neighbors(i, cells) = 
    (i == 0) ? [cells-1, i, i+1] : [i-1, i, (i+1)%cells];

// extract subset of states
function take(state, inds) =
    [for (i=[0:len(inds)-1]) state[inds[i]]];

// a & b
function and(a, b) = 
    (a<1 || b<1) ? 0 : ((a%2>=1) && (b%2>=1) ? 1 : 0) + 2*and(a/2, b/2);

// a << i
function shl(a, i) =
    a * pow(2, i);

// a >> i
function shr(a, i) =
    floor(a / pow(2, i));

function rand_init(n, seed=0) =
    [for (r=rands(0, 2, n, seed)) floor(r)];

// evolve CA n steps from state with rule
function evolve(state, n, rule) =
    (n == 0) ? state :
    concat(state, evolve([[
        for (i=[0:len(state[0])-1])
        let (
            n = neighbors(i, len(state[0])),
            c = take(state[0], n),
            bit = shl(c[0], 2) + shl(c[1], 1) + c[2],
            next = shr(and(rule, shl(1, bit)), bit)//,
            //echo("n", n, "c", c, "bit", bit, "next", next, "rule", rule)
        )
        shr(and(rule, shl(1, bit)), bit)
    ]], n-1, rule));

// visualize CA as cubes
module visualize(state, cell_size=1, pad=0) {
    for (j=[0:len(state)]) {
        for (i=[0:len(state[0])]) {
            if (state[j][i] == 1)
            translate([i*(cell_size+pad), j*(cell_size+pad), 0])
            //cylinder(d=cell_size*.5, center=false, $fn=4);
            cube(cell_size, false);
        }
    }
}
