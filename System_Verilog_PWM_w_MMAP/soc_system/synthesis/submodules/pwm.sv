module pwm #(
	parameter width = 25,
	parameter max = 24999999
) (
	input logic clk,
	input logic reset,
	input logic [width-1:0] duty,
	output logic out
);

	logic [width-1:0] count;

	always_ff@(posedge clk or posedge reset)
		if (reset) count <= 0;
		else if (count < max) count <= count + 1;
		else count <= 0;

	assign out = (count <= duty);

endmodule
