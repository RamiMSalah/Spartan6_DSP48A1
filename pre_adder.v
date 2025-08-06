module pre_adder #(
parameter with = 18   
)(
input [with-1:0] in1    ,
input [with-1:0] in2    ,
input opmodeadd         ,
input opsmodesel        ,
output [with-1:0]  out       
);
wire [with-1:0] pre_out ;

assign pre_out = (opmodeadd==0) ? (in1 + in2) : (in1 - in2);
assign out = (opsmodesel==1) ? (pre_out) : (in2);
endmodule
