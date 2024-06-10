module fxfsm(input logic clock, slowclock, comclock, reset, //fsm used to control the audio effects being applied digitally for output. 
					input logic [3:0] sel,
					input logic [31:0] leftin,rightin,
					output logic [31:0] leftout,rightout);
					
	logic [31:0] bcright, bcleft, compright, compleft;//internal logic for audio effect output
				
	typedef enum logic [3:0] {IDLE, BCRUSH, MONO, BIT8, COMP} statetype; //states for state machine
	
	statetype presentState = IDLE, nextState;
	
	always_ff@(posedge clock or negedge reset)
		begin
		if(~reset) begin
			presentState<=IDLE;
		end else begin
			presentState<=nextState;
		end
		end
	always_comb
		begin
			case(presentState)
			
			IDLE: if(sel==4'b0001) //if SW4 is on, go to bit crush
			
							nextState<=BCRUSH;
							
					else if(sel==4'b0010) //if SW5 is on, go to mono
					
							nextState<=MONO;
							
							else if(sel==4'b0100) //if SW6 is on, go to 8-bit res audio
					
								nextState<=BIT8;
							
								else if(sel==4'b1000) //if SW7 is on, go to audio compressor
					
									nextState<=COMP;
							
									else
								
										nextState<=IDLE; //otherwise stay in idle
	
							
			BCRUSH: if(sel==4'b0000)
			
							nextState<=IDLE;
							
					else
					
							nextState<=BCRUSH; //stay

			MONO: if(sel==4'b0000)
			
							nextState<=IDLE;
							
					else
					
							nextState<=MONO; //stay
			BIT8: if(sel==4'b0000)
			
							nextState<=IDLE;
							
					else
					
							nextState<=BIT8; //stay
			COMP: if(sel==4'b0000)
			
							nextState<=IDLE;
							
					else
					
							nextState<=COMP; //stay
			endcase
		end
		
	always_ff@(posedge clock or negedge reset)
		begin
		if(~reset) begin
		leftout<=32'd0;
		rightout<=32'd0;
		end else begin
		
			case(presentState)
			
				IDLE: begin //stream unaltered audio
				leftout<=leftin;
				rightout<=rightin;
				end
				
								
				BCRUSH: begin //stream bitcrushed audio
				leftout<=bcleft;
				rightout<=bcright;
				end
						
				MONO: begin //stream mono audio by assigning left to right as well
				leftout<=leftin;
				rightout<=leftin;
				end
				
				BIT8: begin //reduce resolution to 8-bit by dividing by 8-bit resultion
				leftout<=leftin/(32'd256);
				rightout<=rightin/(32'd256);
				end
				
				COMP: begin
				leftout<=compleft;
				rightout<=compright;
				end
			
			endcase
			
			end
		end
		compressor comp(.inleft(leftin), .inright(rightin), //instantiate compressor module
								.clock(CLOCK_50), .reset(reset),
								.outleft(compleft), .outright(compright));
		bitcrush bc(.inright(rightin), .inleft(leftin), .slowclock(slowclock), //instantiate bitcrush module
						.reset(reset),
						.outright(bcright),.outleft(bcleft));	
								

endmodule