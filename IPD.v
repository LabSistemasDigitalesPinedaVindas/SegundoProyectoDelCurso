`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:11:16 05/26/2015 
// Design Name: 
// Module Name:    IPD 
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
module IPD #(parameter Width = 19, Presicion = 0, Magnitud = Width-Presicion-1)
		(
		input wire clock, enable, reset,
		input wire  [Width-1:0] referencia, y_k,
		output wire  [Width-1:0] salida_IPD,integral,derivativa,prop
		);
		
		wire signed [Width-1:0] resta_Error, Multi_yk;
		wire signed [Width-1:0] Multi_Kp, Multi_Ki, Multi_Kd, Reg_I, Reg_D, suma_I, resta_D;
		wire signed [Width-1:0] R1, R2, R3, R4, R5, R6, R7,R8,R9, suma_Aux, MultiSuma_Aux;
		
//Multiplicadores
//nombre viejo #(parametros) nombre nuevo (entradas y salidas);

Multiplicador #(Width, Presicion, Magnitud) MultiKp (R9, 19'd18, Multi_Kp);
Multiplicador #(Width, Presicion, Magnitud) MultiKi (R4, 19'd7, Multi_Ki);
Multiplicador #(Width, Presicion, Magnitud) MultiKd (R5, 19'd150, Multi_Kd);
Multiplicador #(Width, Presicion, Magnitud) MultiyK (R9, 19'h7FFFF, Multi_yk);
//Multiplicador #(Width, Presicion, Magnitud) MultiSumaAux(suma_Aux, 12'hFFF, MultiSuma_Aux);

//Sumadores
//nombre viejo #(parametros) nombre nuevo (entradas y salidas);

Suma #(Width) restaError (R7, referencia, resta_Error);
Suma #(Width) restaD (R9, Reg_D, resta_D);
Suma #(Width) sumaI (Reg_I,R2, suma_I);
Suma #(Width) sumaAux (R1, R3, suma_Aux);
Suma #(Width) sumaFinal (R8, Reg_I, salida_IPD);

assign integral = R6;
assign prop = R1;
assign derivativa = R3;
//Registros
//nombre viejo #(parametros) nombre nuevo (entradas y salidas);

Registro #(Width) RegI (clock, enable, reset, R6, Reg_I);
Registro #(Width) RegD (clock, enable, reset, Multi_yk, Reg_D);

//Registros de pipeline
//nombre viejo #(parametros) nombre nuevo (entradas y salidas);
//
RegistroPipeline #(Width) R_1 (clock, reset, Multi_Kp, R1);
RegistroPipeline #(Width) R_2 (clock, reset, Multi_Ki, R2);
RegistroPipeline #(Width) R_3 (clock, reset, Multi_Kd, R3);
RegistroPipeline #(Width) R_4 (clock, reset, resta_Error, R4);
RegistroPipeline #(Width) R_5 (clock, reset, resta_D, R5);
RegistroPipeline #(Width) R_6 (clock, reset, suma_I, R6);
RegistroPipeline #(Width) R_7 (clock, reset, Multi_yk, R7);
RegistroPipeline #(Width) R_8 (clock, reset, suma_Aux, R8);
RegistroPipeline #(Width) R_9 (clock, reset, y_k, R9);

/////RegistroPipeline #(Width) R_



endmodule
