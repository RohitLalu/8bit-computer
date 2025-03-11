module machine(
  input wire clk,
  input wire reset,

    input wire bc, //button for clockwise
  input wire bac,//button for anticlockwise
  output reg [7:0] led_col,
  output reg [7:0] led_row
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
  wire mem_io;  //WHat is mem_io

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
    .oe(c_ro),

    .counter_addr(counter_addr),
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

led_matrix led_mat(
  .row(row),
  .reset(reset),
  .clk(clk),
  .counter_addr(counter_addr),
  .led_col(led_col),
  .led_row(led_row)
);



endmodule


  
