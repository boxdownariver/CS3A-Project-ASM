// Runs an infinite loop that listens to the keyboard input. 
// When a 0,1 c, q, enter, or backspace are input, return input key to program

	// 0, 1, c, q, enter, backspace
	// 0 = 48
	// 1 = 49
	// c = 99
	// q = 113
	// C = 67
	// Q = 81
	// enter = 128
	// backspace = 129

(GETKEY_LOOP)

    @KBD
    D=M
    @GETKEY_LOOP
    D;JEQ         // No key pressed
	
	@tempKey	
	M=D			  // Copy key

	@tempKey
	D=M
	@48
	D=D-A
    @VALID_KEY
	D;JEQ			// If keyboard input = '0', jump to VALID_KEY
	
    @tempKey
    D=M
    @49
    D=D-A
    @VALID_KEY
	D;JEQ			// If keyboard input = '1', jump to VALID_KEY
	
	@tempKey
	D=M
	@99
	D=D-A
    @VALID_KEY
	D;JEQ			// If keyboard input = 'c', jump to VALID_KEY
	
	@tempKey
	D=M
	@113
	D=D-A
    @VALID_KEY
	D;JEQ			// If keyboard input = 'q', jump to VALID_KEY
	
	@tempKey
	D=M
	@128
	D=D-A
    @VALID_KEY
	D;JEQ			// If keyboard input = 'ENTER', jump to VALID_KEY
	
	@tempKey
	D=M
	@129
	D=D-A
    @VALID_KEY
	D;JEQ			// If keyboard input = 'BACKSPACE', jump to VALID_KEY
	
	@GETKEY_LOOP
	0;JMP
	
(VALID_KEY)

	@tempKey
	D=M
	@currentKey		// Store valid key
	M=D
	
(DEBOUNCE_LOOP)

	@KBD
	D=M
	@DEBOUNCE_LOOP
	D;JNE			// Stay while key is still being pressed (KBD input != 0)

// Return
	
	@return
	A=M
	0;JMP			// Return