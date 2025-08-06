module bmux #(
parameter B_INPUT = "DIRECT" ,
parameter width = 18
)(
input [width-1:0] in0,
input [width-1:0] in1,
output [width-1:0] out
);

assign out = (B_INPUT=="DIRECT") ? in0 : in1;


endmodule

