module gen_tb();
reg [3:0] b;
wire [3:0] g;

gen uut(
    .b(b),
    .g(g)
);

initial begin
    b = 4'b0001;
    #10 b = 4'b0010;
    #10 b = 4'b0100;
    #20 $finish ;
end

endmodule