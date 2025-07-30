module controller (opcode,phase,zero,sel,rd,ld_ir,inc_pc,halt,ld_pc,data_e,ld_ac,wr);

	parameter INST_ADDR=0, INST_FETCH=1, INST_LOAD=2, IDLE=3, OP_ADDR=4, OP_FETCH=5, ALU_OP=6, STORE=7;
	
	input [2:0] opcode,phase;
	input zero;
	output reg sel,rd,ld_ir,inc_pc,halt,ld_pc,data_e,ld_ac,wr;

	reg HLT, SKZ, ADD, AND, XOR, LDA, STO, JMP;
    reg ALUOP;

	always @(*) begin

		case (opcode)
			0 : {HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP} = 8'b1000_0000;
			1 : {HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP} = 8'b0100_0000;
			2 : {HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP} = 8'b0010_0000;
			3 : {HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP} = 8'b0001_0000;
			4 : {HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP} = 8'b0000_1000;
			5 : {HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP} = 8'b0000_0100;
			6 : {HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP} = 8'b0000_0010;
			7 : {HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP} = 8'b0000_0001;
			default : {HLT,SKZ,ADD,AND,XOR,LDA,STO,JMP} = 8'b0000_0000;
		endcase

		ALUOP = ADD | AND | XOR | LDA;

		case (phase)
			INST_ADDR : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b1000_0000_0;
			INST_FETCH : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b1100_0000_0;
			INST_LOAD : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b1110_0000_0;
			IDLE : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b1110_0000_0;
			OP_ADDR : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {3'b0 , HLT , 1'b1 , 4'b0};
			OP_FETCH : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {1'b0 , ALUOP , 7'b0};
			ALU_OP : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {1'b0 , ALUOP , 2'b0 ,(SKZ && zero), 1'b0 , JMP , 1'b0 , STO};
			STORE : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = {1'b0 , ALUOP , 3'b0, ALUOP , JMP , STO , STO};
			default : {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 9'b0000_0000_0;
		endcase
	end



endmodule : controller