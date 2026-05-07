//**************************************************
//
// mk_positive_divide : Divide dividend by divisor
//__________________________________________________
//
// Inputs  : mk_divide_dividend, mk_divide_divisor
// Outputs : mk_divide_quotient, mk_divide_remainder
//__________________________________________________
//
// This program divides a positive dividend by a
// positive divisor, by subtracting the divisor
// from the dividend until negative, adding
// 1 * divisor back into the dividend, and taking
// the iteration count as the quotient and the
// remaining value of the dividend as the remainder.
//__________________________________________________
// pseudocode :
//
// remainder = dividend;
// for (quotient = 0; remainder >= 0; ++quotient) {
//   remainder -= divisor;
// }
// --quotient;
// remainder += divisor;
// return;
//
//**************************************************

(mk_positive_divide)
@mk_divide_quotient          // Initialize quotient to 0
M=0
@mk_divide_dividend          // Initialize remainder to dividend
D=M
@mk_divide_remainder
M=D                          // ^^ (Init remainder to dividend)
(mk_divide_loop)             // Loop: Subtract from remainder and increment quotient until remainder is negative
@mk_divide_quotient          // Increment quotient
M=M+1
@mk_divide_divisor           // Sub divisor from remainder
D=M
@mk_divide_remainder
DM=M-D                       // ^^ (Sub divisor from remainder)
@mk_divide_loop
D;JGE                        // Loop again if remainder is positive or zero
@mk_divide_quotient          // Bring quotient back down by 1 to roll back one op
M=M-1
@mk_divide_divisor           // Bring remainder back up by 1 * divisor to roll back one op
D=M
@mk_divide_remainder
M=M+D                        // ^^ (Add divisor back to remainder)
@mk_positive_divide_return
A=M
0;JMP
