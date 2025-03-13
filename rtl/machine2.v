//Include this just to test the functioning of the fpga internal leds.

module machine(
  input wire clk,
  input wire reset,

    input wire bc, //button for clockwise
  input wire bac,//button for anticlockwise
  output wire leds
);

/*NOTE:
Let us assume that every one second, our game refreshes and the
snake moves 1 LED forward. So we need to read from input registers at that
1 second, and refresh output registers every 1 second. 

*/
/*
TODO :
- Specify input and output registers properly.
- The control logic should be able to load data from input registers to local registers
and write data to output registers.
- (Writing this in the CPU also is the same headache I believe.)
*/
//Instantiations

//CPU
  wire [7:0] addr_bus;
  wire [7:0] bus;
  wire c_ri;
  wire c_ro;
  wire mem_clk;
//  wire mem_io;  //WHat is mem_io

//I/O ports
  wire [7:0] row, counter_addr;
  wire button_read;
  wire [7:0] button_op;


  // ==========================
  // CPU
  // ==========================

  cpu m_cpu (
    .clk(clk),
    .reset(reset),
    .addr_bus(addr_bus),
    .bus(bus),
    .mem_clk(mem_clk),
    .c_ri(c_ri),
    .c_ro(c_ro),
    .button_read(button_read)
  );


  // ==========================
  // RAM
  // ==========================

  ram m_ram (
    .clk(mem_clk),
    .addr(addr_bus),
    .data(bus),
    .we(c_ri),
    .oe(c_ro),
    .reset(reset),
    .row(row),
    .button_read(button_read),
    .button_op(button_op)
  );


//Input ports

button_reg button_register(
  .reset(reset),
  .clk(clk),
  .bc(bc),
  .bac(bac),
  .button_op(button_op),
  .button_read(button_read)
);

//Output ports

fpga_leds fpga_led(
    .row(row),
    .LEDs(leds)
);



endmodule