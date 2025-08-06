module dsp48a1_tb();

parameter width1       = 18                 ;
parameter width2       = 48                 ;
parameter width3       = 8                  ;
parameter width4       = 36                 ;
parameter width5       = 1                  ;

parameter A0REG        = 0                  ;
parameter A1REG        = 1                  ;
parameter B0REG        = 0                  ;
parameter B1REG        = 1                  ;
parameter PREG         = 1                  ;
parameter CREG         = 1                  ;
parameter DREG         = 1                  ;
parameter MREG         = 1                  ;
parameter CARRYINREG   = 1                  ;
parameter CARRYOUTREG  = 1                  ;
parameter OPMODEREG    = 1                  ;

parameter CARRYINSEL   = "OPMODE5"          ;
parameter B_INPUT      = "DIRECT"           ;
parameter RSTTYPE      = "SYNC"             ;

reg [width1-1:0] A_tb                       ;
reg [width1-1:0] B_tb                       ;
reg [width1-1:0] D_tb                       ;
reg [width2-1:0] C_tb                       ;
reg [width1-1:0] BCIN_tb                    ;
reg [width2-1:0] PCIN_tb                    ;
reg [width3-1:0] OPMODE_tb                  ;
reg clk_tb                                  ;
reg CARRYIN_tb                              ;
reg RSTA_tb                                 ;
reg RSTB_tb                                 ;
reg RSTC_tb                                 ;
reg RSTCARRYIN_tb                           ; 
reg RSTD_tb                                 ;
reg RSTM_tb                                 ;
reg RSTOPMODE_tb                            ;
reg RSTP_tb                                 ;
reg CEA_tb                                  ;
reg CEB_tb                                  ;
reg CEM_tb                                  ; 
reg CEP_tb                                  ;
reg CEC_tb                                  ;
reg CED_tb                                  ;
reg CECARRYIN_tb                            ; 
reg CEOPMODE_tb                             ;
wire  [width2-1:0] P_DUT                    ;
wire  [width4-1:0] M_DUT                    ;
wire  CARRYOUT_DUT                           ;
wire  CARRYOUTF_DUT                          ;
wire [width1-1:0] BCOUT_DUT                  ;  
wire [width2-1:0] PCOUT_DUT                  ;


maindsp48a1 #(
.width1(width1),.width2(width2),.width3(width3),.width4(width4),
.A0REG(A0REG),.A1REG(A1REG),.B0REG(B0REG),.B1REG(B1REG),.PREG(PREG),.CREG(CREG),.MREG(MREG),.CARRYINREG(CARRYINREG),.CARRYOUTREG(CARRYOUTREG),
.OPMODEREG(OPMODEREG),.CARRYINSEL(CARRYINSEL),.B_INPUT(B_INPUT),.RSTTYPE(RSTTYPE)    ) 
DUT(
.A(A_tb),.B(B_tb),.C(C_tb),.D(D_tb),.BCIN(BCIN_tb),.PCIN(PCIN_tb),.OPMODE(OPMODE_tb),.CARRYOUTF(CARRYOUTF_DUT),
.clk(clk_tb),.CARRYIN(CARRYIN_tb),.RSTA(RSTA_tb),.RSTB(RSTB_tb),.RSTC(RSTC_tb),.RSTCARRYIN(RSTCARRYIN_tb),
.RSTD(RSTD_tb),.RSTM(RSTM_tb),.RSTOPMODE(RSTOPMODE_tb),.RSTP(RSTP_tb),.CEA(CEA_tb),.CEB(CEB_tb),.CEM(CEM_tb),
.CEP(CEP_tb),.CEC(CEC_tb),.CED(CED_tb),.CECARRYIN(CECARRYIN_tb),.CEOPMODE(CEOPMODE_tb),
.P(P_DUT),.M(M_DUT),.CARRYOUT(CARRYOUT_DUT),.BCOUT(BCOUT_DUT),.PCOUT(PCOUT_DUT)  
);


initial begin
    clk_tb = 0;
    forever begin
        clk_tb = ~clk_tb;
        #1;
    end
end

initial begin
/*===========================================*/
//First Verification
/*===========================================*/
RSTA_tb = 1                               ;
RSTB_tb = 1                               ;
RSTC_tb = 1                               ;
RSTCARRYIN_tb = 1                         ; 
RSTD_tb       = 1                         ;
RSTM_tb       = 1                         ;
RSTOPMODE_tb  = 1                         ;
RSTP_tb       = 1                         ;
#5;
repeat(10) begin
 
RSTA_tb       = 1                          ;
RSTB_tb       = 1                          ;
RSTC_tb       = 1                          ;
RSTD_tb       = 1                          ;
RSTCARRYIN_tb = 1                          ; 
RSTM_tb       = 1                          ;
RSTOPMODE_tb  = 1                          ;
RSTP_tb       = 1                          ;
#5;

A_tb             = $random                              ;
B_tb             = $random                              ;
D_tb             = $random                              ;
C_tb             = $random                              ;
BCIN_tb          = $random                              ;
PCIN_tb          = $random                              ;
OPMODE_tb        = $random                              ;
CEA_tb           = $random                              ;
CEB_tb           = $random                              ;
CEM_tb           = $random                              ; 
CEP_tb           = $random                              ;
CEC_tb           = $random                              ;
CED_tb           = $random                              ;
CECARRYIN_tb     = $random                              ; 
CEOPMODE_tb      = $random                              ;
#20;
@(negedge clk_tb);
if(P_DUT !== 0 || M_DUT !==0 || CARRYOUT_DUT !==0 || CARRYOUTF_DUT !==0 || BCOUT_DUT !==0 || PCOUT_DUT !==0) begin
    $display("Error in Reset: P: %d, M: %d, CARRYOUT: %d, CARRYOUTF: %d, BCOUT: %d, PCOUT: %d",
P_DUT,M_DUT,CARRYOUT_DUT,CARRYOUTF_DUT,BCOUT_DUT,PCOUT_DUT);
$stop;
end
end 
$display("RESET Verification is Done");


