module clock
(
  input wire i_clk,
  input wire i_halt,
  output reg o_clk
);
localparam WAIT_TIME = 130000;
reg [23:0] clockCounter = 0;

initial o_clk = 1'b0;

always @(posedge i_clk) begin
  if (i_halt == 1'b0) begin
    clockCounter = clockCounter + 1;
    if (clockCounter == WAIT_TIME) begin
      o_clk = ~o_clk;
      clockCounter = 0;
    end
  end else begin
    o_clk = 1'b0;
  end
end
endmodule
