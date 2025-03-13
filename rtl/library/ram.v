/*
module ram(
  input wire clk,
  input wire [7:0] addr,
  input wire we,               // Write Enable (write if we is high else read)
  input wire oe,               // Enable Output
  inout wire [7:0] data,

  input counter_addr,  // These 2 are for LED outputs, I am directly interfacing from RAM
  output [7:0] row,
  input reset,
  input button_read,
  input wire [7:0] button_op  //Inputs save their most recent data into mem[0]
);

  reg [7:0] mem [0:20];  
//  reg [7:0] buffer;

  always @(posedge clk or posedge button_read or posedge reset) begin
  if(button_read)
    mem[0]<=button_op;
  else if(reset) 
    if (we) begin
      mem[addr] <= data;
//      $display("Memory: set [0x%h] => 0x%h (%d)", addr, data, data);
    end 
//else begin
//      buffer <= mem[addr];
//    end
  end
  
  assign row=mem[counter_addr];
  assign data = (clk & oe & !we) ? mem[addr] : 8'bz;
endmodule
*/
module ram (
  // Control signals
  input wire clk,
  input wire reset,
  input wire we,         // Write Enable: Write if high, Read if low
  input wire oe,         // Output Enable: Control data bus
  input wire button_read, // Reads button state into memory

  // Address and Data Bus
  input wire [7:0] addr,
  inout wire [7:0] data,

  // Button Input (Saves to mem[0])
  input wire [7:0] button_op,

  // LED Output
  input wire [7:0] counter_addr,
  output wire [7:0] row
);
  // Internal memory (256 bytes)
    reg [7:0] mem [0:255];

    assign data = (oe && !we) ? mem[addr] : 8'bZ;

    integer i;
    initial begin
    for (i = 0; i < 256; i = i + 1) begin
        mem[i] <= 8'b00000000;
      end
    end
  // Memory Read/Write Logic
    always @(posedge clk or posedge button_read) begin
        if (button_read) begin
            mem[0] <= button_op;  // Save button input to memory[0]
        end else if (we) begin
            mem[addr] <= data;  // Write data to memory
        end
    end
    assign row = mem[counter_addr];

endmodule
