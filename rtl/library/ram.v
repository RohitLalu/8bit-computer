module ram(
  input wire clk,
  input wire [7:0] addr,
  input wire we,               // Write Enable (write if we is high else read)
  input wire oe,               // Enable Output
  inout wire [7:0] data,

  input counter_addr,  // These 2 are for LED outputs, I am directly interfacing from RAM
  output row,
  
  input button_read,
  input button_op  //Inputs save their most recent data into mem[0]
);

  reg [7:0] mem [0:255];  
  reg [7:0] buffer;

  always @(posedge clk) begin
    if (we) begin
      mem[addr] <= data;
//      $display("Memory: set [0x%h] => 0x%h (%d)", addr, data, data);
    end else begin
      buffer <= mem[addr];
    end
    if(button_read) mem[0] =button_op;
  end

  assign data = (oe & ~we) ? buffer : 'bz;

  assign row=mem[counter_addr];

  always @(posedge button_read) begin // if input should be read
    mem[0]<=button_op;
  end

endmodule
