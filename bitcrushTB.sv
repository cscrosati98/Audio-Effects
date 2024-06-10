`timescale 1ns/1ns
module bitcrushTB();

`include "soundTasks.sv";

bitcrush bittb(.inleft(lsamp), .inright(rsamp),
                    .reset(reset), .slowclock(slowclock),
                    .outleft(lsampout), .outright(rsampout));	


always #5 clock <= ~clock;
always #20 slowclock <= ~slowclock;
always #600 reset<=~reset;
initial begin
$display("Generating Audio Sample...");
randomSound();
$display("Bit Crush Stream ---------------->");
processSample();

end

endmodule