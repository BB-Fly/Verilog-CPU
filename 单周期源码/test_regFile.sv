`timescale 1ns / 1ps

module test_regFile();
    logic clk, regwe;
    logic [4:0] regwriteaddr;
    logic [31:0] regwritedata;
    logic [4:0] Rsaddr, Rtaddr;
    logic [31:0] Rsdata, Rtdata;
    
    regfile MUT (clk, regwe, regwriteaddr, regwritedata, Rsaddr, Rtaddr, Rsdata, Rtdata);
    
    initial begin
        clk = 0;
        regwe = 0;
        regwriteaddr = 0;
        regwritedata = 0;
        Rsaddr = 0;
        Rtaddr = 0;
        # 100
        regwe = 1;
        regwritedata = 32'h1234abcd;
    end
        
    parameter PERIOD = 20;
    always begin
        clk = 1'b0;
        #(PERIOD/2) clk = 1'b1;
        #(PERIOD/2);
    end
    
    always begin
        regwriteaddr = 8;
        Rsaddr = 8; 
        # PERIOD;
    end
endmodule
