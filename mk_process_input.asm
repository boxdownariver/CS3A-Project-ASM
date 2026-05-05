// Process keyboard input, accumulate only ones and zeroes... then take "enter" and "backspace" controls.
// 'c' control clears the input, and 'q' control exits the program (clearing, then calling END).
// Only 16 slots available... decide how to proceed with a 17th input (ignore?).
// mk_getKey, mk_addBuf, mk_delBuf, mk_clearBuf can be handled here. Would be best to give mk_processBuf its own file.
// Processing "enter" should call mk_processBuf.

// mk_addBuf : add number to buffer.
(mk_addBuf)
@16                // Exit early if buffer full
D=M
@buffer_size
D=M-D
@mk_addBuf_return
D;JEQ              // ^
@buffer_size       // Increment buffer
M=M+1              // ^
@mk_getKey_output  // Cannot write value direct to buffer, too little reg. Branch to write 0 or 1. <- Update: Just realized I could save the address to another var, then treat it as a var write. Theoretically? I need sleep. COME BACK TO THIS!
D=M
@mk_addBuf_ifzero
D;JEQ              // ^
@buffer_size       // Write 1 to buffer at index
D=M-1
@R0                // !! Changing buffer reference to R0
A=D+A
M=1
@mk_addBuf_return
0;JMP              // ^
(mk_addBuf_ifzero)
@buffer_size       // Write 0 to buffer at index
D=M-1
@R0
A=D+A              // !! Changing buffer ref to R0
M=0
@mk_addBuf_return
0;JMP              // ^

// mk_delBuf : delete number from buffer. Virtual deletion likely okay as long as a size check is done on print.
(mk_delBuf)
@buffer_size
M=M-1
@mk_delBuf_return
0;JMP

// mk_clearBuf : Clear whole buffer. Virtual deletion still likely okay as long as size is upheld. Don't waste cycles formatting memory.
(mk_clearBuf)
@buffer_size
M=0
@mk_clearBuf_return
0;JMP
