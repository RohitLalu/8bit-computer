module led_matrix(
    input  [7:0] row,// inputs a specific row's information
    input reset,
    input clk,
    output wire  [7:0] counter_addr,led_col,
    output wire [END:START] led_row
);
    parameter START=1, END=8;


    reg [7:0] led_counter=START;

    always @(posedge clk) begin
        if(reset) led_counter<=START;
        else if(led_counter>END) led_counter<=START;
        else led_counter<=led_counter+1;



    end
    
    assign counter_addr=clk&led_counter;

    assign led_col=clk&(~row);
    assign led_row =8'b0 |(1'b1<<led_counter);//=clk&(1'b1);
endmodule