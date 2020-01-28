transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/FPGA/project/DE10_NANO_SMK_RTL/ip {D:/FPGA/project/DE10_NANO_SMK_RTL/ip/UI.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/project/DE10_NANO_SMK_RTL/ip {D:/FPGA/project/DE10_NANO_SMK_RTL/ip/PWM_Geneator.v}
vlog -vlog01compat -work work +incdir+D:/FPGA/project/DE10_NANO_SMK_RTL {D:/FPGA/project/DE10_NANO_SMK_RTL/DE10_NANO_SMK_RTL.v}

