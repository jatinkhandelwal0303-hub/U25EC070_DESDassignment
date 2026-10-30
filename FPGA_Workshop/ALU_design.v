
module alu_16 (
    input  signed [5:0] A,
    input  signed [5:0] B,
    input         [3:0] Inst,

    output reg signed [11:0] Result,
    output reg Negative,
    output reg Zero,
    output reg Overflow
);

    reg signed [5:0] temp;
    reg signed [11:0] a_ext;
    reg signed [11:0] b_ext;

    reg signed [11:0] square_temp;
    reg signed [17:0] cube_temp;

    reg signed [18:0] shift_temp;

    reg [5:0] rot_temp;
    reg [2:0] shift_amt;
    reg [2:0] rot_amt;

    always @(*) begin

        // Sign extension
        a_ext = {{6{A[5]}}, A};
        b_ext = {{6{B[5]}}, B};

        // Default values
        Result = 12'sd0;
        Negative = 1'b0;
        Zero = 1'b0;
        Overflow = 1'b0;

        temp = 6'sd0;
        square_temp = 12'sd0;
        cube_temp = 18'sd0;
        shift_temp = 19'sd0;
        rot_temp = 6'd0;

        shift_amt = B[2:0];
        rot_amt = B[2:0] % 6;

        case (Inst)

            // 0000 : ADD
            4'b0000: begin
                temp = A + B;
                Result = a_ext + b_ext;

                Overflow = (~A[5] & ~B[5] & temp[5])
                         | ( A[5] &  B[5] & ~temp[5]);
            end

            // 0001 : SUB
            4'b0001: begin
                temp = A - B;
                Result = a_ext - b_ext;

                Overflow = ( A[5] & ~B[5] & ~temp[5])
                         | (~A[5] &  B[5] &  temp[5]);
            end

            // 0010 : MULTIPLICATION
            4'b0010: begin
                Result = a_ext * b_ext;
            end

            // 0011 : AND
            4'b0011: begin
                Result = a_ext & b_ext;
            end

            // 0100 : OR
            4'b0100: begin
                Result = a_ext | b_ext;
            end

            // 0101 : XOR
            4'b0101: begin
                Result = a_ext ^ b_ext;
            end

            // 0110 : NOT A
            4'b0110: begin
                Result = ~a_ext;
            end

            // 0111 : MOV B
            4'b0111: begin
                Result = b_ext;
            end

            // 1000 : ARITHMETIC LEFT SHIFT
            4'b1000: begin
                shift_temp = {{13{A[5]}}, A} <<< shift_amt;

                Result = shift_temp[11:0];

                Overflow = (shift_temp[18:12] !=
                            {7{shift_temp[11]}});
            end

            // 1001 : ARITHMETIC RIGHT SHIFT
            4'b1001: begin
                Result = a_ext >>> shift_amt;
            end

            // 1010 : REMAINDER
            4'b1010: begin
                if (B != 0)
                    Result = $signed(A) % $signed(B);
                else begin
                    Result = 12'sd0;
                    Overflow = 1'b1;
                end
            end

            // 1011 : DIVISION
            4'b1011: begin
                if (B != 0)
                    Result = $signed(A) / $signed(B);
                else begin
                    Result = 12'sd0;
                    Overflow = 1'b1;
                end
            end

            // 1100 : CUBE A
            4'b1100: begin
                square_temp = A * A;
                cube_temp = square_temp * A;

                Result = cube_temp[11:0];

                Overflow = (cube_temp > 18'sd2047) ||
                           (cube_temp < -18'sd2048);
            end

            // 1101 : ROTATE LEFT
            4'b1101: begin
                rot_temp = (A << rot_amt) |
                           (A >> (6 - rot_amt));

                Result = {{6{rot_temp[5]}}, rot_temp};
            end

            // 1110 : ROTATE RIGHT
            4'b1110: begin
                rot_temp = (A >> rot_amt) |
                           (A << (6 - rot_amt));

                Result = {{6{rot_temp[5]}}, rot_temp};
            end

            // 1111 : NO OPERATION
            4'b1111: begin
                Result = 12'sd0;
            end

            default: begin
                Result = 12'sd0;
            end

        endcase

        // Status flags
        Negative = Result[11];
        Zero = (Result == 12'sd0);

    end

endmodule

