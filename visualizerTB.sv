`timescale 1ns/1ns
module visualizerTB();

`include "soundTasks.sv";

visualizer vistb(.right(rsamp), .left(lsamp), //module that reduces the sample rate by using a slower clock
                    .reset(reset), .clock(slowclock),
                    .lights(lights));	
						  
always #5 clock <= ~clock;
always #10 slowclock <= ~slowclock;
always #300 reset<=~reset;
initial begin
#10 reset<=~reset;
#10 reset<=~reset;
$display("Generating Audio Sample...");
randomSound();
$display("Light Output ---------------->");
visualizerOut();

end

endmodule