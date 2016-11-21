transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Computer_Architecture/Ramses {C:/Computer_Architecture/Ramses/ALU16bit.v}
vlog -vlog01compat -work work +incdir+C:/Computer_Architecture/Ramses {C:/Computer_Architecture/Ramses/control_unit.v}
vlog -vlog01compat -work work +incdir+C:/Computer_Architecture/Ramses {C:/Computer_Architecture/Ramses/bank_register.v}
vlog -vlog01compat -work work +incdir+C:/Computer_Architecture/Ramses {C:/Computer_Architecture/Ramses/MSP430x2xx.v}

