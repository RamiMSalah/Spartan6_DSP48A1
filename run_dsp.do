vlib work
vlog maindsp48a1.v pre_adder.v post_adder.v mux4x1.v mux_reg.v mux_reg_sync.v mux_reg_async.v multiplier.v carrycasecade.v bmux.v testbench.v
vsim -voptargs=+acc work.dsp48a1_tb
add wave *
run -all
#quit -sim