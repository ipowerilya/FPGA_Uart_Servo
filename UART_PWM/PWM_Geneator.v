module PWM_Geneator(
	Clk,
	Rst_n,
	//
	total_dur,
	high_dur,
	
	//
	PWM
);


input 					Clk;
input						Rst_n;
input       [31:0]   high_dur;
input			[31:0]   total_dur;

output	reg			PWM;
reg	      [31:0]	tick;

always @ (posedge Clk or negedge Rst_n)
begin
	if (~Rst_n)
	begin
		tick <= 0;
	end
	else if (tick >= total_dur)
	begin
		tick <= 0;
	end
	else
		tick <= tick + 1;
end


always @ (negedge Clk or negedge Rst_n)
begin
	if (~Rst_n)
		PWM <= 0;
	else
		PWM <= (tick < high_dur)?1'b1:1'b0;//duck die width(5us)250  
end


endmodule
