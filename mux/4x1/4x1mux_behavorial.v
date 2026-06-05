module 4x1mux(
    input [3:0] x,
    input [1:0] s,
    output reg y
);

always @(*) begin
    if(s = 2'b00) begin
        y = x[0];
    end 
    else if(s = 2'b01) begin
        y = x[1];
    end 
    else if(s = 2'b10) begin
        y = x[2];
    end
    else begin
        y = x[3];
    end

end

endmodule
