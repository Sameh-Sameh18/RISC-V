module register (clk,rst,load,data_in,data_out);

	parameter WIDTH = 8;

	input clk,load,rst;
	input [WIDTH-1 : 0 ] data_in;
	output reg [WIDTH-1 : 0] data_out;

	always @(posedge clk or posedge rst) begin
		if(rst) 
			data_out <= 0;
		else if (load) 
			data_out <= data_in ;
	end

endmodule : register