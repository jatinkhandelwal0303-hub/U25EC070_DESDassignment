module(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output reg [3:0] sum,
    output reg cout
);
reg c1,c2,c3;

always@(*) begin
    sum[0] = a[0]^b[0]^cin;
    c1 = (a[0] & b[0]) | (cin &(a[0] ^ b[0]));
    
    sum[1] = a[1] ^ b[1] ^ c1;
    c2 = (a[1] & b[1]) | (c1 & (a[1] ^ b[1]));

    sum[2] = a[2] ^ b[2] ^ c2;
    c3 = (a[2] & b[2]) | (c2 & (a[2] ^ b[2]));

    sum[3] = a[3] ^ b[3] ^ c3;
    cout = (a[3] & b[3]) | (c3 & (a[3] ^ b[3]));
end

endmodule
