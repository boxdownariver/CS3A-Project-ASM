include(`definitions.asm')
// Binary to Decimal conversion using virtual slots
// Should also make a GE style conversion using division... basically, double dabble.
// Divide by 10 until 0, appending to decBuffer in reverse
// Use R to append to decBuffer, and Q to go through next loop
// If 0 before all of decBuffer is filled, then shift to end and prepend zeros? Maybe not needed.
// If input negative, then turn positive and add negative sign
// Outputs: decBuffer, negative.

(mk_bin_dec)
@mk_decBuffer
D=M
@mk_decBuffer_it
M=D-1                        // Start back one so that iterator can be increased on each read/write
mk_execute_bin_bin(back2dec)
@mk_bin_bin_out              // Retrieve output for first run
D=M
@mk_bin_dec_negative         // Negative sign absent by default
M=0
@mk_bin_dec_not_negative     // If negative, turn positive and add negative sign. Skip if positive
D;JGE
@mk_bin_bin_out
MD=-D
@mk_bin_dec_negative
M=1
(mk_bin_dec_not_negative)
(mk_bin_dec_div_loop)        // Division and remainder extraction loop
@mk_divide_dividend          // Put whatever's in D into the dividend... D is either the bin_bin_out or the previous quotient
M=D
@10                          // Put 10 into divisor
D=A
@mk_divide_divisor           // ^^(Put 10 into divisor)
M=D
@mk_positive_divide          // Divide
0;JMP
@mk_divide_remainder         // Put remainder into BCD 'decBuffer' and go to next decBuffer location
D=M
@mk_decBuffer_it
AM=M+1                       // ^^ (Go to next decBuffer location)
M=D                          // ^^ (Put remainder into decBuffer. We start 1 index back so that this works after going to the next location.)
@mk_decBuffer_size
M=M+1
@mk_divide_quotient          // Use quotient in next division if nonzero; exit if zero
D=M                          // Used for loop comparison AND for future divisions
@mk_bin_dec_div_loop         // ^^ (Division / remainder loop)
D;JNE                        // Keep looping as long as there are divisions to be made
@mk_bin_dec_return           // Function Return
A=M
0;JMP                        // ^^
