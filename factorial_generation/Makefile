SNPS_BIN=/synopsys/2010fall/syn/bin/
SRC_FILES = package.sv engine_pgm.sv  engine.sv  engine_tb.sv
SRC_FILES += factorial.sv    tb_interface.sv

all: clean
	${SNPS_BIN}/dc_shell -f factorial.tcl
clean:
	@echo 'CLEAN'
	@rm -rf WORK work DVEfiles simv.daidir simv.vdb csrc simv ucli.key vcdplus.vpd simulation.log
	@rm -rf transcript.log *~ command.log default.svf urgReport vcs.log

sim:
	vcs -sverilog -cm assert -debug_all -R -l simulation.log $(SRC_FILES) +define+SIMULATION +vcs+vcdpluson
	urg -dir simv.vdb

gui:
	dve -vpd vcdplus.vpd
