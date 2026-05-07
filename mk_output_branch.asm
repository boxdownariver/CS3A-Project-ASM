//*****************************************************************************************************
//
// mk_output_branch : Branch between ge_output_X functions using a switch statement
//_____________________________________________________________________________________________________
//
// Inputs           : ge_dynamic_x -> ASCII symbol code to decode
// Outputs          : none... Instead, outputs to screen
// Preconditions    : Must set column to print to... using ge_currentColumn
//_____________________________________________________________________________________________________
//
// Pseudocode       : "n" is a number between 0 and 9.
//
// ge_output_return = mk_output_branch_return; // Make sure that return is set for ge_output
// if (ge_dynamic_x == 45) ge_output_-();
// if (ge_dynamic_x == 43) ge_output_+();
// switch (ge_dynamic_x - 48) {
// case "n":
//   ge_output_"n"();
// }
// return;
//
//*****************************************************************************************************
(mk_output_branch)
//Exit directly from ge_output_x if possible
@mk_output_branch_return
D=M
@ge_output_return
M=D

// special cases
@45                // Output minus sign
D=A
@ge_dynamic_x
D=M-D
@ge_output_-
D;JEQ              // End minus
@43                // Output plus sign
D=A
@ge_dynamic_x
D=M-D
@ge_output_+
D;JEQ              // End plus

// numeric cases
@48                // Output based on ASCII : 0 is Dec 48
D=A
@ge_dynamic_x
D=M-D
@ge_output_0
D;JEQ
@ge_output_1
D=D-1;JEQ
@ge_output_2
D=D-1;JEQ
@ge_output_3
D=D-1;JEQ
@ge_output_4
D=D-1;JEQ
@ge_output_5
D=D-1;JEQ
@ge_output_6
D=D-1;JEQ
@ge_output_7
D=D-1;JEQ
@ge_output_8
D=D-1;JEQ
@ge_output_9
D-1;JEQ

//Exit if no match
@mk_output_branch_return
A=M
0;JMP
