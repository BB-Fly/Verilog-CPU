module mux7seg(input logic clk, reset,
            input logic [31:0] digit,
            output logic [7:0] AN,
            output logic DP,
            output logic [6:0]A2G);
            
    logic [2:0] s;
    logic [3:0] num;
    logic [19:0] clkdiv;
    logic eq;
    
    assign DP = 1;
    assign s = clkdiv[19:17];
    
    always@(posedge clk)
        case(s)
            3'h0: num <= digit[3:0];
            3'h1: num <= digit[7:4];
            3'h2: num <= digit[11:8];
            3'h3: num <= digit[15:12];
            3'h4: num <= digit[19:16];
            3'h5: num <= digit[23:20];
            3'h6: num <= digit[27:24];
            3'h7: num <= digit[31:28];
        endcase
    assign eq = (s==3'h3);
    
    always@(posedge clk)
        case(s)
            3'h0:AN = 8'b1111_1110;
            3'h1:AN = 8'b1111_1101;
            3'h2:AN = 8'b1111_1011;
            3'h3:AN = 8'b1111_0111;
            3'h4:AN = 8'b1110_1111;
            3'h5:AN = 8'b1101_1111;
            3'h6:AN = 8'b1011_1111;
            3'h7:AN = 8'b0111_1111;
            default: AN = 8'b1111_1110;
    endcase
    
    always @(posedge clk)
    begin
        if(reset == 1)
            clkdiv <= 0;
        else
            clkdiv <= clkdiv+1;
    end
    
    Hex7Seg s7(eq,num,A2G);
            
endmodule