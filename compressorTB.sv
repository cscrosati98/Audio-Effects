`timescale 1ns/1ns
module compressorTB();

`include "soundTasks.sv";

compressor comptb(.inleft(lsamp), .inright(rsamp),
                    .reset(reset), .clock(clock),
                    .outleft(lsampout), .outright(rsampout));	


always #5 clock <= ~clock;
//always #425 reset<=~reset;
initial begin
$display("Generating Audio Sample...");
randomSound();
#10 reset<=~reset;
#10 reset<=~reset;
$display("Compressor Stream ---------------->");
processSample();

end

endmodule