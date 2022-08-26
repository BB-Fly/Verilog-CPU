//`timescale 1ns / 1ps
//module controller(input logic clk, reset,
//                input logic [5:0] op, funct,
//                input logic zero,
//                output logic memwrite, irwrite, regwrite, alusrca, iord, memtoreg, regdst, PCEn,
//                output logic [1:0] alusrcb, pcsrc,
//                output logic [2:0] alucontrol);
                
//    logic [1:0] aluop;
//    logic pcwrite, branch;
    
//    maindec md(clk, reset, op, pcwrite, memwrite, irwrite, regwrite, alusrca, branch, iord, memtoreg, regdst, alusrcb, pcsrc, aluop);
//    aludec ad(funct, aluop, alucontrol);
//    assign PCEn = (branch & zero)|pcwrite;   
             
//endmodule
module controller(input logic clk, reset,
                input logic [5:0] op, funct,
                input logic zero,
                output logic memwrite, irwrite, regwrite, alusrca, iord, memtoreg, regdst, PCEn,
                output logic [1:0] alusrcb, pcsrc,
                output logic [2:0] alucontrol,
                output logic immExt);
                
    logic [2:0] aluop;
    logic pcwrite, branch, branchBne;
    
    maindec md(clk, reset, op, pcwrite, memwrite, irwrite, regwrite, alusrca, branch,
     iord, memtoreg, regdst, alusrcb, pcsrc, aluop,immExt, branchBne);
    aludec ad(funct, aluop, alucontrol);
    assign PCEn = (branch & zero)|((~zero) & branchBne)|pcwrite;
             
endmodule
