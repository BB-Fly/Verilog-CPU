`timescale 1ns / 1ps
module mux4 #(parameter WIDTH = 32)
            (input logic [31:0] A1,A2,A3,A4,
            input logic [1:0] ch,
            output logic [31:0] out);
    always_comb
        case(ch)
        2'b00: out=A1;
        2'b01: out=A2;
        2'b10: out=A3;
        2'b11: out=A4;
        endcase
endmodule
