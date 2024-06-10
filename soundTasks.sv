//Logic used in TB's
logic [3:0] sel;
logic [25:0] lights;
logic [31:0] lsamp=32'd0;
logic [31:0] rsamp=32'd0;
logic [31:0] lsampout, rsampout;
logic [31:0] [31:0] lsound, rsound;
logic clock=1'b0;
logic slowclock=1'b0;
logic reset=1'b1;
int numlights;
//tasks used
task randomSoundViz();
	for(int i=0; i<32; i++)begin
		 lsound[i]<=$urandom_range(32'd0,32'd4294967295)/32'd300;//lsamp;
		 rsound[i]<=$urandom_range(32'd0,32'd4294967295)/32'd300;//rsamp;
		 
		 #5 $display("Sample: %d ---< Left: %d  |  Right: %d >--- ", i, lsound[i], rsound[i]);
	end
endtask

task processSample();
	for(int i=0; i<32; i++) begin
		@(posedge clock);
		lsamp<=lsound[i];
		rsamp<=rsound[i];
		@(posedge clock);
		#5 $display("Sample: %d ---< Left: %d  |  Right: %d >--- ", i, lsampout, rsampout);
	end
endtask

task visualizerOut();
	for(int i=0; i<32; i++) begin
		@(posedge clock);
		numlights=0;
		lsamp<=lsound[i];
		rsamp<=rsound[i];
		for(int j=0; j<26; j++)begin
			if(lights[j]==1'b1) begin
				numlights++;
			end
		end
		$display("Lights: %d",numlights);
	end
endtask
task randomSound();
	for(int i=0; i<32; i++)begin
		 lsound[i]<=$urandom_range(32'd0,32'd4294967295);//lsamp;
		 rsound[i]<=$urandom_range(32'd0,32'd4294967295);//rsamp;
		 
		 #5 $display("Sample: %d ---< Left: %d  |  Right: %d >--- ", i, lsound[i], rsound[i]);
	end
endtask