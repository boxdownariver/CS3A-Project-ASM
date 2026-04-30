//
// UNFINISHED! TODO: complete lookup table
//
//
(mk_lookup_opt)
// DO m0 Match
@mk_bin_dec_iter             // Set index to iterator and check if zero
D=M
@mk_lookup_index
M=D                          // ^^ (Set index)
@mk_lookup_m0_zero
D;JEQ                        // ^^ (Check if zero)
@15                          // if R15, subtract 8 and skip to end
D=A
@mk_lookup_index
D=M-D                        // Because we work in D and not M, lookup_index isn't yet messed with.
@mk_lookup_m0_while          // Go to while if not R15
D;JNE
@8                           // Subtract 8
D=A
@mk_decBuffer                // decBuffer is a pointer
A=M
M=M-D                        // ^^
@mk_m0_return                // Skip to end of m0
0;JMP                        // ^^^ (if R15)
(mk_lookup_m0_while)         // subtract 4, if greater than zero, go again. then add 4 back.
@4
D=A
@mk_lookup_index
DM=M-D
@mk_lookup_m0_while
D;JGT                        // ^^^ (subtract 4 until <= 0)
@4                           // add back 4 when <= 0
D=A
@mk_lookup_index
M=D+M                        // ^^^ (add back 4 when <= 0)
(mk_lookup_m0_zero)
@mk_decBuffer
D=A
@mk_lookup_m_floater
M=D
@mk_m0_return
D=A
@mk_lookup_12486_return
M=D
@mk_lookup_12486
0;JMP
(mk_m0_return)
// DO m1 Match
@mk_mx_x                     // Setup mk_mx helpers
M=0
@mk_m1_return
D=A
@mk_mx_return
M=D                          // ^^^ (Setup mx helpers)
@mk_bin_dec_iter
D=M
@mk_lookup_index
M=D
@4
D=A
@mk_lookup_index
D=M-D
@mk_mx_set_0                 // If less than 4, 0
D;JLT
@mk_mx_set_1                 // If equal 4, 1
D;JEQ
D=D-1
@mk_mx_set_3                 // 5, 3
D;JEQ
D=D-1
@mk_mx_set_6
D;JEQ
D=D-1
@mk_mx_set_2
D;JEQ
D=D-1
@mk_mx_set_5
D;JEQ
D=D-1
@mk_mx_set_1
D;JEQ
D=D-1
@mk_mx_set_2
D;JEQ
D=D-1
@mk_mx_set_4
D;JEQ
D=D-1
@mk_mx_set_9
D;JEQ
D=D-1;JEQ
D=D-1;
@mk_mx_set_8
D;JEQ
D=D-1                        // 15 is the last one anyway
@mk_m1_sub_6
D;JEQ
(mk_m1_return)
// DO m2 Match
@mk_mx_x
M=M+1
@mk_m2_return                // Set return
D=A
@mk_mx_return
M=D
@mk_bin_dec_iter
D=M
@mk_lookup_index             // Set index
M=D
@12
D=A
@mk_lookup_index
D=M-D                        // Sub 12 from index
@mk_mx_set_0
D;JEQ                        // Jump if 12
D=D+1;JEQ                    // and if 11
D+1;JEQ                      // and if 10
@4
D=D+A
@mk_mx_set_0
D;JLT                        // Jump if less than 7
@mk_mx_set_1
D;JEQ                        // Jump if 7
@mk_mx_set_2
D=D-1;JEQ                    // Jump if 8
@mk_mx_set_5
D=D-1;JEQ                    // Jump if 9
@4
D=D-A
@mk_mx_set_1
D;JEQ                        // Jump if 13
@mk_mx_set_3
D=D-1;JEQ                    // Jump if 14
@mk_mx_sub_7
D-1;JEQ                      // Jump if 15
(mk_m2_return)
// DO m3 Match
@mk_bin_dec_iter             // Set lookup index
D=M
@mk_lookup_index
M=D                          // ^^ (index)
@mk_mx_x                     // Setup x for mk_mx
M=M+1
@mk_m3_return                // Setup return for mk_mx and mk_lookup_12486
D=A
@mk_mx_return
M=D                          // ^^ (mk_mx)
@mk_lookup_12486_return
M=D                          // ^^ (mk_lookup_12486)
@mk_lookup_index             // Begin index check: <10, 15. 10-14 are handled by mk_lookup_12486.
D=M
@10
D=D-A
@mk_mx_set_0
D;JLT                        // Jump if <10
@5
D=D-A
@mk_mx_sub_2
D;JEQ                        // Jump if 15
@10                          // set lookup_index -10
D=A
@mk_lookup_index
M=M-D                        // ^^ (set lookup_index)
@mk_decBuffer
D=M
@10
D=D+A
@mk_lookup_m_floater
M=D
@mx_lookup_12486
0;JMP
(mk_m3_return)
// DO m4 Match
@mk_mx_x                     // Increment x
M=M+1
@mk_lookup_opt_return        // Can return to bin_dec from here!
D=M
@mk_mx_return
M=D
@mk_bin_dec_iter             // Set lookup index to bin_dec_iter
D=M
@mk_lookup_index
M=D                          // ^^ (index)
@14                          // If less than 14, 0. If 14, 1. If greater than 14, sub 3.
D=D-A
@mk_mx_set_0
D;JLT                        // ^^ (<14)
@mk_mx_set_1
D;JEQ                        // ^^ (=14)
@mk_mx_sub_3
D;JGT                        // ^^ (>14)
@mk_lookup_opt_return
A=M
0;JMP

