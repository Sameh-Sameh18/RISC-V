This project implements a simple 8-bit RISC (Reduced Instruction Set Computer) in Verilog HDL.
It demonstrates the fundamental building blocks of a CPU including:

Arithmetic Logic Unit (ALU)

Register File

Program Counter (PC)

Controller (microcode logic)

Bidirectional Memory

Multiplexers, Drivers, and Counters

Fully automated testbench with multiple instruction-level tests

The design executes a custom 3-bit opcode instruction set and supports basic control and arithmetic operations (HLT, SKZ, ADD, AND, XOR, LDA, STO, JMP).

System Architecture:

| Component                   | Description                                                                                  |
| --------------------------- | -------------------------------------------------------------------------------------------- |
| **ALU**                     | Performs arithmetic and logic operations (`ADD`, `AND`, `XOR`, etc.) and sets the zero flag. |
| **Controller**              | Generates control signals based on the current instruction and phase.                        |
| **Register**                | Stores intermediate values like the accumulator (AC) and instruction register (IR).          |
| **Counter_gen**             | Implements both the **Program Counter (PC)** and **Phase Counter**.                          |
| **Driver**                  | Controls tri-state data bus enabling.                                                        |
| **Mux_2to1**                | Selects between instruction address and program counter address.                             |
| **Single_bi_mem**           | Unified memory for program and data (bidirectional).                                         |
| **Top**                     | Connects all components into a working CPU.                                                  |
| **Testbench (`risc_test`)** | Simulates and verifies CPU functionality using multiple test programs.                       |


Instruction Set:

| Mnemonic | Opcode (Binary) | Function                                     |
| -------- | --------------- | -------------------------------------------- |
| `HLT`    | `000`           | Halt the CPU                                 |
| `SKZ`    | `001`           | Skip next instruction if accumulator is zero |
| `ADD`    | `010`           | Add memory operand to accumulator            |
| `AND`    | `011`           | Logical AND with memory operand              |
| `XOR`    | `100`           | Logical XOR with memory operand              |
| `LDA`    | `101`           | Load memory operand into accumulator         |
| `STO`    | `110`           | Store accumulator value into memory          |
| `JMP`    | `111`           | Jump to memory address                       |


The project includes three diagnostic test files:

| File           | Description                                          |
| -------------- | ---------------------------------------------------- |
| `CPUtest1.txt` | Tests basic instruction set (JMP, SKZ, STO, XOR).    |
| `CPUtest2.txt` | Tests arithmetic operations (ADD, AND, XOR).         |
| `CPUtest3.txt` | Runs a Fibonacci program (loop, arithmetic, branch). |


Author

Sameh Mohammed
