`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/07 17:46:46
// Design Name: 
// Module Name: imem_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imem_test(
    );
    logic [5:0] a;
    logic [31:0] rd;
    initial a = 6'b000000;
    always
    begin
        #50
        a <= a + 1'b1;
    end
    imem i0(a, rd);
endmodule
