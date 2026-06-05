module xor_gate(
    input a,
    input b,
    output y
);

wire n1,n2,n3;

nand(n1,a,b);
nand(n2,a,n1);
nand(n3,b,n1);
nand(y,n2,n3);


endmodule