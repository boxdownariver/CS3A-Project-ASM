all: main.asm ge_output_x.asm
	m4 main.asm > out.asm

run: out.asm
	../../../Downloads/nand2tetris/nand2tetris/nand2tetris/tools/CPUEmulator.sh
