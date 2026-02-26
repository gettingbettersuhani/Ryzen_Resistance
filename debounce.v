module debounce (
    input clk,
    input noisy_btn,
    output reg clean_pulse
);

    parameter MAX_COUNT = 1_000_000; // 10ms @100MHz

    reg [19:0] count = 0;
    reg sync0 = 0, sync1 = 0;
    reg stable = 0, prev = 0;

    always @(posedge clk) begin
        sync0 <= noisy_btn;
        sync1 <= sync0;

        if(sync1 == stable)
            count <= 0;
        else if(count < MAX_COUNT)
            count <= count + 1;
        else begin
            stable <= sync1;
            count <= 0;
        end

        clean_pulse <= stable & ~prev;
        prev <= stable;
    end

endmodule
