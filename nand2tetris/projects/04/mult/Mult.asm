// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

    @sum
    M=0
    @R0
    D=M
    @STOP
    D;JEQ
    @R1
    D=M
    @STOP
    D;JEQ
    @R0
    D=M
    @R1
    D=D-M
    @BIG
    D;JGE
    @SMALL
    0;JMP
(BIG)
    @R0
    D=M
    @r
    M=D
    @R1
    D=M
    @i
    M=D
    @LOOP
    0;JMP
(SMALL)
    @R1
    D=M
    @r
    M=D
    @R0
    D=M
    @i
    M=D
    @LOOP
    0;JMP
(LOOP)
    @i
    D=M
    @STOP
    D;JLE
    @r
    D=M
    @sum
    M=M+D
    @i
    M=M-1
    @LOOP
    0;JMP
(STOP)
    @sum
    D=M
    @R2
    M=D
(END)
    @END
    0;JMP