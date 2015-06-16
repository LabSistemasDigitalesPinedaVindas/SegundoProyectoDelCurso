`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:45 05/29/2015 
// Design Name: 
// Module Name:    PWM 
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
module PWM(

	input clk,
	input [7:0]ipd,
	output  pwm
    );
	  // muestreo = 5ms , clock de 100MHz
	  // T = muestreo * clock = 500000s
	  // step count = 256
	  // step_delay = T/256 = 1953
	  
	 parameter step_delay = 39;
	 
	 
	reg pwmReg;
	reg [13:0] cont = 0; // log2(500000) = 18.93
	
	always @ (posedge clk)
		
		begin
			cont = cont + 1'b1;
			if (cont <= ipd*step_delay)
				pwmReg = 1;
				
			else 
				pwmReg = 0;
				
			if (cont >= 10000)
				cont = 0;
		end
		
		assign pwm = pwmReg;
		
endmodule
