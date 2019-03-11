module PF64AK32EI40(ADDR, DIN, DOUT,
                CS, AE, OE, IFREN, NVSTR, PROG, SERA, MASE, TBIT, 
                ADDR_1, WORD,
                RESETB, 
                //VDD, VSS, VPP, VNN,
                SMTEN, SCE, SCLK, SIO_OEN, SIO_O, SIO_I );

// macro size definitions
parameter EFLASH_ADDR_BITS =             'd14;
parameter EFLASH_DATA_BITS =             'd32;
`define PF64AK_BIT_ADDR 14
`define PF64AK_BIT_DATA 32
    input [(`PF64AK_BIT_ADDR-1):0] ADDR;
    input CS, AE, OE, IFREN, NVSTR, PROG, SERA, MASE; 
    input ADDR_1, WORD;
    input RESETB;
    input [(`PF64AK_BIT_DATA-1):0] DIN;
    output [(`PF64AK_BIT_DATA-1):0] DOUT;
    output TBIT;

    //inout VDD, VSS;
    //input VPP, VNN;

// stb pads
    input                           SCLK;      // stb clock
    input                           SCE;       // stb chip select (active low)
    input                           SMTEN;     // stb macro test enable
//inout                           SIO;       // stb macro bi-direction IO
    input                           SIO_I;  
    output                          SIO_O;  
    output                          SIO_OEN;  //active low, when low, enable output from sio_o to PAD

endmodule
