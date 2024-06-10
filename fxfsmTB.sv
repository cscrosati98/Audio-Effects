`timescale 1ns/1ns
module fxfsmTB();

`include "soundTasks.sv";

fxfsm fxtb(.clock(clock), .slowclock(slowclock), .comclock(slowclock), .reset(reset), //fsm used to control the audio effects being applied digitally for output. 
					.sel(sel),
					.leftin(lsamp), .rightin(rsamp),
					.leftout(lsampout), .rightout(rsampout));	
						  
always #5 clock <= ~clock;
always #20 slowclock <= ~slowclock;
//always #5000 reset<=~reset;
initial begin
$display("Generating Audio Sample...");
randomSound();
$display("Pass Through Stream -------- SEL: 0000 ----->");
sel=4'b0000;
processSample();
#20 reset<=~reset;
#200 reset<=~reset;
$display("Bit Crush Stream ----------- SEL: 0001 ----->");
sel=4'b0001;
processSample();
#20 reset<=~reset;
#200 reset<=~reset;
$display("Mono Audio Stream ---------- SEL: 0010 ----->");
sel=4'b0010;
processSample();
#20 reset<=~reset;
#200 reset<=~reset;
$display("8-bit Res Stream ----------- SEL: 0100 ----->");
sel=4'b0100;
processSample();
#20 reset<=~reset;
#200 reset<=~reset;
$display("Compressor Stream ---------- SEL: 1000 ----->");
sel=4'b1000;
processSample();


end

endmodule