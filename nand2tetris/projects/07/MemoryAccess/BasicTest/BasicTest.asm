//[filename] C:\Marshal1101\nand2tetris\nand2tetris\projects\07/MemoryAccess/BasicTest\BasicTest.asm
// C_PUSH constant 10
			@10
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
// C_PUSH constant 21
			@21
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 22
			@22
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP argument 2
			@2
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
// C_POP argument 1
			@1
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
// C_PUSH constant 36
			@36
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP this 6
			@6
            D=A
            @THIS
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
// C_PUSH constant 42
			@42
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 45
			@45
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP that 5
			@5
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
// C_PUSH constant 510
			@510
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP temp 6
			@SP
            AM=M-1
            D=M
            @11
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
// C_PUSH that 5
			@5
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
// sub
            @SP
            AM=M-1
            D=M
            A=A-1
            MD=M-D
// C_PUSH this 6
			@6
            D=A
            @THIS
            A=D+M
            D=M
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH this 6
			@6
            D=A
            @THIS
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
// sub
            @SP
            AM=M-1
            D=M
            A=A-1
            MD=M-D
// C_PUSH temp 6
			@11
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
// infinite loop for End
            @END
            (END)
            0;JMP