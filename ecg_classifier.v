`timescale 1ns/1ps

module ecg_classifier(
    input clk,
    input rst,
    input start,
    output reg abnormal_led,
    output reg normal_led,
    output reg done
);

    // Q8.8 signed 16-bit
    reg signed [15:0] features [0:4];
    reg signed [15:0] weights  [0:4];
    reg signed [15:0] bias;

    reg signed [31:0] acc;
    reg [2:0] index;
    reg [2:0] state;

    localparam IDLE     = 3'd0,
               MAC      = 3'd1,
               ADD_BIAS = 3'd2,
               COMPARE  = 3'd3,
               DONE_S   = 3'd4;

    always @(posedge clk) begin

        if (rst) begin
            // Load constants on reset
            features[0] <= -16'sd13;
            features[1] <=  16'sd13;
            features[2] <= -16'sd91;
            features[3] <=  16'sd91;
            features[4] <=  16'sd86;

            weights[0] <=  16'sd25;
            weights[1] <= -16'sd107;
            weights[2] <=  16'sd97;
            weights[3] <= -16'sd18;
            weights[4] <=  16'sd945;

            bias <= -16'sd2243;

            state <= IDLE;
            acc <= 0;
            index <= 0;
            abnormal_led <= 0;
            normal_led <= 0;
            done <= 0;
        end
        else begin
            case(state)

                IDLE: begin
                    done <= 0;
                    if(start) begin
                        acc <= 0;
                        index <= 0;
                        state <= MAC;
                    end
                end

                MAC: begin
                    acc <= acc + (features[index] * weights[index]);

                    if(index == 4)
                        state <= ADD_BIAS;
                    else
                        index <= index + 1;
                end

                ADD_BIAS: begin
                    acc <= acc + (bias <<< 8);
                    state <= COMPARE;
                end

                COMPARE: begin
                    if(acc > 0) begin
                        abnormal_led <= 1;
                        normal_led <= 0;
                    end
                    else begin
                        abnormal_led <= 0;
                        normal_led <= 1;
                    end
                    state <= DONE_S;
                end

                DONE_S: begin
                    done <= 1;
                    state <= IDLE;
                end

            endcase
        end
    end

endmodule
