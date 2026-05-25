module fa_structural(
    input a,b,cin,
    output sum,cout
);

wire n1,n2,n3;

xor(n1,a,b);
xor(sum,n1,cin);
and(n2,a,b);
and(n3,cin,n1);
or(cout,n2,n3);

endmodule