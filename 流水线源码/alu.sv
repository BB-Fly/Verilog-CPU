module alu(input logic [31:0] a, b,
            input logic [2:0] alucont,
            output logic [31:0] result);
            
    logic [31:0] b2,sum,slt;
    
    assign b2 = alucont[2] ? ~b:b;
    assign sum = a + b2 + alucont[2];
    assign slt = sum[31];
            
    always_comb
        case (alucont[1:0])
            2'b00: result = a & b;
            2'b01: result = a | b;
            2'b10: result = sum;
            2'b11: result = slt;
        endcase
    
endmodule

//module alu(input logic [31:0] a, b,
//            input logic [2:0] alucontrol,
//            output logic [31:0] out,
//            output logic zero);
            
//    logic [31:0] result;
            
//    always_comb
//        case (alucontrol)
//            3'b000: result <= a & b;
//            3'b001: result <= a | b;
//            3'b010: result <= a + b;
//            3'b100: result <= a & (~b);
//            3'b101: result <= a | (~b);
//            3'b110: result <= a - b;
//            3'b111: result <= (a < b) ? 32'b1 : 32'b0;
//            default: result <= 32'h00000000;
//        endcase
    
//    assign zero = (result==0)? 1:0;
//    assign out = result;
    
//endmodule
