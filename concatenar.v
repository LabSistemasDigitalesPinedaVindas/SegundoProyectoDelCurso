`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:42:34 06/08/2015 
// Design Name: 
// Module Name:    concatenar 
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
module concatenar(
   input wire [7:0] ref,
	input wire [15:0] datoADC,
	output wire signed [18:0] dato19bits,ADCconca
    );
	 
	 reg [18:0] datoConcatenado, datoConcaADC;
	 localparam [8:0] Ceros = 9'b0;
	 localparam [8:0] cerosADC = 9'b0;
	 
	 
	
	always@*
		begin
			datoConcaADC = {cerosADC,datoADC[11:4],2'b00};
			datoConcatenado = {Ceros,ref,2'b00};
			datoConcatenado = datoConcatenado - 19'd128;
			datoConcaADC = datoConcaADC - 19'd128;
			
		end 
	
	assign dato19bits = datoConcatenado;
	assign ADCconca = datoConcaADC;



endmodule
