module mux4x1 
(
input  [1:0] opmodemux      ,
input  [47:0]  in0    ,
input  [47:0 ]  in1   ,
input  [47:0 ]  in2   ,
output [47:0]  out   
);

assign out = (opmodemux==0) ? 0:
             (opmodemux==1) ?  in0:
             (opmodemux==2) ?  in1:
             in2;
endmodule