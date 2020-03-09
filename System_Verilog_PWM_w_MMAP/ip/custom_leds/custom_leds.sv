module custom_leds
(
    input  logic        clk,                // clock.clk
    input  logic        reset,              // reset.reset
    
    // Memory mapped read/write slave interface
    input  logic        avs_s0_address,     // avs_s0.address
    input  logic        avs_s0_read,        // avs_s0.read
    input  logic        avs_s0_write,       // avs_s0.write
    output logic [31:0] avs_s0_readdata,    // avs_s0.readdata
    input  logic [31:0] avs_s0_writedata,   // avs_s0.writedata
    
    // The LED outputs
    output logic [no_leds-1:0]  leds
);

parameter no_leds = 8;
parameter res = 8;
parameter width = 26;
parameter max = 49_999_999;

parameter duty_min = 24_999_999;
parameter duty_max = 49_999_999;

logic [no_leds*res-1:0] duty;

generate
	genvar i;
	for (i = 0; i < no_leds; i = i + 1) begin: gen_pwm
		pwm #(.width(width), .max(max)) gen(
			.clk(clk),
			.reset(reset),
			.duty( (duty[i*res +: res]*(duty_max-duty_min))/((2**res)-1)+duty_min ),
			.out(leds[i])
		);
	end
endgenerate

// Read operations performed on the Avalon-MM Slave interface
always_comb begin
    if (avs_s0_read) begin
        case (avs_s0_address)
            1'b0    : avs_s0_readdata = {24'b0, leds};
            default : avs_s0_readdata = 'x;
        endcase
    end else begin
        avs_s0_readdata = 'x;
    end
end

// Write operations performed on the Avalon-MM Slave interface
always_ff @ (posedge clk) begin
    if (reset) begin
        duty <= '0;
    end else if (avs_s0_write) begin
        case (avs_s0_address)
            1'b0    : duty[(avs_s0_writedata[7:0] < no_leds ? avs_s0_writedata[7:0] : no_leds)*res +: res] <= avs_s0_writedata[15:8];
            default : duty <= duty;
        endcase
    end
end

endmodule // custom_leds
