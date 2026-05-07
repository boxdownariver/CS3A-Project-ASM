// ======================================================
// File: main.asm
// Description:
//    Control loop for keyboad inputs. This program reads
//    an input, updates a buffer, and performs actions
//    based on specific keys based on user input.
//
include(`definitions.asm')

// Decimal number virtual buffer
@10000
D=A
@mk_decBuffer
M=D
@mk_decBuffer_size
M=0
@buffer_size       // Buffer size for external (RXX) buffer
M=0

(mainEntry)        // Program entry


(END)              // Program 'exit'
@END
0;JMP

include(`mk_process_input.asm')
include(`mk_output_branch.asm')
include(`mk_bin_dec.asm')
include(`ge_output_x.asm')
