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

// SCREEN = KBD > 0 ? -1 : 0
// @SCREEN = 16384 ~ 24575
// @KBD = 24576
// i = 8192 (8K)

(LOOP)
    @8193
    D=A
    @i
    M=D
    @KBD
    D=M
    @OFF
    D;JEQ
    @ON
    D;JGT
(ON)
    @i
    M=M-1
    D=M
    @SCREEN
    A=D+A
    M=-1
    @ON
    D;JGT
    @LOOP
    0;JMP
(OFF)
    @i
    M=M-1
    D=M
    @SCREEN
    A=D+A
    M=0
    @OFF
    D;JGT
    @LOOP
    0;JMP
(END)
    @END
    0;JMP
