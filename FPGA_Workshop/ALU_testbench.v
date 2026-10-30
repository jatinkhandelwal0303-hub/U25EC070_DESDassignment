
`timescale 1ns / 1ps

module tb_alu_16;

    reg signed [5:0] A;
    reg signed [5:0] B;
    reg [3:0] Inst;

    wire signed [11:0] Result;
    wire Negative, Zero, Overflow;

    // DUT instantiation
    alu_16 uut (
        .A(A),
        .B(B),
        .Inst(Inst),
        .Result(Result),
        .Negative(Negative),
        .Zero(Zero),
        .Overflow(Overflow)
    );

    // Task to apply inputs
    task apply;
        input signed [5:0] a;
        input signed [5:0] b;
        input [3:0] instruction;

        begin
            A = a;
            B = b;
            Inst = instruction;

            #10;

            $display(
                "Time=%0t | Inst=%b | A=%d | B=%d | Result=%d | N=%b Z=%b V=%b",
                $time, Inst, A, B, Result,
                Negative, Zero, Overflow
            );
        end
    endtask

    initial begin

        $dumpfile("alu.vcd");
        $dumpvars(0, tb_alu_16);

        $display("-----------------------------------------------");
        $display("          ALU SIMULATION STARTED");
        $display("-----------------------------------------------");

        // 1. ADD
        apply(6'sd10, 6'sd5, 4'b0000);

        // 2. SUB
        apply(6'sd10, 6'sd5, 4'b0001);

        // 3. MULTIPLICATION
        apply(6'sd6, 6'sd5, 4'b0010);

        // 4. AND
        apply(6'sd6, 6'sd3, 4'b0011);

        // 5. OR
        apply(6'sd6, 6'sd3, 4'b0100);

        // 6. XOR
        apply(6'sd6, 6'sd3, 4'b0101);

        // 7. NOT A
        apply(6'sd5, 6'sd3, 4'b0110);

        // 8. MOV B
        apply(6'sd10, -6'sd5, 4'b0111);

        // 9. ARITHMETIC LEFT SHIFT
        apply(6'sd5, 6'sd2, 4'b1000);

        // 10. ARITHMETIC RIGHT SHIFT
        apply(-6'sd8, 6'sd2, 4'b1001);

        // 11. REMAINDER
        apply(-6'sd17, 6'sd3, 4'b1010);

        // 12. DIVISION
        apply(-6'sd17, 6'sd3, 4'b1011);

        // 13. CUBE
        apply(6'sd5, 6'sd2, 4'b1100);

        // 14. ROTATE LEFT
        apply(6'b100101, 6'sd2, 4'b1101);

        // 15. ROTATE RIGHT
        apply(6'b100101, 6'sd2, 4'b1110);

        // 16. NO OPERATION
        apply(6'sd10, 6'sd5, 4'b1111);


        // Additional overflow tests

        $display("-----------------------------------------------");
        $display("          ADDITIONAL TESTS");
        $display("-----------------------------------------------");

        // Addition overflow
        apply(6'sd31, 6'sd1, 4'b0000);

        // Subtraction overflow
        apply(-6'sd32, 6'sd1, 4'b0001);

        // Cube overflow
        apply(-6'sd13, 6'sd0, 4'b1100);

        // Division by zero
        apply(6'sd10, 6'sd0, 4'b1011);

        // Remainder by zero
        apply(6'sd10, 6'sd0, 4'b1010);

        $display("-----------------------------------------------");
        $display("          SIMULATION COMPLETED");
        $display("-----------------------------------------------");

        $finish;

    end

endmodule

