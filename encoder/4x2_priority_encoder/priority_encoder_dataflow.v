module priority_encoder(
    input [3:0] in,
    output [1:0] y
);

assign y[1] = in[2] | in[3] ;
assign y[0] = in[3] | ~in[2]&in[1] ;



endmodule