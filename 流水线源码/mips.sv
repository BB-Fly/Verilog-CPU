`timescale 1ns / 1ps
module mips(input logic clk, reset,
        input logic [31:0] instrF, readdataM,
        output logic [31:0] pcF,
        output logic memwriteM,
        output logic[31:0] aluoutM, writedataM);
        
    logic[5:0] opD,functD;   
    logic pcsrcD, equalD, branchD, jumpD, immextD;
    logic memtoregE, memtoregM, memtoregW;
    logic regwriteE, regwriteM, regwriteW;
    logic regdstE, alusrcE, flushE;
    logic[2:0] alucontrolE;
    
    controller c(clk, reset,
                opD, functD, equalD,
                flushE,
                pcsrcD, branchD, jumpD,
                alucontrolE,
                regwriteE, memtoregE, alusrcE, regdstE,
                regwriteM, memtoregM, memwriteM,
                regwriteW, memtoregW,
                immextD);
                
    datapath dp(clk, reset, instrF,
                pcsrcD, branchD, jumpD, immextD,
                alucontrolE,
                regwriteE, memtoregE, alusrcE, regdstE,
                readdataM,
                regwriteM, memtoregM,
                regwriteW, memtoregW,
                pcF,
                opD, functD, equalD,
                flushE,
                aluoutM, writedataM);
endmodule
