`include "ram.v"

module led_matrix(
    parameter START=1, END=8,

    input  [7:0] row,// inputs a specific row's information
    input reset,
    input clk,
    output [7:0] counter_addr,led_col,
    output [END:START] led_row
);

    reg [7:0] led_counter;

    always @(posedge clk) begin
        if(reset) led_counter<=START;
        else if(led_counter>END) led_counter<=START;
        else led_counter<=led_counter+1;

        assign counter_addr=led_counter;

        assign led_col=~row;
        assign led_row[led_counter] =1;

    end

endmodule