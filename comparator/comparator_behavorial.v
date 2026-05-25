module comparator_behavorial(
    input a[1:0],
    input b[1:0],
    output reg a_greater_b, 
    output reg a_equal_b,
    output reg a_lower_b
);

a_greater_b = 0;
a_equal_b = 0;
a_lower_b = 0;

always@(*) begin 

    if(a>b) begin
        a_greater_b = 1;
    end

    else if(a<b) begin
        a_lower_b = 1;
    end

    else begin
        a_equal_b = 1;
    end

end
endmodule

