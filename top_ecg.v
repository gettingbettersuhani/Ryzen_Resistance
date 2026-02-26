module top_ecg(
    input clk,       // 100 MHz
    input btnC,      // Reset
    input btnU,      // Start
    output led0,     // Abnormal
    output led1      // Normal
);

    wire rst_clean;
    wire start_clean;
    wire done_wire;

    debounce db_rst(
        .clk(clk),
        .noisy_btn(btnC),
        .clean_pulse(rst_clean)
    );

    debounce db_start(
        .clk(clk),
        .noisy_btn(btnU),
        .clean_pulse(start_clean)
    );

    ecg_classifier core(
        .clk(clk),
        .rst(rst_clean),
        .start(start_clean),
        .abnormal_led(led0),
        .normal_led(led1),
        .done(done_wire)
    );

endmodule
