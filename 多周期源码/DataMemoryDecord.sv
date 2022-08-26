module DataMemoryDecord(input logic clk, writeEN, 
                    input logic [31:0] addr, writeData,
                    output logic [31:0] readData,
                    input logic IOclk, reset, bntL, bntR,
                    input logic [15:0] switch,
                    output logic [7:0] AN,
                    output logic DP,
                    output logic [6:0] A2G);
                    
    logic Write, pWrite;
    logic [11:0] LED;
    logic [15:0]switchl;
    logic [31:0] readData1, readData2;
    
    assign pWrite = addr[7]&writeEN;
    assign Write = (~addr[7])&writeEN;
    
    mux2 #(32) readdate_mux (readData1, readData2, addr[7], readData);
    
    mem mem(clk, Write, addr, writeData, readData1);
    
    IO io(IOclk, reset, addr[7], pWrite, addr[3:2], writeData, readData2, bntL, bntR, switch, switchl, LED);
    mux7seg mux7seg(IOclk, reset,{switchl, 4'b0000, LED}, AN, DP, A2G);  
endmodule
