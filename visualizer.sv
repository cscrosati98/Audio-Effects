module visualizer(input logic clock, reset,			//uses a combined average of the previous 10 samples to drive a set of LED's sequentially. 
						input logic [31:0] right, left,
						output logic [25:0] lights);
						
		int i;
		
		logic [31:0] rms0, rms1, rms2, rms3, rms4, rms5, rms6, rms7, rms8, rms9, rms;
		logic [25:0] temp,rmstemp;
		
		always_comb begin
		rms0 = ((left + right) / 32'd2);
		 for(i = 25; i >= 0; i = i - 1)
			  begin
				temp[i] = ( rms > (600000/2*i) ) ? 1'b1 : 1'b0; //if the averaged value is greater than threshold step, set the temp array at index i to 1. 
			  end
		end
		
		always_ff @(posedge clock or negedge reset)begin
			if(~reset) begin
				rms9<=32'd0;
				rms8<=32'd0;
				rms7<=32'd0;
				rms6<=32'd0;
				rms5<=32'd0;
				rms4<=32'd0;
				rms3<=32'd0;
				rms2<=32'd0;
				rms1<=32'd0;
				rms<=32'd0;
				lights<=26'd0;
			end else begin
				rms8<=rms9;
				rms7<=rms6;
				rms6<=rms5;
				rms5<=rms4;
				rms4<=rms3;
				rms3<=rms2;
				rms2<=rms1;
				rms1<=rms0;
				lights<=temp; //asign temp array to lights
				rms <= (rms0 +rms1+rms2+rms3+rms4+rms5+rms6+rms7+rms8+rms9) / 32'd10;
			end
		end
endmodule