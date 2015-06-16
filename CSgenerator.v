`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITCR
// Estudiantes: 
// Deykel Hernández Araya & Kennet Gonzales Nájera
// Create Date:    17:54:12 04/01/2015 
// Design Name: 
// Module Name:    CSgenerator 
// Project Name:  Ecualizador
// Target Devices: 
// Tool versions: 
// Description: 
//  Módulo que genera la señal de CS necesaria tanto para el funcionamiento del ADC como el DAC 
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module CSgenerator #(N=12,Divisor=2268,N1=8,PULSED=138)(input wire clk,
input wire rst,
output clk_out ); // Divisor indica la cantidad que el contador tiene que contar para generar una señal en alto a 44.1KHz, 100MHz/44.1KHz=2267.57, N es la cantidad de bits necesarios para representar a Divisor, PULSE contador para tener en bajo la señal lo suficiente para obtener los 16 bits del adc además de un tiempo en silencio necesario 


//declaración de registros necesarios 	 
reg [N-1:0] valor,valor_sig;
reg [N1-1:0] pulso,pulso_sig;
reg clk_out_sig, clk_act;
reg estado, estado_sig;

assign clk_out=clk_act; //asignacion para la salida del reloj

localparam HIGH=1'b1,LOW=1'b0; // nombre de estados 


// lógica de siguiente estado 
always @(posedge clk or posedge rst)
	begin
		if(rst) 
			begin
			estado=0;
			valor=0; 
			pulso=0;
			clk_act=0;
			end
		else
			begin 
			estado=estado_sig;
			clk_act=clk_out_sig;
			valor=valor_sig;
			pulso=pulso_sig;
			end
	end


always@(*)
begin
clk_out_sig=clk_act;
valor_sig=valor;
pulso_sig=pulso;
estado_sig=estado;


	case(estado) 

	HIGH: // estado en que mantiene el reloj en alto 1/44.1KHz s
		begin
			if(valor==(Divisor-1))
			begin
			estado_sig=LOW;
			valor_sig=0;
			
			end
			else begin
			estado_sig=HIGH;
			clk_out_sig=1'b1;
			valor_sig=valor+1'b1;
			end


		
		end
		
		
	LOW: //estado en que mantiene el reloj en bajo 
		begin

		if(pulso==(PULSED-1))
		begin
		estado_sig=HIGH;
		pulso_sig=0;
		end
			else begin
			estado_sig=LOW;
			clk_out_sig=1'b0;
			pulso_sig=pulso+1'b1;
			end
		
		end

		
		
		
		
	endcase

end




endmodule
