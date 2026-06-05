module encoder4x2_tb();
reg [3:0] in;
wire [1:0] y;

encoder4x2 uut(
    .in(in),
    .y(y)
);

initial begin
    in = 4'b0000;
    #10 in = 4'b0001;
    #10 in = 4'b0010;
    #10 in = 4'b0100;
    #10 in = 4'b1000;
    #20 $finish;
end
endmodule


