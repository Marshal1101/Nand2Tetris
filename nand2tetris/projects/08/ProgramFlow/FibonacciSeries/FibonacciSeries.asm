//[filename] C:\Marshal1101\nand2tetris\nand2tetris\projects\08/ProgramFlow/FibonacciSeries\FibonacciSeries.asm
// C_PUSH argument 1
			@1
            D=A
            @ARG
            A=D+M
            D=M
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP pointer 1
			@SP
            AM=M-1
            D=M@THAT
            M=D
// C_PUSH constant 0
			@0
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP that 0
			@0
            D=A
            @THAT
            D=D+M
            @SP
            A=M
            M=D
            @SP
            AM=M-1
            D=M
            A=A+1
            A=M
            M=D
// C_PUSH constant 1
			@1
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP that 1
			@1
            D=A
            @THAT
            D=D+M
            @SP
            A=M
            M=D
            @SP
            AM=M-1
            D=M
            A=A+1
            A=M
            M=D
// C_PUSH argument 0
			@0
            D=A
            @ARG
            A=D+M
            D=M
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 2
			@2
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// sub
            @SP
            AM=M-1
            D=M
            A=A-1
            MD=M-D
// C_POP argument 0
			@0
            D=A
            @ARG
            D=D+M
            @SP
            A=M
            M=D
            @SP
            AM=M-1
            D=M
            A=A+1
            A=M
            M=D
// Label MAIN_LOOP_START 
		(MAIN_LOOP_START)
// C_PUSH argument 0
			@0
            D=A
            @ARG
            A=D+M
            D=M
            @SP
            AM=M+1
            A=A-1
            M=D
// If-goto: COMPUTE_ELEMENT
// C_POP constant 
			@SP
            AM=M-1
            D=M
            @COMPUTE_ELEMENT
            D;JNE
            M=D
// Goto: END_PROGRAM 
			@END_PROGRAM
			0;JMP
			
// Label COMPUTE_ELEMENT 
		(COMPUTE_ELEMENT)
// C_PUSH that 0
			@0
            D=A
            @THAT
            A=D+M
            D=M
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH that 1
			@1
            D=A
            @THAT
            A=D+M
            D=M
            @SP
            AM=M+1
            A=A-1
            M=D
// add
            @SP
            AM=M-1
            D=M
            A=A-1
            MD=D+M
// C_POP that 2
			@2
            D=A
            @THAT
            D=D+M
            @SP
            A=M
            M=D
            @SP
            AM=M-1
            D=M
            A=A+1
            A=M
            M=D
// C_PUSH pointer 1
			@THAT
			D=M
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 1
			@1
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// add
            @SP
            AM=M-1
            D=M
            A=A-1
            MD=D+M
// C_POP pointer 1
			@SP
            AM=M-1
            D=M@THAT
            M=D
// C_PUSH argument 0
			@0
            D=A
            @ARG
            A=D+M
            D=M
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 1
			@1
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// sub
            @SP
            AM=M-1
            D=M
            A=A-1
            MD=M-D
// C_POP argument 0
			@0
            D=A
            @ARG
            D=D+M
            @SP
            A=M
            M=D
            @SP
            AM=M-1
            D=M
            A=A+1
            A=M
            M=D
// Goto: MAIN_LOOP_START 
			@MAIN_LOOP_START
			0;JMP
			
// Label END_PROGRAM 
		(END_PROGRAM)
// infinite loop for End
            (END)
            @END
            0;JMP