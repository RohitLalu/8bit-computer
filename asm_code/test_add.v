module custom_processor(
    input clk,
    input [7:0] operand_a,
    input [7:0] operand_b,
    output [7:0] led_out
);
assign led_out = operand_a + operand_b;
endmodule

// Top-level module
module top(
    input clk,
    input [1:0] buttons,
    output [5:0] leds
);

wire [7:0] result;
custom_processor cpu(
    .clk(clk),
    .operand_a(8'h03), // Example inputs
    .operand_b(8'h05),
    .led_out(result)
);

assign leds = result[5:0]; // Map 6 LSBs to LEDs
endmodule
