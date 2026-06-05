module mux2x1(
    input [1:0] x,
    input s,
    output y
);

assign y = (~s & x[0]) | (s & x[1]) ;

endmodule