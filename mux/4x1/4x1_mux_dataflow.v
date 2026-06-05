module mux4x1(
    input [3:0] x,
    input [1:0] s,
    output reg y
);

assign y = (s[1] & s[0] & x[3]) | (s[1] & ~s[0] & x[2]) | (~s[1] & s[0] & x[1]) | (~s[1] & ~s[0] & x[0]) ;
  
endmodule
