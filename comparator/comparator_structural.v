module comparator_structural(
    input [1:0] a,
    input [1:0] b,
    output a_equal_b,
    output a_greator_b,
    output a_lower_b
);

wire x[1:0];
assign x = a ~^ b;

assign a_equal_b = x[1] & x[0];
assign a_greater_b = (a[1] & ~b[1]) | (x[1] & a[0] & ~b[0]);
assign a_lower_b =  (~a[1] & b[1]) | (x[1] & ~a[0] & b[0]);

endmodule