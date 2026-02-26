`timescale 1ns/1ps

module ecg_classifier_tb;

    reg clk = 0;
    reg rst = 0;
    reg start = 0;

    wire abnormal_led;
    wire normal_led;
    wire done;

    // DUT
    ecg_classifier uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .abnormal_led(abnormal_led),
        .normal_led(normal_led),
        .done(done)
    );

    // 100 MHz clock
    always #5 clk = ~clk;

    initial begin

        // Apply reset
        rst = 1;
        repeat(3) @(posedge clk);
        rst = 0;

        // Start pulse (1 clock cycle)
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;

        // Wait for done
        wait(done);

        @(posedge clk);

        $display("=================================");
        $display("Classification Completed");
        $display("Abnormal LED = %b", abnormal_led);
        $display("Normal LED   = %b", normal_led);
        $display("=================================");

        #20;
        $finish;
    end

endmodule
