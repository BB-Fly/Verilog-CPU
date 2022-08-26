`timescale 1ns / 1ps
module controller(input logic clk, reset,
                input logic[5:0] opD, functD,
                input logic equalD, flushE,
                output logic pcsrcD, branchD, jumpD,
                output logic [2:0] alucontrolE,
                output logic regwriteE, memtoregE, alusrcE, regdstE,
                output logic regwriteM, memtoregM, memwriteM,
                output logic regwriteW, memtoregW,
                output logic immextD);
    logic [2:0] aluopD;
    logic [2:0] alucontrolD;
    logic regwriteD, regdstD, alusrcD, memwriteD, memtoregD, branchBneD;
    logic memwriteE;
    
    maindec md(opD, regwriteD, regdstD, alusrcD, branchD, memwriteD, memtoregD, jumpD, aluopD, immextD, branchBneD);
    aludec ad(functD, aluopD, alucontrolD);
    
    assign pcsrcD = (branchD & equalD)|((~equalD)&branchBneD);        
    
    floprc #(8) regE(clk, reset, flushE,
                {memtoregD, memwriteD, alusrcD, regdstD, regwriteD, alucontrolD},
                {memtoregE, memwriteE, alusrcE, regdstE, regwriteE, alucontrolE});
    flopr #(3) regM(clk, reset,
                {memtoregE, memwriteE, regwriteE},
                {memtoregM, memwriteM, regwriteM});
    flopr #(2) regW(clk, reset,
                {memtoregM, regwriteM},
                {memtoregW, regwriteW});           
             
endmodule
