module audiotrans( inout AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK, I2C_SDAT,AUD_XCK, I2C_SCLK, AUD_ADCDAT, AUD_DACDAT,
						input logic CLOCK_50, reset_in, mic,
						input logic [0:3] volume,
						input logic [3:0] sel,
						output logic [25:0] lights,
						output logic [6:0] vol0, vol1);

//Declarations----------------------------------------------------------------------------------------------

	logic toggle_out, toggle_in, reset;

	logic slowclock,comclock;

	logic audio_in_available;

	logic [31:0] left_channel_audio_in;
	logic [31:0] right_channel_audio_in;

	logic read_audio_in;

	logic audio_out_allowed;

	logic [31:0] left_channel_audio_out;
	logic [31:0] right_channel_audio_out;

	logic write_audio_out;

	logic [31:0] right_internal, left_internal;
//Logic------------------------------------------------------------------------------------------------------

	always_comb begin
		read_audio_in	<= audio_in_available & audio_out_allowed;
		
		write_audio_out<= audio_in_available & audio_out_allowed;
		
		right_channel_audio_out<=right_internal*volume;
		
		left_channel_audio_out<=left_internal*volume;
	end

//Instatiations----------------------------------------------------------------------------------------------
	clockdiv sampclock(.iclk(CLOCK_50), .oclk(slowclock));

	clockdivcom comclk(.iclk(CLOCK_50), .oclk(comclock));

	reset rst(.clk(CLOCK_50), .rst(reset_in),.rstSync(reset));

	fxfsm fx(.clock(CLOCK_50), .slowclock(slowclock),.comclock(comclock), .reset(reset),
						 .sel(sel),
						.leftin(left_channel_audio_in),.rightin(right_channel_audio_in),
						.leftout(left_internal),.rightout(right_internal));

	visualizer viz(.clock(comclock), .reset(reset), .right(right_internal), .left(left_internal), .lights(lights));

	dualDisp dispVolume(.inputValue(volume), .disp1(vol0), .disp2(vol1));
	
	Audio_Controller Audio_Controller (
		// Inputs
		.CLOCK_50						(CLOCK_50),
		.reset						(~reset),

		.clear_audio_in_memory		(),
		.read_audio_in				(read_audio_in),
		
		.clear_audio_out_memory		(),
		.left_channel_audio_out		(left_channel_audio_out),
		.right_channel_audio_out	(right_channel_audio_out),
		.write_audio_out			(write_audio_out),

		.AUD_ADCDAT					(AUD_ADCDAT),

		// Bidirectionals
		.AUD_BCLK					(AUD_BCLK),
		.AUD_ADCLRCK				(AUD_ADCLRCK),
		.AUD_DACLRCK				(AUD_DACLRCK),


		// Outputs
		.audio_in_available			(audio_in_available),
		.left_channel_audio_in		(left_channel_audio_in),
		.right_channel_audio_in		(right_channel_audio_in),

		.audio_out_allowed			(audio_out_allowed),

		.AUD_XCK					(AUD_XCK),
		.AUD_DACDAT					(AUD_DACDAT),

		
	);
	avconf avc (
	.I2C_SCLK					(I2C_SCLK),
	.I2C_SDAT					(I2C_SDAT),
	.CLOCK_50					(CLOCK_50),
	.reset						(~reset),
	.USE_MIC_INPUT				(mic)
);

endmodule