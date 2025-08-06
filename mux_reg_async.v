
module mux_reg_async #(
  parameter widthi = 18,
parameter REG_STATE = 1
)(
  input clk,
  input cei,
  input rst,
  input [widthi-1:0] in,
  output [widthi-1:0] out
);

reg [widthi-1:0] out_mux_reg;

assign out = (REG_STATE==1) ? out_mux_reg : in;

always @(posedge clk or posedge rst) begin
    if(rst) begin
      out_mux_reg <= 0;
    end else if (cei) begin
      out_mux_reg <= in;
    end else begin
      out_mux_reg <= 0;
    end
end
endmodule
