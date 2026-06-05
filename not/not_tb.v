module not_gate_tb ;
reg a;
wire y;

not_gate uut(
    .a(a),
    .y(y)
);

initial begin
        a = 0 ;
    #10 a = 1 ;
    #20 $finish ;
end

endmodule