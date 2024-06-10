module synchronizer(input logic clock, input logic signal, 
							output logic syncSignal, fallEdge, riseEdge);
		logic sFF1, sFF2;
		always_ff@(posedge clock)//Sync signal using FF's
		begin
			sFF1<=signal;
			syncSignal<=sFF1;
			sFF2<=syncSignal;
		end
		// 0 1 Falling edge
		assign fallEdge = (~syncSignal && sFF2);
		// 1 0 Rising Edge
		assign riseEdge = (syncSignal && ~sFF2);

endmodule