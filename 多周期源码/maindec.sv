//`timescale 1ns / 1ps
//module maindec(input logic clk, reset,
//            input logic [5:0] op,
//            output logic pcwrite, memwrite, irwrite, regwrite, alusrca, branch, iord, memtoreg, regdst,
//            output logic [1:0] alusrcb, pcsrc, 
//            output logic [2:0] aluop,
//            output logic immExt, branchBne);
            
//    localparam  FETCH   =   4'b0000;
//    localparam  DECODE  =   4'b0001;
//    localparam  MEMADR  =   4'b0010;
//    localparam  MEMRD   =   4'b0011;
//    localparam  MEMWB   =   4'b0100;
//    localparam  MEMWR   =   4'b0101;
//    localparam  RTYPEEX =   4'b0110;
//    localparam  RTYPEWB =   4'b0111;
//    localparam  BEQEX   =   4'b1000;
//    localparam  ADDIEX  =   4'b1001;
//    localparam  ADDIWB  =   4'b1010;
//    localparam  JEX     =   4'b1011;
    
//    localparam  LW      =   6'b100011;
//    localparam  SW      =   6'b101011;
//    localparam  RTYPE   =   6'b000000;
//    localparam  BEQ     =   6'b000100;
//    localparam  ADDI    =   6'b001000;
//    localparam  J       =   6'b000010;
    
//    logic [3:0]state, nextstate;
//    logic [17:0]controls;
    
//    always_ff @(posedge clk or posedge reset)
//        if(reset) state <= FETCH;
//        else state <= nextstate;
        
//    always_comb
//        case(state)
//            FETCH:  nextstate <= DECODE;
//            DECODE: case(op)
//                    LW:     nextstate = MEMADR;
//                    SW:     nextstate = MEMADR;
//                    RTYPE:  nextstate = RTYPEEX;
//                    BEQ:    nextstate = BEQEX;
//                    ADDI:   nextstate = ADDIEX;
//                    J:      nextstate = JEX;
//                    default:nextstate = 4'bx;
//                endcase
//            MEMADR: case(op)
//                    LW:     nextstate = MEMRD;
//                    SW:     nextstate = MEMWR;
//                    default:nextstate = 4'bx;
//                endcase
//            MEMRD:  nextstate   =   MEMWB;
//            MEMWB:  nextstate   =   FETCH;
//            MEMWR:  nextstate   =   FETCH;
//            RTYPEEX:nextstate   =   RTYPEWB;
//            RTYPEWB:nextstate   =   FETCH;
//            BEQEX:  nextstate   =   FETCH;
//            ADDIEX: nextstate   =   ADDIWB;
//            ADDIWB: nextstate   =   FETCH;
//            JEX:    nextstate   =   FETCH;
//            default:nextstate   =   4'bx;
//        endcase
        
//        assign {pcwrite, memwrite, irwrite, regwrite, alusrca, branch, iord, memtoreg, regdst, alusrcb, pcsrc, aluop, immExt, branchBne} = controls;
            
//        always_comb
//        case(state)
//            FETCH:  controls = 18'h5010;
//            DECODE: controls = 18'h0030;
//            MEMADR: controls = 18'h0420;
//            MEMRD:  controls = 18'h0100;
//            MEMWB:  controls = 18'h0880;
//            MEMWR:  controls = 18'h2100;
//            RTYPEEX:controls = 18'h0402;
//            RTYPEWB:controls = 18'h0840;
//            BEQEX:  controls = 18'h0605;
//            ADDIEX: controls = 18'h0420;
//            ADDIWB: controls = 18'h0800;
//            JEX:    controls = 18'h4008;
//            default:controls = 18'hxxxx;
//        endcase
        
//endmodule

