// ks_getKey
// Gets key from keyboard input from user
// Stores the valid key into a variable, 0, 1, c, q, ENTER, or BACKSPACE
// Returns valid key back to main 
// ********** Variables **************
// KBD 	      : Predetermined variable name for keyboard input. If KBD = 0, no key has been pressed.
// tempKey 	  : Copy of key pressed, in case key is immediately released.
// currentKey : Storage of valid key, returned to main.
// return	  : Return pointer, set to an area in the program that the function comes back to after finishing.
// ********** Labels *****************
// GETKEY_LOOP 	 : Main loop of the function, handles both invalid (keeps looping) and valid cases. Forks to a VALID_KEY label in the latter case.
// VALID_KEY	 : Handles when valid key is pressed. Copies tempKey to currentKey, then proceeds to return.
// DEBOUNCE_LOOP : Handles the special implementation aspect of getKey. The KBD needs to be debounced. I.e. if the user holds down a key,
// the program only takes a single copy of it, ignoring the rest of the inputs. Similarly, if the entire program runs fast enough
// such that it takes two or more inputs from the keyboard when the user intended to only press a key once, only one input will be recorded.
// ********** PRECONDITIONS **********
//
//
// ********** OUTPUTS ****************
//
//
//
// ********** TODO *******************
// Are all functions documented with a description, inputs/precondictions, and
outputs/effects?
// Are key actions documents (e.g. input, conversion, leading zero suppression)?

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
    D;JEQ           // No key pressed
	
	@tempKey	
	M=D			    // Copy key

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
	