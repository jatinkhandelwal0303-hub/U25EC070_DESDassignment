
module up_down_counter (
    input clk,
    input rst,
    input up,
    input down,

    output reg [4:0] count,
    output reg [6:0] seg,
    output reg [3:0] an,
    output dp
);

    // Synchronize push buttons to the FPGA clock
    reg up_meta, up_sync, up_prev;
    reg down_meta, down_sync, down_prev;

    always @(posedge clk) begin
        up_meta   <= up;
        up_sync   <= up_meta;
        up_prev   <= up_sync;

        down_meta <= down;
        down_sync <= down_meta;
        down_prev <= down_sync;
    end

    wire up_pulse   = up_sync   & ~up_prev;
    wire down_pulse = down_sync & ~down_prev;

    // Up-down counter: 0 to 19
    always @(posedge clk) begin
        if (rst)
            count <= 5'd0;

        else if (up_pulse && !down_pulse) begin
            if (count == 5'd19)
                count <= 5'd0;
            else
                count <= count + 1'b1;
        end

        else if (down_pulse && !up_pulse) begin
            if (count == 5'd0)
                count <= 5'd19;
            else
                count <= count - 1'b1;
        end
    end

    // Convert count into tens and units
    wire [3:0] tens;
    wire [3:0] units;

    assign tens  = count / 10;
    assign units = count % 10;

    // Refresh counter for multiplexed displays
    reg [16:0] refresh_counter = 0;

    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1'b1;
    end

    reg [3:0] digit;

    // Select the first two displays
    always @(*) begin
        case (refresh_counter[16])
            1'b0: begin
                an = 4'b1110;  // Rightmost display: units
                digit = units;
            end

            1'b1: begin
                an = 4'b1101;  // Next display: tens
                digit = tens;
            end
        endcase
    end

    // Seven-segment decoder
    // seg = {g, f, e, d, c, b, a}
    // Active-low segments: 0 means ON
    always @(*) begin
        case (digit)
            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;
            default: seg = 7'b1111111;
        endcase
    end

    assign dp = 1'b1; // Decimal point OFF

endmodule

