`timescale 1ns / 1ps
module pattern(input logic clk, reset, a,
            output logic y);
            
    typedef enum logic [1:0] {S0,S1,S2} statetype;
    statetype state, nextstate;
    
    always_ff @(posedge clk, posedge reset)
        if(reset) state <= S0;
        else state <= nextstate;
    
    always_comb
        case(state)
        S0: if(a) nextstate = S0;
            else nextstate = S1;
        S1: if(a) nextstate = S2;
            else nextstate = S1;
        S2: if(a) nextstate = S0;
            else nextstate = S1;
        default: nextstate = S0;
        endcase
        
    assign y = (state==S2);          

endmodule
