
`timescale 1ns / 1ps

module tb_up_down_counter;

    reg clk;
    reg rst;
    reg up;
    reg down;

    wire [4:0] count;
    wire [6:0] seg;
    wire [3:0] an;
    wire dp;

    // DUT instantiation
    up_down_counter uut (
        .clk(clk),
        .rst(rst),
        .up(up),
        .down(down),
        .count(count),
        .seg(seg),
        .an(an),
        .dp(dp)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    // Task to generate one button press
    task press_up;
    begin
        up = 1;
        repeat(3) @(posedge clk);
        #1 up = 0;
        repeat(3) @(posedge clk);
    end
    endtask

    task press_down;
    begin
        down = 1;
        repeat(3) @(posedge clk);
        #1 down = 0;
        repeat(3) @(posedge clk);
    end
    endtask

    initial begin

        // Initialize inputs
        clk = 0;
        rst = 0;
        up = 0;
        down = 0;

        $dumpfile("up_down.vcd");
        $dumpvars(0, tb_up_down_counter);

        $monitor("Time=%0t | rst=%b up=%b down=%b | count=%d",
                  $time, rst, up, down, count);

        // TEST 1: Reset
        rst = 1;
        repeat(2) @(posedge clk);
        #1 rst = 0;

        // TEST 2: Up counting (0 to 5)
        repeat(5) press_up();

        // TEST 3: Down counting (5 to 0)
        repeat(5) press_down();

        // TEST 4: Underflow (0 to 19)
        press_down();

        // TEST 5: Overflow (19 to 0)
        rst = 1;
        repeat(2) @(posedge clk);
        #1 rst = 0;

        repeat(19) press_up();
        press_up();

        // TEST 6: Simultaneous button presses
        up = 1;
        down = 1;
        repeat(3) @(posedge clk);
        #1 up = 0;
           down = 0;
        repeat(3) @(posedge clk);

        // TEST 7: Hold UP button
        up = 1;
        repeat(20) @(posedge clk);
        #1 up = 0;
        repeat(3) @(posedge clk);

        $display("Simulation completed");
        $finish;

    end

endmodule

