// megafunction wizard: %LPM_MUX%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: LPM_MUX 

// ============================================================
// File Name: mux_1_bit.v
// Megafunction Name(s):
// 			LPM_MUX
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 16.0.0 Build 211 04/27/2016 SJ Lite Edition
// ************************************************************

//Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, the Altera Quartus Prime License Agreement,
//the Altera MegaCore Function License Agreement, or other 
//applicable license agreement, including, without limitation, 
//that your use is for the sole purpose of programming logic 
//devices manufactured by Altera and sold by Altera or its 
//authorized distributors.  Please refer to the applicable 
//agreement for further details.

module mux_1_bit (
	data0,
	data1,
	sel,
	result);

	input	  data0;
	input	  data1;
	input	  sel;
	output	  result;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_SIZE NUMERIC "2"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_MUX"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "1"
// Retrieval info: CONSTANT: LPM_WIDTHS NUMERIC "1"
// Retrieval info: USED_PORT: data0 0 0 0 0 INPUT NODEFVAL "data0"
// Retrieval info: USED_PORT: data1 0 0 0 0 INPUT NODEFVAL "data1"
// Retrieval info: USED_PORT: result 0 0 0 0 OUTPUT NODEFVAL "result"
// Retrieval info: USED_PORT: sel 0 0 0 0 INPUT NODEFVAL "sel"
// Retrieval info: CONNECT: @data 0 0 1 0 data0 0 0 0 0
// Retrieval info: CONNECT: @data 0 0 1 1 data1 0 0 0 0
// Retrieval info: CONNECT: @sel 0 0 1 0 sel 0 0 0 0
// Retrieval info: CONNECT: result 0 0 0 0 @result 0 0 1 0
// Retrieval info: GEN_FILE: TYPE_NORMAL mux_1_bit.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL mux_1_bit.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL mux_1_bit.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL mux_1_bit.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL mux_1_bit_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL mux_1_bit_bb.v TRUE
// Retrieval info: LIB_FILE: lpm
