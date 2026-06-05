module encoder4x2(
    input [3:0] in,
    output [1:0] y
);

  assign y[0] = in[1] + in[3] ;
  assign y[1] = in[2] + in[3] ;

endmodule