module dualDisp(input logic [3:0] inputValue, output logic [6:0] disp1, disp2);
logic [3:0] inDisp1, inDisp2;
logic [3:0] inValue=4'b0000;
always_comb
begin
			inValue <= inputValue;//else set value in
end
always_comb 
begin
		if(inValue>=4'd10) begin//if greater than or equal to 10, seperate digits
			
			inDisp2 <= inValue % 4'd10;
			inDisp1 <= inValue/(4'd10);
			
		end else begin//else set first digit
		
			inDisp1<=0;
			inDisp2<=inValue;
			
		end
end
displayLogic display1(.dispNum(inDisp1),.dispOut(disp1));
displayLogic display2(.dispNum(inDisp2),.dispOut(disp2));
endmodule