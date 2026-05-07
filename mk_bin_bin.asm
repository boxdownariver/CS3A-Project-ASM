// ****************************************************************************************************
//
// mk_bin_bin : Take R0 through R15, and convert to one binary number (bin_bin_out)
//_____________________________________________________________________________________________________
//
// Inputs     : Rn for 0 through 15.
// Outputs    : mk_bin_bin_out -> Single number representing binary series R.
//_____________________________________________________________________________________________________
//
// Process    : Loop through R, and add the corresponding power of 2 to bin_bin_out when Rn is nonzero.
//_____________________________________________________________________________________________________
//
// Pseudocode :
//
// two_power =   1;          // Two to the zero
// pointer   = &R0;
// out       =   0;
// for (iterator = 0; iterator <= 15; ++iterator) { // Could shorten by doing iterator 15 -> 0
//   if (!*pointer) {
//     out += two_power;
//   }
//   ++pointer;
//   two_power += two_power; // Double... multiplying by 2
// }
//
// ****************************************************************************************************
(mk_bin_bin)
@mk_two_power         // Instantiate two's power to 1 (two to the zero)
M=1
@R0                   // Instantiate pointer to R0 (R of 0)
D=A
@mk_bin_bin_pointer
M=D                   // ^^ (Instantiate pointer to R0)
@mk_bin_bin_iterator  // Instantiate iterator to 0
M=0
@mk_bin_bin_out       // Instantiate bin_bin_out to 0
M=0
(mk_bin_bin_loop)     // Loop: add two's power if Rn is nonzero, then increase two's power and check n+1
@mk_bin_bin_pointer   // Skip if zero
A=M
D=M
@mk_bin_bin_zero
D;JEQ                 // ^^ (Skip if zero)
@mk_two_power         // Add current two's power to out
D=M
@mk_bin_bin_out
M=M+D                 // ^^ (Add current two's power to out)
(mk_bin_bin_zero)     // ^^ (Skip if zero)
@mk_bin_bin_pointer   // Shift pointer to next index
M=M+1
@mk_two_power         // Double two's power (increase the power)
D=M
M=M+D                 // ^^ (Double two's power)
@15                   // Check if iterator is 15 yet; increment iterator
D=A
@mk_bin_bin_iterator
D=D-M                 // Subtract iterator from 15 (check if 15)
M=M+1                 // ^^ (Increment iterator)
@mk_bin_bin_loop
D;JGT                 // Once iterator is 15, quit loop
@mk_bin_bin_return    // Return
A=M
0;JMP                 // ^^ (Return)
