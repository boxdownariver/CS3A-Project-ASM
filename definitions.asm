define(`ge_execute_X',
`@$1               // Set return location
D=A
@ge_output_return
M=D
@$2                // Get current column (static)
D=A
@ge_currentColumn
M=D
@ge_output_$3      // Run output for $3
0;JMP
($1)               // Return location ^^^'
)dnl
define(`ge_execute_X_varcol',
`@$1               // Set return location
D=A
@ge_output_return
M=D
@$2                // Get current column (variable)
D=M
@ge_currentColumn
M=D
@ge_output_$3      // Run output for $3
0;JMP
($1)               // Return location ^^^'
)dnl
define(`mk_execute_output_X_dyn',
`@$1               // Set return location
D=A
@mk_output_branch_return
M=D
@$2                // Get current column
D=M
@ge_currentColumn
M=D
@$3                // Prep value from variable $3 for switch statement in mk_output_branch
D=M
@ge_dynamic_x
M=D
@mk_output_branch  // Run branching algorithm
0;JMP
($1)               // Return location ^^^'
)dnl
define(`mk_execute_getKey',
`@$1               // Set return location
D=A
@mk_getKey_return
M=D
@mk_getKey         // Run getKey
0;JMP
($1)               // Return location ^^^'
)dnl
define(`mk_execute_addBuf',
`@$1               // Set return location
D=A
@mk_addBuf_return
M=D
@mk_addBuf         // Run addBuf
0;JMP
($1)               // Return location ^^^'
)dnl
define(`mk_execute_deleteBuf',
`@$1               // Set return location
D=A
@mk_deleteBuf_return
M=D
@mk_deleteBuf      // Run deleteBuf
0;JMP
($1)               // Return location ^^^'
)dnl
define(`mk_execute_clearBuf',
`@$1               // Set return location
D=A
@mk_clearBuf_return
M=D
@mk_clearBuf       // Run clearBuf
0;JMP
($1)               // Return location ^^^'
)dnl
define(`mk_execute_twocomp',
`@$1               // Set return location
D=A
@mk_twocomp_return
M=D
@R15               // If R15, run mk_twocomp
D=M
@mk_twocomp
D;JNE
($1)               // Return location ^^^'
)dnl
define(`mk_execute_bin_dec',
`@$1               // Set return location
D=A
@mk_bin_dec_return
M=D
@buffer_size       // Skip runtime if buffer isn't full
D=M
@16                // Buffer is full at size 16
D=D-A
@$1
D;JNE              // ^^
@mk_bin_dec
0;JMP
($1)               // Return location ^^^'
)dnl
define(`mk_execute_bin_bin',
`@$1               // Set return location
D=A
@mk_bin_bin_return
M=D
@mk_bin_bin        // Run bin_bin
0;JMP
($1)               // Return location ^^^'
)dnl
