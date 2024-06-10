module compressor(input logic [31:0] inleft, inright, 				//module that attempts to replicate the sound of an analog compressor 
                        input logic clock, reset,     				//by using a predefined threshold to filter out audio, 
                        output logic [31:0] outleft, outright); 	//then replaces that audio with an average of the previous 20 samples

       logic [31:0]threshold = 32'd4294967295/32'd2; //half of max magnitude
		logic [31:0] rcomp0, rcomp1, rcomp2, rcomp3, rcomp4, rcomp5, rcomp6, rcomp7, rcomp8, rcomp9,rcomp10, rcomp11, rcomp12, rcomp13, rcomp14, rcomp15, rcomp16, rcomp17, rcomp18, rcomp19, rcomp;
		logic [31:0] lcomp0, lcomp1, lcomp2, lcomp3, lcomp4, lcomp5, lcomp6, lcomp7, lcomp8, lcomp9, lcomp10, lcomp11, lcomp12, lcomp13, lcomp14, lcomp15, lcomp16, lcomp17, lcomp18, lcomp19, lcomp;
		
		always_comb begin
			if (inleft<threshold) begin//if left audio greater than threshold, compress audio
				outleft <= (inleft);
			end else begin
				outleft <= threshold+(lcomp-threshold);
			end
			if (inright<threshold) begin //if right audio greater than threshold, compress audio
				outright <= (inright);

			end else begin
				outright <= threshold+(rcomp-threshold); 
			end
		end
		
		always_ff @(posedge clock or negedge reset)begin
			if(~reset) begin
				rcomp19<=32'd0;
				rcomp18<=32'd0;
				rcomp17<=32'd0;
				rcomp16<=32'd0;
				rcomp15<=32'd0;
				rcomp14<=32'd0;
				rcomp13<=32'd0;
				rcomp12<=32'd0;
				rcomp11<=32'd0;
				rcomp10<=32'd0;
				rcomp9<=32'd0;
				rcomp8<=32'd0;
				rcomp7<=32'd0;
				rcomp6<=32'd0;
				rcomp5<=32'd0;
				rcomp4<=32'd0;
				rcomp3<=32'd0;
				rcomp2<=32'd0;
				rcomp1<=32'd0;
				rcomp9<=32'd0;
				rcomp8<=32'd0;
				rcomp7<=32'd0;
				rcomp6<=32'd0;
				rcomp5<=32'd0;
				rcomp4<=32'd0;
				rcomp3<=32'd0;
				rcomp2<=32'd0;
				rcomp1<=32'd0;
				rcomp0<=32'd0;
				rcomp<=32'd0;
			end else begin
				rcomp19<=rcomp18;
				rcomp18<=rcomp17;
				rcomp17<=rcomp16;
				rcomp16<=rcomp15;
				rcomp15<=rcomp14;
				rcomp14<=rcomp13;
				rcomp13<=rcomp12;
				rcomp12<=rcomp11;
				rcomp11<=rcomp10;
				rcomp10<=rcomp9;
				rcomp8<=rcomp9;
				rcomp7<=rcomp6;
				rcomp6<=rcomp5;
				rcomp5<=rcomp4;
				rcomp4<=rcomp3;
				rcomp3<=rcomp2;
				rcomp2<=rcomp1;
				rcomp1<=rcomp0; //average right audio
				rcomp <= (rcomp0 +rcomp1+rcomp2+rcomp3+rcomp4+rcomp5+rcomp6+rcomp7+rcomp8+rcomp9+rcomp10 +rcomp11+rcomp12+rcomp13+rcomp14+rcomp15+rcomp16+rcomp17+rcomp18+rcomp19) / 32'd20;
			end
		end
		always_ff @(posedge clock or negedge reset)begin
			if(~reset) begin
				lcomp19<=32'd0;
				lcomp18<=32'd0;
				lcomp17<=32'd0;
				lcomp16<=32'd0;
				lcomp15<=32'd0;
				lcomp14<=32'd0;
				lcomp13<=32'd0;
				lcomp12<=32'd0;
				lcomp11<=32'd0;
				lcomp10<=32'd0;
				lcomp9<=32'd0;
				lcomp8<=32'd0;
				lcomp7<=32'd0;
				lcomp6<=32'd0;
				lcomp5<=32'd0;
				lcomp4<=32'd0;
				lcomp3<=32'd0;
				lcomp2<=32'd0;
				lcomp1<=32'd0;
				lcomp0<=32'd0;
				lcomp<=32'd0;
			end else begin
				lcomp19<=lcomp18;
				lcomp18<=lcomp17;
				lcomp17<=lcomp16;
				lcomp16<=lcomp15;
				lcomp15<=lcomp14;
				lcomp14<=lcomp13;
				lcomp13<=lcomp12;
				lcomp12<=lcomp11;
				lcomp11<=lcomp10;
				lcomp10<=lcomp9;
				lcomp8<=lcomp9;
				lcomp7<=lcomp6;
				lcomp6<=lcomp5;
				lcomp5<=lcomp4;
				lcomp4<=lcomp3;
				lcomp3<=lcomp2;
				lcomp2<=lcomp1;
				lcomp1<=lcomp0; //average left audio
				lcomp <= (lcomp0 +lcomp1+lcomp2+lcomp3+lcomp4+lcomp5+lcomp6+lcomp7+lcomp8+lcomp9+lcomp10 +lcomp11+lcomp12+lcomp13+lcomp14+lcomp15+lcomp16+lcomp17+lcomp18+lcomp19) / 32'd20;
			end
		end
endmodule