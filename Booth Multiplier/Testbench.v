
`timescale 1ns/1ps

module tb_booth_multiplier;

    reg signed [3:0] M;
    reg signed [3:0] Q;
    wire signed [7:0] product;

    booth_multiplier #(
        .WIDTH(4)
    ) dut (
        .M(M),
        .Q(Q),
        .product(product)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_booth_multiplier);

        // Test 1: 3 * (-2) = -6
        M = 4'sd3;
        Q = -4'sd2;
        #10;

        // Test 2: 5 * 3 = 15
        M = 4'sd5;
        Q = 4'sd3;
        #10;

        // Test 3: (-4) * 3 = -12
        M = -4'sd4;
        Q = 4'sd3;
        #10;

        // Test 4: (-5) * (-3) = 15
        M = -4'sd5;
        Q = -4'sd3;
        #10;

        // Test 5: 7 * 7 = 49
        M = 4'sd7;
        Q = 4'sd7;
        #10;

        $finish;
    end

endmodule
