module bitcrush(input logic [32:1] inleft, inright, //module that reduces the sample rate by using a slower clock
                    input logic reset, slowclock,
                    output logic [32:1] outleft, outright);		  


always_ff @(posedge slowclock or negedge reset) begin
	if(~reset) begin
		outleft=32'd0;
		outright=32'd0;
	end else begin
		outleft=inleft;
		outright=inright;
	end
end

endmodule