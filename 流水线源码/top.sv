//`timescale 1ns / 1ps
//module top(input logic clk, reset,
//            output logic [31:0] writedata, dataadr,
//            output logic memwrite);
//    logic [31:0] pc, instr, readdata;
//    mips mips(clk, reset, instr, readdata, pc, memwrite, dataadr, writedata);
//    imem imem(pc[7:2], instr);
//    dmem dmem(clk, memwrite, dataadr, writedata, readdata);          
//endmodule

module top(input logic CLK100MHZ, BTNC,BTNL, BTNR,
            input logic [15:0] SW,
            output logic [7:0] AN,
            output logic DP,
            output logic [6:0] A2G);
            
    logic [31:0] writeData, dataAdr;
    logic Write;
    logic [31:0] pc, instr, readData;
    
    logic IOclock;
    assign IOclock = ~CLK100MHZ;
    
    mips mips(CLK100MHZ, BTNC, instr, readData, pc, Write, dataAdr, writeData);
    imem imem(pc[7:2], instr);
    DataMemoryDecord DataMemoryDecord(CLK100MHZ, Write, dataAdr, writeData, readData, IOclock, BTNC, BTNL, BTNR, SW, AN, DP, A2G);    
          
endmodule
