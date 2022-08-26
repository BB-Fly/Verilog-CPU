module mem(input logic clk, we,
            input logic [31:0] a, wd,
            output logic [31:0] rd);
    
    logic [31:0] RAM[255:0];
    assign rd = RAM[a[31:2]];
    
    initial
        //$readmemh("C:/Users/86137/Desktop/project_3/project_3.srcs/sim_1/imports/sim_1/memfile_k.txt", RAM);
        $readmemh("C:/Users/86137/Desktop/project_3/project_3.srcs/sim_1/imports/sim_1/memfile.txt", RAM);
    
    always_ff @(posedge clk)
        if (we) RAM[a[31:2]] <= wd;
        
endmodule
