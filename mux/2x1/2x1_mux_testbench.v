module mux2x1_tb();
reg [1:0] x;
reg s;
wire y;

mux2x1 uut(
    .x(x),
    .s(s),
    .y(y)
);

initial begin
    s = 1'b0; x = 1'b00;
    #10 x = 1'b01;
    #10 x = 1'b10;
    #10 x = 1'b11;

    #10 s = 1'b1; x = 1'b00;
    #10 x = 1'b01;
    #10 x = 1'b10;
    #10 x = 1'b11;

    #20 $finish;

end
endmodule

