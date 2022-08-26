module top(input logic clk, reset,
            output logic [31:0] writedata, dataadr, pc,
            output logic memwrite);
            
    logic [31:0] readData;
    
    mips mips(clk, reset, pc, memwrite, writedata, dataadr, readData);
    mem mem(clk, memwrite, dataadr, writedata, readData);
          
endmodule