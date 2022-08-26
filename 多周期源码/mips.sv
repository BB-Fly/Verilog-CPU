//`timescale 1ns / 1ps
//module mips(input logic clk, reset,
//        output logic [31:0] pc,
//        output logic memwrite,
//        output logic[31:0] writedata, addr,
//        input logic [31:0] readdata);
        
//    logic memtoreg, regdst, regwrite, zero,irwrite, alusrca, iord, pcen;
//    logic[1:0] alusrcb, pcsrc;
//    logic[2:0] alucontrol;
//    logic[31:0] instr;
    
//    controller c(clk, reset, instr[31:26], instr[5:0], zero, memwrite, irwrite, regwrite, 
//                alusrca, iord, memtoreg, regdst,pcen,alusrcb, pcsrc,alucontrol);
//    datapath dp(clk, reset, memtoreg, alusrca,regdst, pcen, irwrite, regwrite, 
//                iord, alusrcb, pcsrc, alucontrol, zero, pc, instr, writedata, addr, readdata);
//endmodule

module mips(input logic clk, reset,
        output logic [31:0] pc,
        output logic memwrite,
        output logic[31:0] writedata, addr,
        input logic [31:0] readdata);
        
    logic memtoreg, regdst, regwrite, zero,irwrite, alusrca, iord, pcen,immExt;
    logic[1:0] alusrcb, pcsrc;
    logic[2:0] alucontrol;
    logic[31:0] instr;
    
    controller c(clk, reset, instr[31:26], instr[5:0], zero, memwrite, irwrite, regwrite, 
                alusrca, iord, memtoreg, regdst,pcen,alusrcb, pcsrc,alucontrol,immExt);
    datapath dp(clk, reset, memtoreg, alusrca,regdst, pcen, irwrite, regwrite, 
                iord,immExt, alusrcb, pcsrc, alucontrol, zero, pc, instr, writedata, addr, readdata);
endmodule