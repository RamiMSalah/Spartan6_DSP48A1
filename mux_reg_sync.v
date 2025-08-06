module mux_reg_sync #(
  parameter widthi = 18,
parameter REG_STATE = 1
)(
  input clk,
  input cei,
  input [widthi-1:0] in,
  input rst,
  output [widthi-1:0] out
);
reg [widthi-1:0] out_mux_reg;

assign out = (REG_STATE==1) ? out_mux_reg : in;

always @(posedge clk) begin
    if(cei) begin
      if(rst) begin
        out_mux_reg <= 0;
      end else begin
        out_mux_reg <= in;
      end
    end else begin
      out_mux_reg <= 0;
    end
end
endmodule