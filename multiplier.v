module multiplier #(
parameter with1  = 18     ,
parameter widthmul = 36  
)(
input [with1-1:0] in1   ,
input [with1-1:0] in2   ,
output [widthmul-1:0]  out       
);

assign out = in1 * in2;

endmodule

