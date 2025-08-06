module maindsp48a1 #(

/*===========================================*/
//Parameters
/*===========================================*/
parameter width1       = 18                ,
parameter width2       = 48                ,
parameter width3       = 8                 ,
parameter width4       = 36                ,
parameter width5       = 1                 ,

parameter A0REG        = 0                 ,
parameter A1REG        = 1                 ,
parameter B0REG        = 0                 ,
parameter B1REG        = 1                 ,
parameter PREG         = 1                 ,
parameter CREG         = 1                 ,
parameter DREG         = 1                 ,
parameter MREG         = 1                 ,
parameter CARRYINREG   = 1                 ,
parameter CARRYOUTREG  = 1                 ,
parameter OPMODEREG    = 1                 ,

parameter CARRYINSEL   = "OPMODE5"         ,
parameter B_INPUT      = "DIRECT"          ,
parameter RSTTYPE      = "SYNC"         
)(

/*===========================================*/
//INPUT PORTS
/*===========================================*/
input [width1-1:0] A                       ,
input [width1-1:0] B                       ,
input [width1-1:0] D                       ,
input [width2-1:0] C                       ,
input [width1-1:0] BCIN                    ,
input [width2-1:0] PCIN                    ,
input [width3-1:0] OPMODE                  ,
input clk                                  ,
input CARRYIN                              ,
input RSTA                                 ,
input RSTB                                 ,
input RSTC                                 ,
input RSTCARRYIN                           , 
input RSTD                                 ,
input RSTM                                 ,
input RSTOPMODE                            ,
input RSTP                                 ,
input CEA                                  ,
input CEB                                  ,
input CEM                                  , 
input CEP                                  ,
input CEC                                  ,
input CED                                  ,
input CECARRYIN                            , 
input CEOPMODE                             ,
/*===========================================*/
//OUTPUTS
/*===========================================*/

output  [width2-1:0] P                        ,
output  [width4-1:0] M                        ,
output  CARRYOUT                              ,
output  CARRYOUTF                             ,
output [width1-1:0] BCOUT                     ,
output [width2-1:0] PCOUT                
);


/*===========================================*/
//WIRES
/*===========================================*/
wire [width1-1:0] A0_wire                        ;
wire [width1-1:0] A1_wire                        ;
wire [width1-1:0] B0_wire                        ;
wire [width1-1:0] B0_wire2                       ;
wire [width1-1:0] D_wire                         ;
wire [width2-1:0] C_wire                         ;
wire [width3-1:0] W_OPMODE                       ;
wire [width1-1:0] pre_addout                     ;
wire [width1-1:0] pre_addoutreg                  ;
wire [width4-1:0] mout                           ;        
wire [width4-1:0] mreg                           ;         
wire [width2-1:0] muxout                         ;  
wire [width2-1:0] muxzout                        ;
wire              carryin                        ;
wire              carryinreg                     ;
wire [width2-1:0] ppostout                       ;


/*====================================  =======*/
//From Begining till Multlipcation
/*===========================================*/

mux_reg_operation #( .widthi(width3), .REG_STATE(OPMODEREG), .RSTTYPE(RSTTYPE)) 
opmode(.clk(clk), .cei(CEOPMODE), .rst(RSTOPMODE),.in(OPMODE),.out(W_OPMODE));

bmux #(.B_INPUT(B_INPUT), .width(width1)) 
bin0(.in0(B), .in1(BCIN), .out(B0_wire));

mux_reg_operation #( .widthi(width1), .REG_STATE(B0REG), .RSTTYPE(RSTTYPE)) 
b0reg(.clk(clk), .cei(CEB), .rst(RSTB),.in(B0_wire),.out(B0_wire2));

mux_reg_operation #( .widthi(width1), .REG_STATE(DREG), .RSTTYPE(RSTTYPE)) 
d0reg(.clk(clk), .cei(CED), .rst(RSTD),.in(D),.out(D_wire));

pre_adder #(.with(width1))
preadding(.in1(D_wire), .in2(B0_wire2), .out(pre_addout), .opmodeadd(W_OPMODE[6]), .opsmodesel(W_OPMODE[4]));

mux_reg_operation #( .widthi(width1), .REG_STATE(B1REG), .RSTTYPE(RSTTYPE)) 
b1reg(.clk(clk), .cei(CEB), .rst(RSTB),.in(pre_addout),.out(pre_addoutreg));

mux_reg_operation #( .widthi(width1), .REG_STATE(A0REG), .RSTTYPE(RSTTYPE)) 
A0reg(.clk(clk), .cei(CEA), .rst(RSTA),.in(A),.out(A0_wire));

mux_reg_operation #( .widthi(width1), .REG_STATE(A1REG), .RSTTYPE(RSTTYPE)) 
a1reg(.clk(clk), .cei(CEA), .rst(RSTA),.in(A0_wire),.out(A1_wire));

mux_reg_operation #( .widthi(width2), .REG_STATE(CREG), .RSTTYPE(RSTTYPE)) 
c0reg(.clk(clk), .cei(CEC), .rst(RSTC),.in(C),.out(C_wire));


multiplier   #(.with1(width1),.widthmul(width4))
multip(.in1(A1_wire),.in2(pre_addoutreg),.out(mout));




/*====================================  =======*/
//From Multiplication to the Post Adder
/*===========================================*/

mux_reg_operation #( .widthi(36), .REG_STATE(MREG), .RSTTYPE(RSTTYPE)) 
m0reg(.clk(clk), .cei(CEM), .rst(RSTM),.in(mout),.out(mreg));

mux4x1 muxx4(.opmodemux(W_OPMODE[1:0]),.in0({12'b0,mreg}),.in1(PCOUT),.in2({D_wire[11:0],A1_wire,pre_addoutreg}),.out(muxout));

mux4x1 muxz4(.opmodemux(W_OPMODE[3:2]),.in0(PCIN),.in1(PCOUT),.in2(C_wire),.out(muxzout));

carrycasecade #(.CARRYINSEL(CARRYINSEL))
carryinc(.cin(CARRYIN),.OPMODE5(W_OPMODE[5]),.out(carryin));
wire carryoutreg;

mux_reg_operation #( .widthi(width5), .REG_STATE(CARRYOUTREG), .RSTTYPE(RSTTYPE)) 
CYO(.clk(clk), .cei(CECARRYIN), .rst(RSTCARRYIN),.in(carryoutreg),.out(CARRYOUT));

post_adder #(.width(width2))
postadd(.opmodepostadd(W_OPMODE[7]),.in0(muxzout),.in1(muxout),.in2(carryinreg),.out(ppostout),.cout(carryoutreg));


/*===========================================*/
//Ending
/*===========================================*/


mux_reg_operation #( .widthi(width5), .REG_STATE(B1REG), .RSTTYPE(RSTTYPE)) 
carryincase(.clk(clk), .cei(CECARRYIN), .rst(RSTCARRYIN),.in(carryin),.out(carryinreg));


mux_reg_operation #( .widthi(width2), .REG_STATE(PREG), .RSTTYPE(RSTTYPE)) 
poutreg(.clk(clk), .cei(CEP), .rst(RSTP),.in(ppostout),.out(PCOUT));

assign CARRYOUTF = CARRYOUT           ;
assign BCOUT     = pre_addoutreg      ;
assign P         = PCOUT              ;
assign M         = mreg               ;

endmodule