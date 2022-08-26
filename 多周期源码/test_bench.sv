`timescale 1ns / 1ps
module test_bench();
    logic clk, reset, memwrite;
    logic [31:0] writedata, dataadr,pc;
    
    top dut(clk, reset, writedata, dataadr, pc, memwrite);
    
    initial begin
    reset <= 1; #22; reset <= 0; end
    
    always begin
    clk <= 1; #5; clk<=0; #5; end;
    
    always@(negedge clk)
    begin
        if(memwrite)
        begin
            if(dataadr===84&writedata===7)
            begin
                $display("Simulation successed !");
                $stop;
            end
            else if(dataadr!==80)
            begin
                $display("Simulation failed !");
                $stop;
            end
        end
    end
    
endmodule
