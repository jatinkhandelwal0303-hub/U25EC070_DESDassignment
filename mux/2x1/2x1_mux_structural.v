module mux2x1(
    input [1:0] x,
    input s,
    output y
);

wire w1,w2,w3;

not (w1,s);
and (w2,w1,x[0]);
and (w3,s,x[1]);

or(y,w2,w3);

endmodule