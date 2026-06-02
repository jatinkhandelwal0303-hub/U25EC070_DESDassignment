module fa(
    input a,b,cin,
    output sum,cout
);

assign sum = a^b^c;
assign cout = a&b | (cin&(a^b));

endmodule
