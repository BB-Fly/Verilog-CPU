`timescale 1ns / 1ps
module datapath(input logic clk, reset,
                input logic[31:0] instrF,
                input logic pcsrcD, branchD, jumpD, immextD,
                input logic[2:0] alucontrolE,
                input logic regwriteE, memtoregE, alusrcE, regdstE,
                input logic[31:0]readdataM,
                input logic regwriteM, memtoregM,
                input logic regwriteW, memtoregW,
                output logic[31:0] pcF,
                output logic[5:0] opD, functD,
                output logic equalD,
                output logic flushE,
                output logic[31:0]aluoutM, writedataM);
            
    logic stallF, flushD, stallD;
    logic forwardaD, forwardbD;
    logic [1:0] forwardaE, forwardbE;
    logic [4:0] rsD, rtD, rdD, rsE, rtE, rdE;
    logic [4:0] writeregE, writeregM, writeregW;
    logic[31:0] pcnextFD, pcnextbrFD, pcplus4F, pcbranchD;
    logic[31:0] signimmD, signimmshD, zeroimmD, immD, immE;
    logic[31:0] srcaD, srca2D, srcaE, srca2E;
    logic[31:0] srcbD, srcb2D, srcbE, srcb2E, srcb3E;
    logic[31:0] pcplus4D, instrD;
    logic[31:0] aluoutE, aluoutW;
    logic[31:0] readdataW, resultW;
    
    hazard h(rsD, rtD, rsE, rtE,
            writeregE, writeregM, writeregW,
            regwriteE, regwriteM, regwriteW,
            memtoregE, memtoregM, branchD,
            forwardaD, forwardbD,
            forwardaE, forwardbE,
            stallF, stallD, flushE);
            
    mux2 #(32) pcbrmux(pcplus4F, pcbranchD, pcsrcD, pcnextbrFD);
    mux2 #(32) pcmux(pcnextbrFD, {pcplus4D[31:28], instrD[25:0], 2'b00},jumpD, pcnextFD);
    
    regfile rf(clk, regwriteW, rsD, rtD, writeregW, resultW, srcaD, srcbD);
    
    flopenr #(32) pcreg(clk, reset, ~stallF, pcnextFD, pcF);
    adder pcadd1(pcF, 32'b100, pcplus4F);
    
    flopenr #(32) r1D(clk, reset, ~stallD, pcplus4F, pcplus4D);
    flopenrc #(32) r2D(clk, reset, ~stallD, flushD, instrF, instrD);
    
    signext se(instrD[15:0], signimmD);
    zeroext ze(instrD[15:0], zeroimmD);
    sl2 immsh(signimmD, signimmshD);
    adder pcadd2(pcplus4D, signimmshD, pcbranchD);
    
    mux2 #(32) extmux(signimmD, zeroimmD, immextD, immD);
    
    mux2 #(32) forwardadmux(srcaD, aluoutM, forwardaD, srca2D);
    mux2 #(32) forwardbdmux(srcbD, aluoutM, forwardbD, srcb2D);
    
    eqcmp comp(srca2D, srcb2D, equalD);
    
    assign opD = instrD[31:26];
    assign functD = instrD[5:0];
    assign rsD = instrD[25:21];
    assign rtD = instrD[20:16];
    assign rdD = instrD[15:11];
    assign flushD = pcsrcD | jumpD;
    
    floprc #(32) r1E(clk, reset, flushE, srcaD, srcaE);
    floprc #(32) r2E(clk, reset, flushE, srcbD, srcbE);
    floprc #(32) r3E(clk, reset, flushE, immD, immE);
    
    floprc #(5) r4E(clk, reset, flushE, rsD, rsE);
    floprc #(5) r5E(clk, reset, flushE, rtD, rtE);
    floprc #(5) r6E(clk, reset, flushE, rdD, rdE);
    
    mux3 #(32) forwardaemux(srcaE, resultW, aluoutM, forwardaE, srca2E);
    mux3 #(32) forwardbemux(srcbE, resultW, aluoutM, forwardbE, srcb2E);
    
    mux2 #(32) srcbmux(srcb2E, immE, alusrcE, srcb3E);
    mux2 #(5) wrmux(rtE, rdE, regdstE, writeregE);
    
    alu alu(srca2E, srcb3E, alucontrolE, aluoutE);
    
    flopr #(32) r1M(clk, reset, srcb2E, writedataM);
    flopr #(32) r2M(clk, reset, aluoutE, aluoutM);
    flopr #(5) r3M(clk, reset, writeregE, writeregM);
    
    flopr #(32) r1W(clk, reset, readdataM, readdataW);
    flopr #(32) r2W(clk, reset, aluoutM, aluoutW);
    flopr #(5) r3W(clk, reset, writeregM, writeregW);
    
    mux2 #(32) resmux(aluoutW, readdataW, memtoregW, resultW);
                
endmodule