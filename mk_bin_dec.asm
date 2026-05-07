include(`definitions.asm')
//*****************************************************************************************************
//
// mk_bin_dec : Convert binary representation of a number to BCD representation.
//_____________________________________________________________________________________________________
//
// Inputs     : R0 through R15      -> Binary representation array
// Outputs    : mk_decBuffer        -> BCD representation array
//              mk_bin_dec_negative -> Whether the representation should be prepended with '-'
//_____________________________________________________________________________________________________
//
// Process    : First, execute mk_bin_bin. This produces a single-number version of the binary
//              array. If the output of bin_bin is negative, then turn it positive and use the
//              "negative output" signal. Then, loop, dividing that number by 10, adding the
//              remainder to the output, and using the quotient as that number for the next loop.
//              Exit loop when the quotient reaches 0.
//_____________________________________________________________________________________________________
//
// Pseudocode :
//
// negative     = 0;
// decBuffer_it = decBuffer - 1;       // Starting back one allows the increment of decBuffer to
//                                     // be combined with its access
// mk_bin_bin();                       // Outputs bin_bin_out
// if (!(bin_bin_out >= 0)) {
//   negative = 1;
//   bin_bin_out = -bin_bin_out;
// }
// dividend = bin_bin_out;
// do {
//   mk_positive_divide(dividend, 10); // Outputs divide_remainder and divide_quotient
//   *(decBuffer_it++) = divide_remainder;
//   dividend = divide_quotient;
// } while (divide_quotient != 0);
// return;
//
//*****************************************************************************************************

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

include(`mk_bin_bin.asm')
include(`mk_positive_divide.asm')
