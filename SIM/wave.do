onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/hclk
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/hrst_n
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/hready
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/hwrite
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/htrans
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/haddr
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/hwdata
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/hburst
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/hrdata
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/hresp
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/hsel
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/hsize
add wave -noupdate /ahb_tb_top/m_ahb_master_vif_0/hstrb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {49 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 20
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {173 ns}
