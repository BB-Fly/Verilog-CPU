//`timescale 1ns / 1ps
//module datapath(input logic clk, reset,memtoreg, alusrca, regdst, pcen, irwrite, regwrite,iord,
//            input logic [1:0]alusrcb,pcsrc,
//            input logic [2:0] alucontrol,
//            output logic zero,
//            output logic [31:0] pc,
//            output logic [31:0] instr,
//            output logic [31:0] RD2out, addr,
//            input logic [31:0] readdata);
            
//    logic [4:0] writereg;
//    logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch, signimm, signimmsh, aluout;
//    logic [31:0] srca,srcb,result,Dataout,RD1,RD2,RD1out,writedata, aluresult;
//    logic [31:0] pcjump;
    
//    flopenr #(32) pcreg(clk, reset, pcen, pcnext, pc);
//    flopenr #(32) Instr(clk, reset, irwrite, readdata, instr);
//    flopr #(32) Data(clk,reset, readdata, Dataout);
//    flopr #(32) RD_1(clk,reset, RD1, RD1out);
//    flopr #(32) RD_2(clk,reset, RD2, RD2out);
//    flopr #(32) ALU_f(clk,reset, aluresult,aluout);
    
//    mux2 #(5) Regdst(instr[20:16], instr[15:11], regdst, writereg);
//    mux2 #(32) WD3(aluout, Dataout, memtoreg, writedata);
//    mux2 #(32) Adr(pc, aluout, iord, addr);
//    mux2 #(32) Smux(pc, RD1out, alusrca, srca);
//    mux4 #(32) PC_f(aluresult,aluout,pcjump,{32{1'b0}},pcsrc,pcnext);
//    mux4 #(32) Smux2(RD2out, 32'h0004, signimm, signimmsh, alusrcb, srcb);
    
    
//    regfile rf(clk, regwrite, instr[25:21], instr[20:16], writereg, writedata, RD1, RD2);
 
//    signext se(instr[15:0], signimm);    
//    sl2 immsh(signimm, signimmsh);
//    assign pcjump = {pc[31:28],instr[25:0],{2'b00}};
    
//    alu alu(srca, srcb, alucontrol, aluresult, zero);
                
//endmodule
module datapath(input logic clk, reset,memtoreg, alusrca, regdst, pcen, irwrite, regwrite,iord,immExt,
            input logic [1:0]alusrcb,pcsrc,
            input logic [2:0] alucontrol,
            output logic zero,
            output logic [31:0] pc,
            output logic [31:0] instr,
            output logic [31:0] RD2out, addr,
            input logic [31:0] readdata);
            
    logic [4:0] writereg;
    logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch, signimm, zeroimm, imm, signimmsh, aluout;
    logic [31:0] srca,srcb,result,Dataout,RD1,RD2,RD1out,writedata, aluresult;
    logic [31:0] pcjump;
    
    flopenr #(32) pcreg(clk, reset, pcen, pcnext, pc);
    flopenr #(32) Instr(clk, reset, irwrite, readdata, instr);
    flopr #(32) Data(clk,reset, readdata, Dataout);
    flopr #(32) RD_1(clk,reset, RD1, RD1out);
    flopr #(32) RD_2(clk,reset, RD2, RD2out);
    flopr #(32) ALU_f(clk,reset, aluresult,aluout);
    
    mux2 #(5) Regdst(instr[20:16], instr[15:11], regdst, writereg);
    mux2 #(32) WD3(aluout, Dataout, memtoreg, writedata);
    mux2 #(32) Adr(pc, aluout, iord, addr);
    mux2 #(32) Smux(pc, RD1out, alusrca, srca);
    mux2 #(32) extmux(signimm,zeroimm, immExt, imm);
    
    mux4 #(32) PC_f(aluresult,aluout,pcjump,{32{1'b0}},pcsrc,pcnext);
    mux4 #(32) Smux2(RD2out, 32'h0004, imm, signimmsh, alusrcb, srcb);
    
    
    regfile rf(clk, regwrite, instr[25:21], instr[20:16], writereg, writedata, RD1, RD2);
 
    signext se(instr[15:0], signimm);
    zeroext ze(instr[15:0], zeroimm);    
    sl2 immsh(signimm, signimmsh);
    
    assign pcjump = {pc[31:28],instr[25:0],{2'b00}};
    
    alu alu(srca, srcb, alucontrol, aluresult, zero);
                
endmodule