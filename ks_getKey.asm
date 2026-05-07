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
// No inputs, all keyboard inputs are handled within the function. However, the program relies on an outside loop if all 16 bits are being grabbed.
// ********** OUTPUTS ****************
// Outputs one variable, currentKey, which is used by the rest of the greater program. Depending on the key input, it could be stored in the buffer,
// cause for removal from the buffer, clearing the buffer, etc.

// ASCII values
	// 0, 1, c, q, enter, backspace
	// 0 = 48
	// 1 = 49
	// c = 99
	// q = 113
	// C = 67, not used
	// Q = 81, not used
	// enter = 128
	// backspace = 129

(GETKEY_LOOP)

// Query keyboard
    @KBD
    D=M
    @GETKEY_LOOP
    D;JEQ           // If no key pressed, loop back to beginning
	
	@tempKey	
	M=D			    // Copy key

	@tempKey
	D=M
	@48				// ASCII '0'
	D=D-A
    @VALID_KEY
	D;JEQ			// If keyboard input = '0', jump to VALID_KEY
	
    @tempKey
    D=M
    @49				// ASCII '1'
    D=D-A
    @VALID_KEY
	D;JEQ			// If keyboard input = '1', jump to VALID_KEY
	
	@tempKey
	D=M
	@99				// ASCII 'c'
	D=D-A
    @VALID_KEY
	D;JEQ			// If keyboard input = 'c', jump to VALID_KEY
	
	@tempKey
	D=M
	@113			// ASCII 'q'
	D=D-A
    @VALID_KEY
	D;JEQ			// If keyboard input = 'q', jump to VALID_KEY
	
	@tempKey
	D=M
	@128			// ASCII 'ENTER'
	D=D-A
    @VALID_KEY
	D;JEQ			// If keyboard input = 'ENTER', jump to VALID_KEY
	
	@tempKey
	D=M
	@129			// ASCII 'BACKSPACE'
	D=D-A
    @VALID_KEY
	D;JEQ			// If keyboard input = 'BACKSPACE', jump to VALID_KEY
	
	@GETKEY_LOOP
	0;JMP			// Else, loop back to beginning
	
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
	0;JMP			// Return pointer back to main
	