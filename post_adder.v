module post_adder#(
parameter width = 48
)(
input [width-1:0] in0,
input [width-1:0] in1,
input in2,
input opmodepostadd,
output [width-1:0] out,
output cout
);

assign {cout,out} = (opmodepostadd==0) ? (in0+in1+in2): (in0 - (in1+in2));

endmodule