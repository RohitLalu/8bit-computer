module machine(
  input wire clk,
  input wire reset,

    input wire bc, //button for clockwise
  input wire bac,//button for anticlockwise
  output reg [7:0] led_x,
  output reg [7:0] led_y
);

  // ==========================
  // CPU
  // ==========================

  wire [7:0] addr_bus;
  wire [7:0] bus;
  wire c_ri;
  wire c_ro;
  wire mem_clk;
  wire mem_io;
  cpu m_cpu (
    .clk(clk),
    .reset(reset),
    .addr_bus(addr_bus),
    .bus(bus),
    .mem_clk(mem_clk),
    .c_ri(c_ri),
    .c_ro(c_ro),
    .mem_io(mem_io)
  );


  // ==========================
  // RAM
  // ==========================

  ram m_ram (
    .clk(mem_clk),
    .addr(addr_bus),
    .data(bus),
    .we(c_ri),
    .oe(c_ro)
  );


  // ==========================
  // DEBUG I/O PERIPHERAL
  // ==========================

  always @ (posedge mem_io & mem_clk) begin
    if (addr_bus == 8'h00)
      $display("Output: %d ($%h)", bus, bus);
    else if (addr_bus == 8'h01)
      $display("Input: set $FF on data bus");
    else
      $display("Unknown I/O on address $%h: %d ($%h)", addr_bus, bus, bus);
  end

  assign bus = (mem_io & mem_clk & (addr_bus == 8'h01)) ? 8'hFF : 8'hZZ;

endmodule


  //Input registers 
  reg [1:0] ip;  // holds the state as follows {bc, bac}
  always @(posedge bc or posedge bac or negedge bc or negedge bac or reset) begin
    if(reset) ip<=2'b00;
    else begin
      ip[1] <= bc;  // Assign bc to ip[1]
      ip[0] <= bac; // Assign bac to ip[0]
    end
  end

  //Output registers
  
