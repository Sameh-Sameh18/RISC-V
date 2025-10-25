module mux_2to1 (a,b,sel,out);

	parameter WIDTH = 1;

	input [WIDTH-1 : 0] a,b;
	input sel;
	output reg [WIDTH-1 : 0] out;

	always @(*) begin
		case (sel)
			1'b0 : out = a;
			1'b1 : out = b;
			default : out = 0;
		endcase
	end

endmodule : mux_2to1