module mux_reg_operation #(
  parameter widthi      =  18,
  parameter REG_STATE   =  1,       // 1 = no register, bypass
  parameter RSTTYPE     = "SYNC"    // "SYNC" or "ASYNC"
) (
  input clk,
  input cei,
  input rst,
  input [widthi-1:0] in,
  output [widthi-1:0] out
);

generate
    if(RSTTYPE=="SYNC") begin
      mux_reg_sync #(.REG_STATE(REG_STATE),.widthi(widthi)) 
      mux_reg_18bits( .cei(cei),.clk(clk),.rst(rst),.in(in),.out(out));
      
    end else begin
       mux_reg_async #(.REG_STATE(REG_STATE),.widthi(widthi)) 
       mux_reg_18bits( .cei(cei),.clk(clk),.rst(rst),.in(in),.out(out));
    end
endgenerate

endmodule
