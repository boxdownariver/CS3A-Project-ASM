include(`definitions.asm')
// Binary to Decimal conversion using virtual slots

// Decimal number virtual buffer
@10000
D=A
@mk_decBuffer
M=D
@mk_decBuffer_size
M=0

(mk_bin_dec)                 // Enter conversion
mk_execute_twocomp(mk_bin_dec_2c)
@R15
D=M
@not_32768                   // IF -32768, set output so. IF NOT, skip.
D;JEQ
@3
D=A
@mk_decBuffer
M=D                          // 3
A=A+1
M=D-1                        // 2
@7
D=A
@mk_decBuffer
A=A+1
A=A+1
M=D                          // 7
A=A+1
M=D-1                        // 6
A=A+1
M=D+1                        // 8
(not_32768)                  // ^^
@14                          // Start iterator at 14, counting down
D=A
@mk_bin_dec_iter
M=D                          // ^^
(mk_bin_dec_loop)
@mk_bin_dec_iter
D=M
@R0
A=A+D
D=M
@mk_r_is_zero
D;JEQ
// Put inner action here! For each R, do the algorithm on M.
(mk_r_is_zero)
@mk_bin_dec_iter
DM=M-1
@mk_bin_dec_loop
D;JGE                        // Loop again if iter is 14->0, stop once it isn't
@mk_bin_dec_return
A=M
0;JMP                        // Exit conversion

(mk_twocomp)
@15
D=A
@mk_twocomp_iter
M=D
(mk_twocomp_loop1)
@mk_twocomp_iter
D=M
@R0
A=A+D                        // Messing with R[iter]
M=M-1                        // flip: M = 1 - M... 1 - 1 = 0, 1 - 0 = 1
M=-M                         // ^
@mk_twocomp_iter
DM=M-1
@mk_twocomp_loop1
D;JGE                        // Loop again if iter is 14->0, stop once it isn't
@mk_twocomp_iter
M=0                          // Reset iter
(mk_twocomp_loop2)           // Loop 2: accumulate the add upwards from the lowest bit
@mk_twocomp_iter
D=M
@R0
D=D+A
@mk_twocomp_currentIndex     // Current index pointer of the register buffer
MA=D
@mk_twocomp_loop2_still_one  // If current index is still one, skip this. Sets index to 1 and ends program if 0
D;JNE
@mk_twocomp_currentIndex
A=M
M=1
@mk_twocomp_loop2_early_exit
0;JMP
(mk_twocomp_loop2_still_one) // ^^
@mk_twocomp_currentIndex     // If current index is one, can set it to zero (loop ends on first zero)
A=M
M=0
@mk_twocomp_iter             // Increment iterator
DM=M+1
@15
D=D-A
@mk_twocomp_loop2
D;JLE                        // Loop again if iter is 1->15 (loops once and adds 1 at the end of each)
(mk_twocomp_loop2_early_exit)
@mk_twocomp_return
A=M
0;JMP
