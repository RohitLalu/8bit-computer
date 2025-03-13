module button_reg(
    input reset,
    input clk,
    input wire bc, //button for clockwise
    input wire bac,//button for anticlockwise 
    output reg [7:0] button_op,
    input button_read
);

    reg [1:0] ip;
    always @(posedge bc, posedge bac, posedge reset,posedge button_read) begin
    if(button_read) begin
        if(ip!=2'b11) button_op <= {6'b0,ip};
        else button_op<=8'b0;
        ip = 2'b00;
    end
    
    else if(reset) ip<=2'b00;
    else if(bc)
      ip[1] <= bc;  // Assign bc to ip[1]
    else if (bac)
      ip[0] <= bac; // Assign bac to ip[0]
    end
endmodule


//module button_reg(
//    input wire reset,
//    input wire clk,
//    input wire bc,   // Button for clockwise
//    input wire bac,  // Button for anticlockwise
//    input wire button_read,
//    output reg [7:0] button_op
//);

//    reg button1, button2;

//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            button1 <= 1'b0;
//            button2 <= 1'b0;
//        end 
//        else if (bc)  button1 <= 1'b1;  // Set clockwise bit
//        else if (bac) button2 <= 1'b1;  // Set anticlockwise bit
//        else if (button_read) begin
//            button_op <= (button1 || button2) ? {6'b0, button1, button2} : 8'b0;
//            button1 <= 1'b0;  // Clear state after reading
//            button2 <= 1'b0;
//        end
//    end

//endmodule