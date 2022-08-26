`timescale 1ns / 1ps
//module datapath(input logic clk, reset,memtoreg, pcsrc, alusrc, regdst, regwrite, jump,
//            input logic [2:0] alucontrol,
//            output logic zero,
//            output logic [31:0] pc,
//            input logic [31:0] instr,
//            output logic [31:0] aluout, writedata,
//            input logic [31:0] readdata);
            
//    logic [4:0] writereg;
//    logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch, signimm, signimmsh,srca,srcb,result;
    
//    flopr #(32) pcreg(clk, reset, pcnext, pc);
//    adder pcadd1(pc, 32'b100, pcplus4);
//    sl2 immsh(signimm, signimmsh);
//    adder pcadd2(pcplus4, signimmsh, pcbranch);
//    mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);
//    mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
    
//    regfile rf(clk, regwrite, instr[25:21], instr[20:16], writereg, result, srca, writedata);
//    mux2 #(5) wrmux(instr[20:16], instr[15:11], regdst, writereg);
//    mux2 #(32) resmux(aluout, readdata, memtoreg, result);
//    signext se(instr[15:0], signimm);
    
//    mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb);
//    alu alu(srca, srcb, alucontrol, aluout, zero);
                
//endmodule

module datapath(input logic clk, reset,memtoreg, pcsrc, alusrc, regdst, regwrite, jump, immext,
            input logic [2:0] alucontrol,
            output logic zero,
            output logic [31:0] pc,
            input logic [31:0] instr,
            output logic [31:0] aluout, writedata,
            input logic [31:0] readdata);
            
    logic [4:0] writereg;
    logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch, signimm, zeroimm, imm, signimmsh,srca,srcb,result;
    
    flopr #(32) pcreg(clk, reset, pcnext, pc);
    adder pcadd1(pc, 32'b100, pcplus4);
    
    sl2 immsh(signimm, signimmsh);
    
    adder pcadd2(pcplus4, signimmsh, pcbranch);
    
    mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);
    mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
    
    regfile rf(clk, regwrite, instr[25:21], instr[20:16], writereg, result, srca, writedata);
    mux2 #(5) wrmux(instr[20:16], instr[15:11], regdst, writereg);
    mux2 #(32) resmux(aluout, readdata, memtoreg, result);
    
    mux2 #(32) extmux(signimm,zeroimm, immext, imm);
    signext se(instr[15:0], signimm);
    zeroext ze(instr[15:0], zeroimm);
    
    mux2 #(32) srcbmux(writedata, imm, alusrc, srcb);
    alu alu(srca, srcb, alucontrol, aluout, zero);
                
endmodule