// Simplified lookup table for the 1,2,4,8,6 pattern, seen in about 5 places.
// Needs mk_lookup_12486_return, mk_lookup_m_floater.
// Set mk_lookup_m_floater to the address of the location on M.
// Set mk_lookup_12486_return to your return location.
// !!! What is mk_lookup_iterator????
// mk_lookup_iterator can be 0, 1, 2, 3 or 4... Probably where it is expected from 0 (subtract however much you need)
/// !! iterator is likely referencing index
(mk_lookup_12486)            // Switch / Match statemest
@mk_lookup_index
D=M
@mk_isnt_0                   // Zero case : Add 1
D;JEQ
@mk_lookup_m_floater
A=M
M=M+1
@mk_lookup_12486_return
A=M
0;JMP
(mk_isnt_0)

D=D-1
@mk_isnt_1                   // One case : Add 2
D;JEQ
@2
D=A
@mk_lookup_m_floater
A=M
M=D+M
@mk_lookup_12486_return
A=M
0;JMP
(mk_isnt_1)

D=D-1
@mk_isnt_2                   // Two case : Add 4
D;JEQ
@4
D=A
@mk_lookup_m_floater
A=M
M=D+M
@mk_lookup_12486_return
A=M
0;JMP
(mk_isnt_2)

D=D-1
@mk_isnt_3                   // Three case : Add 8
D;JEQ
@8
D=A
@mk_lookup_m_floater
A=M
M=D+M
@mk_lookup_12486_return
A=M
0;JMP
(mk_isnt_3)

@6                           // Four / Default Case : Add 6
D=A
@mk_lookup_m_floater
A=M
M=D+M
@mk_lookup_12486_return
A=M
0;JMP

define(`mk_mx_set',
`(mk_mx_set_$1)              // Subroutine : Add $1 to mx
@mk_decBuffer                // Get buffer
D=A
@mk_mx_x                     // Go to place in buffer
D=D+M
@mk_mx_pointer               // Save place in buffer
M=D
@$1                          // Add $1
D=A
@mk_mx_pointer
A=M
M=D+M                        // ^^^ (Add $1)
@mk_mx_return
A=M
0;JMP'
)dnl
mk_mx_set(0)
mk_mx_set(1)
mk_mx_set(2)
mk_mx_set(3)
mk_mx_set(4)
mk_mx_set(5)
mk_mx_set(6)
mk_mx_set(7)
mk_mx_set(8)
mk_mx_set(9)