module maindec(input logic clk, reset,
            input logic [5:0] op,
            output logic pcwrite, memwrite, irwrite, regwrite, alusrca, branch, iord, memtoreg, regdst,
            output logic [1:0] alusrcb, pcsrc, 
            output logic [2:0] aluop,
            output logic immExt, branchBne);
            
    localparam  FETCH   =   5'b00000;
    localparam  DECODE  =   5'b00001;
    localparam  MEMADR  =   5'b00010;
    localparam  MEMRD   =   5'b00011;
    localparam  MEMWB   =   5'b00100;
    localparam  MEMWR   =   5'b00101;
    localparam  RTYPEEX =   5'b00110;
    localparam  RTYPEWB =   5'b00111;
    localparam  BEQEX   =   5'b01000;
    localparam  ADDIEX  =   5'b01001;
    localparam  ADDIWB  =   5'b01010;
    localparam  JEX     =   5'b01011;
    
    localparam  ANDIEX  =   5'b01100;
    localparam  ANDIWB  =   5'b01101;
    localparam  ORIEX   =   5'b01110;
    localparam  ORIWB   =   5'b01111;
    localparam  BNEEX   =   5'b10000;
    
    localparam  LW      =   6'b100011;
    localparam  SW      =   6'b101011;
    localparam  RTYPE   =   6'b000000;
    localparam  BEQ     =   6'b000100;
    localparam  ADDI    =   6'b001000;
    localparam  J       =   6'b000010;
    
    localparam  BNE     =   6'b000101;
    localparam  ANDI    =   6'b001100;
    localparam  ORI     =   6'b001101;
    
    logic [4:0]state, nextstate;
    logic [17:0]controls;
    
    always_ff @(posedge clk or posedge reset)
        if(reset) state <= FETCH;
        else state <= nextstate;
        
    always_comb
        case(state)
            FETCH:  nextstate <= DECODE;
            DECODE: case(op)
                    LW:     nextstate = MEMADR;
                    SW:     nextstate = MEMADR;
                    RTYPE:  nextstate = RTYPEEX;
                    BEQ:    nextstate = BEQEX;
                    ADDI:   nextstate = ADDIEX;
                    J:      nextstate = JEX;
                    BNE:    nextstate = BNEEX;
                    ANDI:   nextstate = ANDIEX;
                    ORI:    nextstate = ORIEX;
                    default:nextstate = 5'bx;
                endcase
            MEMADR: case(op)
                    LW:     nextstate = MEMRD;
                    SW:     nextstate = MEMWR;
                    default:nextstate = 5'bx;
                endcase
            MEMRD:  nextstate   =   MEMWB;
            MEMWB:  nextstate   =   FETCH;
            MEMWR:  nextstate   =   FETCH;
            RTYPEEX:nextstate   =   RTYPEWB;
            RTYPEWB:nextstate   =   FETCH;
            BEQEX:  nextstate   =   FETCH;
            BNEEX:  nextstate   =   FETCH;
            ADDIEX: nextstate   =   ADDIWB;
            ADDIWB: nextstate   =   FETCH;
            ANDIEX: nextstate   =   ANDIWB;
            ANDIWB: nextstate   =   FETCH;
            ORIEX:  nextstate   =   ORIWB;
            ORIWB:  nextstate   =   FETCH;
            JEX:    nextstate   =   FETCH;
            default:nextstate   =   5'bx;
        endcase
        
        assign {pcwrite, memwrite, irwrite, regwrite, alusrca, branch, iord, 
        memtoreg, regdst, alusrcb, pcsrc, aluop, immExt, branchBne} = controls;
            
        always_comb
        case(state)
            FETCH:  controls = 18'b101000000010000000;
            DECODE: controls = 18'b000000000110000000;
            MEMADR: controls = 18'b000010000100000000;
            MEMRD:  controls = 18'b000000100000000000;
            MEMWB:  controls = 18'b000100010000000000;
            MEMWR:  controls = 18'b010000100000000000;
            RTYPEEX:controls = 18'b000010000000001000;
            RTYPEWB:controls = 18'b000100001000000000;
            BEQEX:  controls = 18'b000011000000100100;
            ADDIEX: controls = 18'b000010000100000000;
            ADDIWB: controls = 18'b000100000000000000;
            ANDIEX: controls = 18'b000010000100010010;
            ANDIWB: controls = 18'b000100000000010010;
            BNEEX:  controls = 18'b000010000000100101;
            ORIEX: controls  = 18'b000010000100001110;
            ORIWB: controls  = 18'b000100000000001110;
            JEX:    controls = 18'b100000000001000000;
            default:controls = 18'hxxxxx;
        endcase
        
endmodule