/*===========================================*/
//second Verification
/*===========================================*/
#10;

RSTA_tb       = 0                                 ;
RSTB_tb       = 0                                 ;
RSTC_tb       = 0                                 ;
RSTD_tb       = 0                                 ;
RSTCARRYIN_tb = 0                                 ; 
RSTM_tb       = 0                                 ;
RSTOPMODE_tb  = 0                                 ;
RSTP_tb       = 0                                 ;
CEA_tb           = 1                              ;
CEB_tb           = 1                              ;
CEM_tb           = 1                              ; 
CEP_tb           = 1                              ;
CEC_tb           = 1                              ;
CED_tb           = 1                              ;
CECARRYIN_tb     = 1                              ; 
CEOPMODE_tb      = 1                              ;
#10;

A_tb = 20;
B_tb = 10;
C_tb = 350;
D_tb = 25;
CARRYIN_tb       = $random                        ;                       
BCIN_tb          = $random                        ; 
PCIN_tb          = $random                        ;

#5;
OPMODE_tb        = 8'b11011101                    ;

@(negedge clk_tb);
@(negedge clk_tb);
@(negedge clk_tb);
@(negedge clk_tb);
if(P_DUT !== 48'h32 || M_DUT !==36'h12c || CARRYOUT_DUT !==0 || CARRYOUTF_DUT !==0 || BCOUT_DUT !==18'hf || PCOUT_DUT !==48'h32) begin
    $display("Error in First Path: P: %d, M: %d, CARRYOUT: %d, CARRYOUTF: %d, BCOUT: %d, PCOUT: %d",
P_DUT,M_DUT,CARRYOUT_DUT,CARRYOUTF_DUT,BCOUT_DUT,PCOUT_DUT);
$stop;
end
$display("Path 1 Verification is Done");


#5;

/*===========================================*/
//Third Verification
/*===========================================*/
BCIN_tb          = $random                              ;
PCIN_tb          = $random                              ;
OPMODE_tb        = 8'b00010000                          ;
A_tb = 20                                               ;
B_tb = 10                                               ;
C_tb = 350                                              ;
D_tb = 25                                               ;
CARRYIN_tb       = $random                              ;                          
BCIN_tb          = $random                              ;
PCIN_tb          = $random                              ;
@(negedge clk_tb);
@(negedge clk_tb);
@(negedge clk_tb);
#10;
if(P_DUT !== 48'h0 || M_DUT !==36'h2bc || CARRYOUT_DUT !==0 || CARRYOUTF_DUT !==0 || BCOUT_DUT !==18'h23 || PCOUT_DUT !==48'h0) begin
    $display("Error in Second Path: P: %d, M: %d, CARRYOUT: %d, CARRYOUTF: %d, BCOUT: %d, PCOUT: %d",
P_DUT,M_DUT,CARRYOUT_DUT,CARRYOUTF_DUT,BCOUT_DUT,PCOUT_DUT);
$stop;
end
$display("Path 2 Verification is Done");
#5;
/*===========================================*/
//Fourth
/*===========================================*/
#5;
BCIN_tb          = $random                              ;
PCIN_tb          = $random                              ;
OPMODE_tb        = 8'b00001010                          ;
A_tb = 20                                               ;
B_tb = 10                                               ;
C_tb = 350                                              ;
D_tb = 25                                               ;
CARRYIN_tb = 0                                          ;                          
BCIN_tb          = $random                              ;
PCIN_tb          = $random                              ;
@(negedge clk_tb);
@(negedge clk_tb);
@(negedge clk_tb);
#10;
if(P_DUT !== PCOUT_DUT || M_DUT !==36'hc8 || CARRYOUT_DUT !==CARRYOUTF_DUT || BCOUT_DUT !==18'ha) begin
    $display("Error in Third Path: P: %d, M: %d, CARRYOUT: %d, CARRYOUTF: %d, BCOUT: %d, PCOUT: %d",
P_DUT,M_DUT,CARRYOUT_DUT,CARRYOUTF_DUT,BCOUT_DUT,PCOUT_DUT);
$stop;
end
$display("Path 3 Verification is Done");


#5;

/*===========================================*/
//Final Verification
/*===========================================*/
BCIN_tb          = $random                             ;
PCIN_tb          = $random                             ;

OPMODE_tb        = 8'b10100111                         ;
A_tb = 5                                               ;
B_tb = 6                                               ;
C_tb = 350                                             ;
D_tb = 25                                              ; 
CARRYIN_tb = 0                                         ;                          
BCIN_tb          = $random                             ;
PCIN_tb          = 3000                                ;
@(negedge clk_tb);
@(negedge clk_tb);
@(negedge clk_tb);
#10;
if(P_DUT !== 48'hfe6fffec0bb1 || M_DUT !==36'h1e || CARRYOUT_DUT !==1 || CARRYOUTF_DUT !==1 || BCOUT_DUT !==18'h6 || PCOUT_DUT !==48'hfe6fffec0bb1) begin
    $display("Error in Fourth Path: P: %d, M: %d, CARRYOUT: %d, CARRYOUTF: %d, BCOUT: %d, PCOUT: %d",
P_DUT,M_DUT,CARRYOUT_DUT,CARRYOUTF_DUT,BCOUT_DUT,PCOUT_DUT);
$stop;
end
$display("Path 4 Verification is Done");
$display("Project is Perfect");
$stop;
end



endmodule