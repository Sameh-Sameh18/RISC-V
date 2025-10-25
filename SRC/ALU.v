module ALU (a,b,op_code,alu_out,a_is_zero);

	parameter WIDTH = 8;

	input [WIDTH-1 : 0] a,b;
	input [2:0] op_code;
	output reg a_is_zero;
	output reg [WIDTH-1 : 0] alu_out;

	always @(*) begin
		case (op_code)
			0 : alu_out = a;
			1 : alu_out = a;
			2 : alu_out = a + b;
			3 : alu_out = a & b;
			4 : alu_out = a ^ b;
			5 : alu_out = b;
			6 : alu_out = a;
			7 : alu_out = a;
			default : alu_out = 0;
		endcase
		a_is_zero = (alu_out == 0) ? 1 : 0;
	end

endmodule : ALU