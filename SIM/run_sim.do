
vlog ../ENV/ahb_env_pkg.sv ../TEST/ahb_test_pkg.sv ../TOP/ahb_tb_top.sv +incdir+../ENV/AHB_MASTER_AGENT +incdir+../ENV/AHB_SLAVE_AGENT +incdir+../ENV +incdir+../TEST
vsim -voptargs="+acc" ahb_tb_top
do ./wave.do
run -all
