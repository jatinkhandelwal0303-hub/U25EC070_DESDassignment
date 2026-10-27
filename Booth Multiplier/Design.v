
module booth_multiplier #(
    parameter WIDTH = 4
)(
    input  wire signed [WIDTH-1:0] M,
    input  wire signed [WIDTH-1:0] Q,
    output reg signed [(2*WIDTH)-1:0] product
);

    reg signed [WIDTH-1:0] A;
    reg signed [WIDTH-1:0] q;
    reg signed [WIDTH-1:0] m;

    reg q_minus1;

    reg signed [(2*WIDTH):0] combined;

    integer i;

    always @(*) begin

        // Initialize registers
        A        = 0;
        q        = Q;
        m        = M;
        q_minus1 = 1'b0;

        // Booth algorithm
        for (i = 0; i < WIDTH; i = i + 1) begin

            case ({q[0], q_minus1})

                2'b01: A = A + m;

                2'b10: A = A - m;

                default: A = A;

            endcase

            // Combine A, Q and Q-1
            combined = {A, q, q_minus1};

            // Arithmetic right shift
            combined = $signed(combined) >>> 1;

            // Separate the shifted registers
            A        = combined[(2*WIDTH):WIDTH+1];
            q        = combined[WIDTH:1];
            q_minus1 = combined[0];

        end

        // Final 2*WIDTH-bit product
        product = {A, q};

    end

endmodule
