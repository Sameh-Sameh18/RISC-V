module single_bi_mem (clk,rd,wr,addr,data);

	parameter A_WIDTH = 5 , D_WIDTH = 8;

	input clk,rd,wr;
	input [A_WIDTH-1 : 0] addr;
	inout [D_WIDTH-1 : 0] data;

	reg [D_WIDTH-1 : 0] mem [(1 << A_WIDTH) - 1 : 0];

	always @(posedge clk) begin 
		if (wr)
			mem[addr] <= data;
	end

	assign data = (rd) ? mem[addr] : {D_WIDTH{1'bz}};

endmodule : single_bi_mem