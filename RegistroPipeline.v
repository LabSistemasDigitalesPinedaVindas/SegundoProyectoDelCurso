`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:43 04/29/2015 
// Design Name: 
// Module Name:    RegistroPipeline 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RegistroPipeline #(parameter Width = 23)
		(
		input clock,reset, 
		input wire  [Width-1:0] datoIn, 
		output wire [Width-1:0] datoOut
		 );
		
	reg [Width-1:0] datoActual;
		
	always @(posedge clock, posedge reset)
		if (reset)
			datoActual = 0;
		else 
//if (clock == 1)		
			datoActual = datoIn;

	assign datoOut = datoActual;	
	
endmodule

