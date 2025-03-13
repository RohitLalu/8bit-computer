module fpga_leds(
    input [7:0] row,
    output wire [5:0] LEDs
);
    assign LEDs=row[5:0];
endmodule

    
