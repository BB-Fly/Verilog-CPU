`timescale 1ns / 1ps

//module imem(input logic [5:0] a,
//            output logic [31:0] rd );
           
//    logic [31:0]RAM[63:0];
//    initial
//        $readmemh("C:/Users/86137/Desktop/project_1/project_1.srcs/sim_1/memfile.txt", RAM);
       
//    assign rd = RAM[a];
//endmodule

module imem(input logic [5:0] a,
            output logic [31:0] rd );
           
    logic [31:0]RAM[63:0];
    initial
        $readmemh("C:/Users/86137/Desktop/project_1/project_1.srcs/sim_1/test_IO.txt", RAM);
       
    assign rd = RAM[a];
endmodule
