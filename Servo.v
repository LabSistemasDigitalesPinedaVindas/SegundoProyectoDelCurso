`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:28:16 06/04/2015 
// Design Name: 
// Module Name:    Servo 
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
module Servo #(parameter Width = 19, Presicion = 0, Magnitud = Width-Presicion-1)(
	input [7:0] referencia,
	input clock,reset,datoserial,
	output pwm,CS,sckADC,busy
    );
	 
	 wire [15:0] datoADC;
	// wire[11:0] datoADC;
	 //wire datoListoADC;
	 wire signed [Width-1:0] salida_IPD;
	 wire signed [18:0]  salida_sumaPWM, R1, salida_suma, R2, sumaREGSalida;
	 wire signed [18:0] ref,adc;

		

	 
	 CSgenerator #(.N(19), .Divisor(500_000), .N1(8), .PULSED(138)) GenCS(.clk(clock), .rst(reset), .clk_out(CS));
	 Master2 Master (.clk(clock), .rst(reset), .start(CS), .miso(datoserial), .ready1(datoListoADC), .busy(busy), .sck_out(sckADC), .data_out1(datoADC));
	 concatenar Concatenar (referencia,datoADC,ref,adc);
	 IPD #(Width,Presicion,Magnitud) Control_IPD (clock,datoListoADC,reset,ref,adc,salida_IPD);
	 //Multipilcacion_2  #(Width,Presicion,Magnitud) Multi (19'd2,salida_IPD,salida_Multi);
	 RegistroPipeline #(Width) R_1 (clock, reset, salida_IPD, R1);
	 Suma_128 #(Width) suma128 (R1,19'b01000000000000000000,salida_suma);
	 RegistroPipeline #(Width) R_2 (clock, reset, salida_suma, R2);
	 PWM Pwm (clock,salida_sumaPWM[17:10],pwm);
	 Registro #(Width) RegSalidaPWM (clock, datoListoADC, reset, R2, salida_sumaPWM);
	
endmodule
