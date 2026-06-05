module 2x1mux(
    input [1:0] x,
    input s,
    output reg y
);

always @(*) begin
    if(s = 1'b1) begin
        y = x[1];
    end 
    else begin
        y = x[0];
    end

end

endmodule

