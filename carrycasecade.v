module carrycasecade #(
parameter CARRYINSEL = "OPMODE5" 
) (
input OPMODE5,
input cin,
output out
);

assign out = (CARRYINSEL== "OPMODE5") ? OPMODE5: (CARRYINSEL == "CARRYIN") ? cin : 0;
endmodule
