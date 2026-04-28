// Wrapper to dynamically select the proper output based on number input.
// Input should be according to ASCII codes.
// Written by Micah Krosby

(mk_output_branch)
//Exit directly from ge_output_x if possible
@ge_output_branch_return
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
0;JMP
