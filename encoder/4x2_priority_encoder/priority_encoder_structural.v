module priority_encoder(
    input [3:0] in,
    output [1:0] y
);
wire n1,w1;


  not (n1,in[2]);
  and (w1,n1,in[1]);
  or (y[1],in[2],in[3]);
  or (y[0],w1,in[3]);


endmodule