`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:16:03 04/22/2015 
// Design Name: 
// Module Name:    Suma 
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
module Suma #(parameter Width = 22)							// Parametros 
				(
				input wire signed [Width-1:0] A,B,			//Definir entradas
				output reg signed [Width-1:0] Y     		//Define salidas
				);		
						
		reg signed [Width-1:0] Aux; 			//Variable auxiliar para realizar calculos

		localparam [Width:0]//Extremos de los overflow y underflow
		
			maximo = 2**(Width-1)-1,
			minimo = 2**(Width-1)+1;	
		
		
		always @*
				Aux = A+B;
			
		always @*
			begin
			 	if (~A[Width-1] && ~B[Width-1] && Aux[Width-1])     //Verificación de overflow 
					Y = maximo;
					
				else if (A[Width-1] && B[Width-1] && ~Aux[Width-1]) //Verificación de overflow 
					Y = minimo;
									
				else
					Y = Aux;
				
			end
endmodule
