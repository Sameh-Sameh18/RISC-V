module top (clk_in,rst_in,halt);

    parameter WIDTH = 8;
    parameter A_WIDTH = 5;

    input clk_in,rst_in;
    output halt;

    wire [WIDTH-1:0] alu_out, ac_out, data, reg_ir_out;
    wire [A_WIDTH-1:0] addr, pc_addr, ir_addr;
    wire [2:0] op_code, phase;
    wire zero, sel, rd, ld_ir, inc_pc, ld_pc, data_e, ld_ac, wr;


    assign op_code = reg_ir_out [WIDTH-1 : WIDTH-3];
    assign ir_addr = reg_ir_out [WIDTH-4 : 0];


    // Modules instantiation
    ALU alu_inst (.a(ac_out), .b(data), .op_code(op_code), .alu_out(alu_out), .a_is_zero(zero));

    register #(WIDTH) register_ac (.clk(clk_in), .rst(rst_in), .load(ld_ac), .data_in(alu_out), .data_out(ac_out));
    register #(WIDTH) register_ir (.clk(clk_in), .rst(rst_in), .load(ld_ir), .data_in(data), .data_out(reg_ir_out));

    counter_gen #(A_WIDTH) counter_pc (.clk(clk_in), .rst(rst_in), .load(ld_pc), .enable(inc_pc), .count_in(ir_addr), .count_out(pc_addr));

    driver driver_inst (.data_in(alu_out), .data_en(data_e), .data_out(data));

    single_bi_mem #(A_WIDTH, WIDTH) memory_inst (.clk(clk_in), .rd(rd), .wr(wr), .addr(addr), .data(data));

    controller controller_inst (.opcode(op_code), .phase(phase), .zero(zero), .sel(sel), .rd(rd), .ld_ir(ld_ir), 
                                .inc_pc(inc_pc), .halt(halt), .ld_pc(ld_pc), .data_e(data_e), .ld_ac(ld_ac), .wr(wr));

    mux_2to1 #(A_WIDTH) address_mux (.a(ir_addr), .b(pc_addr), .sel(sel), .out(addr));

    // Phase generator
    counter_gen #(3) phase_gen (.clk(clk_in), .rst(rst_in), .load(1'b0), .enable(1'b1), .count_in(3'b0), .count_out(phase));

endmodule : top