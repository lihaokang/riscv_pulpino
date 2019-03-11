//================================================//
//                                                //
//  Copyright(c) 2019 Corelink(beijing) Co.,Ltd.  //
//                                                //
//------------------------------------------------//
//  Project Name : quark                          //
//  File Name    : apb_bus_dec                    //
//  Author       : zhaowt                         //
//  Description  : system control unit            //
//  Create Date  : 2019/01/04                     //
//                                                //
//================================================//
module apb_bus_dec(
                   pwrite,
                   psel,
                   penable,
                   pready,
                   paddr,
                   pwdata,
                   prdata,
                   //slv0
                   pwrite0,
                   psel0,
                   penable0,
                   pready0,
                   pwdata0,
                   prdata0,
                   paddr0,
                   //slv1
                   pwrite1,
                   psel1,
                   penable1,
                   pready1,
                   pwdata1,
                   prdata1,
                   paddr1,
                   //slv2
                   pwrite2,
                   psel2,
                   penable2,
                   pready2,
                   pwdata2,
                   prdata2,
                   paddr2
                  );
    
    input         pwrite,psel,penable;
    input  [31:0] paddr;
    input  [31:0] pwdata;
    output        pready;
    output [31:0] prdata;

    input         pready0;
    input  [31:0] prdata0;
    output        pwrite0,psel0,penable0;
    output [7:0]  paddr0;
    output [31:0] pwdata0;
    
    input         pready1;
    input  [31:0] prdata1;
    output        pwrite1,psel1,penable1;
    output [7:0]  paddr1;
    output [31:0] pwdata1;
    
    input         pready2;
    input  [31:0] prdata2;
    output        pwrite2,psel2,penable2;
    output [7:0]  paddr2;
    output [31:0] pwdata2;

    //=======================//
    parameter SLAVE0 = 24'h1B_0030;
    parameter SLAVE1 = 24'h1B_0031;
    parameter SLAVE2 = 24'h1B_0032;
    //=======================//
    reg           pready;
    reg    [31:0] prdata;

    reg           pwrite0,psel0,penable0;
    reg    [7:0]  paddr0;
    reg    [31:0] pwdata0;
    reg           pwrite1,psel1,penable1;
    reg    [7:0]  paddr1;
    reg    [31:0] pwdata1;
    reg           pwrite2,psel2,penable2;
    reg    [7:0]  paddr2;
    reg    [31:0] pwdata2;

    always@(*)
        begin
            begin
                pwrite0 <= 1'b0;
                psel0 <= 1'b0;
                penable0 <= 1'b0;
                pwdata0 <= 32'h0;
                paddr0 <= 8'h0;
                pwrite1 <= 1'b0;
                psel1 <= 1'b0;
                penable1 <= 1'b0;
                pwdata1 <= 32'h0;
                paddr1 <= 8'h0;
                pwrite2 <= 1'b0;
                psel2 <= 1'b0;
                penable2 <= 1'b0;
                pwdata2 <= 32'h0;
                paddr2 <= 8'h0;
                pready <= 1'b0;
                prdata <= 32'h0;
            end
            if(psel)
                begin
                    case(paddr[31:8])
                        SLAVE0  :
                                begin
                                    pwrite0 <= pwrite;
                                    psel0 <= psel;
                                    penable0 <= penable;
                                    paddr0 <= paddr[7:0];
                                    pwdata0 <= pwdata;
                                    pready <= pready0;
                                    prdata <= prdata0;
                                end
                        SLAVE1  :
                                begin
                                    pwrite1 <= pwrite;
                                    psel1 <= psel;
                                    penable1 <= penable;
                                    paddr1 <= paddr[7:0];
                                    pwdata1 <= pwdata;
                                    pready <= pready1;
                                    prdata <= prdata1;
                                end
                        SLAVE2  :
                                begin
                                    pwrite2 <= pwrite;
                                    psel2 <= psel;
                                    penable2 <= penable;
                                    paddr2 <= paddr[7:0];
                                    pwdata2 <= pwdata;
                                    pready <= pready2;
                                    prdata <= prdata2;
                                end
                        default :
                                begin
                                    pwrite0 <= 1'b0;
                                    psel0 <= 1'b0;
                                    penable0 <= 1'b0;
                                    pwdata0 <= 32'h0;
                                    paddr0 <= 8'h0;
                                    pwrite1 <= 1'b0;
                                    psel1 <= 1'b0;
                                    penable1 <= 1'b0;
                                    pwdata1 <= 32'h0;
                                    paddr1 <= 8'h0;
                                    pwrite2 <= 1'b0;
                                    psel2 <= 1'b0;
                                    penable2 <= 1'b0;
                                    pwdata2 <= 32'h0;
                                    paddr2 <= 8'h0;
                                    pready <= 1'b0;
                                    prdata <= 32'h0; 
                                end
                    endcase
                end
        end

    

endmodule
