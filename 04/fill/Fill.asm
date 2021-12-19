// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Keyboard input and screen output:
// Keyboard represented by memory map (bits in RAM)
// Screen represented by bits in RAM

// ----------------------FILL SCREEN-------------------- //
// pseudocode
// START
// if RAM[KBD] != 0, goto FILL
//      FILL: screenaddr set to -1
// if RAM[KBD] == 0, goto CLEAR
//      CLEAR: screenaddr set to 0
// END

// ----------------initialize variables------------------- //
// SCREEN = RAM[16384]
@SCREEN
D=A
@screenaddr
M=D //stores screen's base address

// n = 8191
@8191
D=A
@n
M=D

//@KBD
//D=A
//@kbdaddr
//M=D //stores keyboard's base address

// ----------------listen to keyboard------------------- //
// RAM[24576] address KBD, if register = 0, no key is pressed
(LOOP)
    // i = 0
    @i
    M=0

    //compares RAM[KBD] to zero
    @KBD
    D=M //sets D register to RAM[KBD]
    
    @CLEAR
    D;JEQ // if RAM[KBD] - 0 = 0 goto CLEAR

    @FILL
    D;JNE // if RAM[KBD] - 0 != 0 goto FILL

// ----------------fill / clear screen------------------ //
// RAM[16384] address SCREEN, if M=-1 RAM[addr]=1111111111111111 (fill)
// 16 bit words of RAM[0] to RAM[8191] = 256 rows * 512 columns
// use a loop to fill every address (?)
// array is implemented as a block of memory registers arr base
    
(FILL)
    // if (i==n) goto LOOP
    @i
    D=M
    @n
    D=D-M
    @LOOP
    D;JEQ
    
    // RAM[arr+i] = -1
    @screenaddr
    D=M // load D register w/ RAM[16384]
    @i 
    A=D+M // load A register w/ RAM[16384] + RAM[i]
    M=-1 //RAM[screenaddr]=1111111111111111
    
    // i++
    @i
    M=M+1
    
    @FILL
    0;JMP

(CLEAR)
    // if (i==n) goto LOOP
    @i
    D=M
    @n
    D=D-M
    @LOOP
    D;JEQ
    
    // RAM[arr+i] = 0
    @screenaddr
    D=M
    @i
    A=D+M
    M=0
    
    // i++
    @i
    M=M+1
    
    @CLEAR
    0;JMP
 