comp:
	vlog ../ENV/AHB_MASTER_AGENT/ahb_mas_pkg.sv ../ENV/AHB_SLAVE_AGENT/ahb_slv_pkg.sv ../ENV/ahb_env_pkg.sv ../TEST/ahb_test_pkg.sv ../TOP/ahb_tb_top.sv +incdir+../ENV/AHB_MASTER_AGENT +incdir+../ENV/AHB_SLAVE_AGENT +incdir+../ENV +incdir+../TEST

sim:
	vsim -voptargs="+acc" ahb_tb_top -c -do "run -all" 