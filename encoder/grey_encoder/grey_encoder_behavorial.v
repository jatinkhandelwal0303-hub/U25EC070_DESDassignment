module gen (
    input [3:0] b,
    output reg [3:0] g

);

always@(*) begin
    g[3] = b[3];

    for(i = 2; i>=0; i = i-1) begin
        g[i] = b[i]^b[i+1] ;
    end
end

endmodule
