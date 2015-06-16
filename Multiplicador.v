`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:40:57 04/11/2015 
// Design Name: 
// Module Name:    Multiplicador 
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
module Multiplicador #(parameter Width = 23, Presicion = 14, Magnitud = Width-Presicion-1)
		(
		input wire signed [Width-1:0] A,B,
		output reg signed [Width-1:0] Y
		);

wire signed [2*Width-1:0] Aux;
assign Aux = A*B;

localparam [Width:0]
	maximo = 2**(Width-1)-1,
	minimo = 2**(Width-1)+1,
	cero = 0;

always@*
	begin
	if(A==0 || B==0)
		Y=cero;
	else
		begin
			if((A[Width-1]==B[Width-1])&&(Aux[2*Width-1:(2*Presicion+Magnitud)]>0))
				Y=maximo;
			else if((A[Width-1]!=B[Width-1])&&~(&Aux[2*Width-1:(2*Presicion+Magnitud)]))
				Y=minimo;
			else
				Y={Aux[2*Width-1],Aux[2*Width-3-Magnitud:Presicion]};
		end
	end		

endmodule
