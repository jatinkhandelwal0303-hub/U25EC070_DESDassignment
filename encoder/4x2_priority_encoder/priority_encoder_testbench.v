module priority_encoder_tb();

reg [3:0] in;
wire [1:0] y;

priority_encoder uut(
    .in(in),
    .y(y)
);

initial begin
    in = 4'b0000;
    #10 in = 4'b0001;
    #10 in = 4'b0011;
    #10 in = 4'b0010;
    #10 in = 4'b0100;
    #10 in = 4'b0111;
    #10 in = 4'b1101;
    #10 in = 4'b1000;

    #20 $finish;

end

endmodule