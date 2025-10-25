module driver (data_in,data_en,data_out);

	parameter WIDTH = 8;

	input [WIDTH-1 : 0] data_in;
	input data_en;
	output reg [WIDTH-1 : 0] data_out;

	always @(*) begin
		if (data_en)
			data_out = data_in;
		else
			data_out = {WIDTH{1'bz}};
	end

endmodule : driver