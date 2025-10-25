module counter_gen (clk,rst,load,enable,count_in,count_out);

	parameter WIDTH = 5;

	input clk,rst,load,enable;
	input [WIDTH-1 : 0] count_in;
	output reg [WIDTH-1 : 0] count_out;

	reg [WIDTH-1:0] next_count;

	always @(posedge clk or posedge rst) begin 
		if(rst) begin
			count_out <= 0;
		end else begin
			count_out <= next_count;
		end
	end

	always @(*) begin
		if (load)
			next_count = count_in;
		else if (enable)
			next_count = count_out + 1;
		else
			next_count = count_out;
	end


endmodule : counter_gen