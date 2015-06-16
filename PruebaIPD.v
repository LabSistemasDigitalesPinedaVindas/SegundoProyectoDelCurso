`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:20:41 05/26/2015
// Design Name:   IPD
// Module Name:   C:/Users/Andres Pineda/Dropbox/Servo Motor/ServoMotor/ServoMotorJ/PruebaIPD.v
// Project Name:  ServoMotorJ
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: IPD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaIPD;

	// Inputs
	reg clock;
	reg enable;
	reg reset;
	reg [18:0] referencia;
	reg [18:0] y_k;
	reg [18:0] arrayIN [0:999];

	// Outputs
	wire [18:0] salida_IPD;
	wire [18:0] integral,derivativa,prop;
	integer ipd,inte,deriv,pro;

	// Instantiate the Unit Under Test (UUT)
	IPD uut (
		.clock(clock), 
		.enable(enable), 
		.reset(reset), 
		.referencia(referencia), 
		.y_k(y_k), 
		.salida_IPD(salida_IPD),
		.integral(integral),
		.derivativa(derivativa),
		.prop(prop)
	);
	
	initial forever
	#1 clock = ~clock;
	
	integer i;
	
	initial 
		begin
			$readmemb("rampa.txt", arrayIN);
		end

	initial begin
		// Initialize Inputs
		clock = 0;
		enable = 0;
		reset = 0;
		//referencia = 12'b000000001010; //10
		//referencia = 12'b001111101000; //1000
		referencia = 12'b000001100100;//100
		y_k = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
		reset = 1;
		
		#10 reset = 0;
		
		
		ipd = $fopen ("ipd.txt");
		pro = $fopen ("proporcional.txt");
		inte = $fopen ("integral.txt");
		deriv = $fopen ("derivativa.txt");
		
		
		for(i=0;i<101;i=i+1)
			begin 
				@(posedge clock)
				enable = 0;
				y_k = arrayIN[i];
				@(negedge clock)
				enable = 1;	
				//uk = arrayIN[i];

				$fdisplayb(ipd,salida_IPD);
				$fdisplayb(pro,prop);
				$fdisplayb(inte,integral);
				$fdisplayb(deriv,derivativa);
				
	
        end
		// Add stimulus here

	end
      
endmodule

