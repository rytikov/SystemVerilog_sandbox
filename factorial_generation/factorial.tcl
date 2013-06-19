# Analyze and elaborate:
define_design_lib WORK  -path ./WORK

analyze -f sverilog package.sv
analyze -f sverilog engine.sv
analyze -f sverilog engine_pgm.sv
analyze -f sverilog factorial.sv
analyze -f sverilog tb_interface.sv

elaborate factorial

# Constrain and compile:
create_clock  -p 1 tif.clk
compile_ultra
check_design

# Report results:
report_qor
report_timing
report_reference -no
report_resources
quit

