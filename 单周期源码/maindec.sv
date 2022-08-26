`timescale 1ns / 1ps
//module maindec(input logic [5:0] op,
//            output logic memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump,
//            output logic [1:0]aluop);
//    logic [8:0] controls;
//    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = controls;
//    always_comb
//        case(op)
//            6'b000000: controls <= 9'b110000010;
//            6'b100011: controls <= 9'b101001000;
//            6'b101011: controls <= 9'b001010000;
//            6'b000100: controls <= 9'b000100001;
//            6'b001000: controls <= 9'b101000000;
//            6'b000010: controls <= 9'b000000100;
//            default: controls <= 9'bxxxxxxxxx;
//        endcase
                        
//endmodule

module maindec(input logic [5:0] op,
            output logic memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump,
            output logic [2:0]aluop,
            output logic immext, branchBne);
    logic [11:0] controls;
    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop, immext, branchBne} = controls;
    always_comb
        case(op)
            6'b000000: controls <= 12'b110000001000;
            6'b100011: controls <= 12'b101001000000;
            6'b101011: controls <= 12'b001010000000;
            6'b000100: controls <= 12'b000100000100;
            6'b001000: controls <= 12'b101000000000;
            6'b000010: controls <= 12'b000000100000;
            6'b000101: controls <= 12'b000000000101;
            6'b001101: controls <= 12'b101000001110;
            6'b001100: controls <= 12'b101000010010;
            default: controls <= 12'bxxxxxxxxxxxx;
        endcase
                        
endmodule
