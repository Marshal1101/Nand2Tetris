//[filename] C:\Marshal1101\nand2tetris\nand2tetris\projects\08/ProgramFlow/BasicLoop\BasicLoop.asm
// C_PUSH constant 0
			@0
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP local 0
			@0
            D=A
            @LCL
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
// Label LOOP_START 
		(LOOP_START)
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
// C_PUSH local 0
			@0
            D=A
            @LCL
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
// C_POP local 0
			@0
            D=A
            @LCL
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
// If-goto: LOOP_START		
// C_POP constant 
			@SP
            AM=M-1
            D=M
            @LOOP_START
            D;JNE
            M=D
// C_PUSH local 0
			@0
            D=A
            @LCL
            A=D+M
            D=M
            @SP
            AM=M+1
            A=A-1
            M=D
// infinite loop for End
            (END)
            @END
            0;JMP