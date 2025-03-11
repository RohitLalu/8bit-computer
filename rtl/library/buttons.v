module button_reg(
    input reset,
    input clk,
    input wire bc, //button for clockwise
    input wire bac,//button for anticlockwise 
    output wire [7:0] button_op,
    input button_read,
);

    reg [1:0] ip;
    always @(posedge bc or posedge bac or reset) begin
    if(reset) ip<=2'b00;
    else begin
      ip[1] <= bc;  // Assign bc to ip[1]
      ip[0] <= bac; // Assign bac to ip[0]
    end

    always @(posedge button_read) begin
        if(ip!=2b'11) assign button_op = {6'b0,ip};
        else assign button_op=8'b0;
        ip = 2b'0;
    end

endmodule