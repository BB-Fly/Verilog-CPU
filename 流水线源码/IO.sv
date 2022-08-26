`timescale 1ns / 1ps
module IO(input logic clk, reset, pRead, pWrite,
            input logic [1:0] addr,
            input logic [31:0] pWriteData,
            output logic [31:0] pReadData,
            input logic buttonL, buttonR,
            input logic [15:0] switch,
            output logic [15:0] switchl,
            output logic [11:0] led );
            
    logic [1:0] status;
    logic [11:0] ledl;
    
    always_ff @(posedge clk)
        begin
            if(reset)
                begin
                    status <= 2'b00;
                    switchl <= 16'h00;
                    ledl <= 12'h00;
                end
            else
                begin
                    if(buttonR)
                        begin
                            status[1] <= 1;
                            switchl <= switch;
                        end
                    if(buttonL)
                        begin
                            status[0] <= 1;
                            led = ledl;
                        end
                    if(pWrite & (addr==2'b01))
                        begin
                            ledl <= pWriteData[11:0];
                            status[0] <= 0;
                        end
                    if(pRead)
                        begin
                            case(addr)
                                2'b11: pReadData <= {24'b0, switchl[15:8]};
                                2'b10: pReadData <= {24'b0, switchl[7:0]};
                                2'b00: pReadData <= {24'b0, 6'b000000, status};
                                default: pReadData <= 32'b0;
                            endcase
                        end
                end
        end
            
endmodule
