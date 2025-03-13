//Not yet synthesizable

module asm_loader(
    input wire i_clk,
    input wire reset,
    input wire bc, // button for clockwise
    input wire bac, // button for anticlockwise
    output wire [7:0] led_col,
    output wire [7:0] led_row
);

  wire o_clk;

  // Instantiate the clock module
  clock m_clock (
    .i_clk(i_clk),
    .i_halt(reset),
    .o_clk(o_clk)
  );

  // Instantiate the machine module
  machine m_machine (
    .clk(o_clk),
    .reset(reset),
    .bc(bc),
    .bac(bac),
    .led_col(led_col),
    .led_row(led_row)
  );

  // Load the assembly code from the file
  integer file;
  integer i;
  reg [7:0] data;
  initial begin

    file = $fopen("code.txt", "r");
    if (file == 0) begin
      $display("Error: Could not open file code.txt");
      $finish;
    end

    i = 0;
    while (!$feof(file)) begin
      $fscanf(file, "%c", data);
      m_machine.m_ram.memory[i] = data;
      i = i + 1;
    end
    $fclose(file);
  end

endmodule