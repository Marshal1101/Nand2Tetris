//[filename] C:\Marshal1101\nand2tetris\nand2tetris\projects\07/MemoryAccess/PointerTest\PointerTest.asm
// C_PUSH constant 3030
			@3030
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP pointer 0
			@SP
            AM=M-1
            D=M
            @THIS
            M=D
// C_PUSH constant 3040
			@3040
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP pointer 1
			@SP
            AM=M-1
            D=M
            @THAT
            M=D
// C_PUSH constant 32
			@32
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP this 2
			@2
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
// C_PUSH constant 46
			@46
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP that 6
			@6
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
// C_PUSH pointer 0
			@THIS
			D=M
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH pointer 1
			@THAT
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
// C_PUSH this 2
			@2
            D=A
            @THIS
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
// C_PUSH that 6
			@6
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
// infinite loop for End
            (END)
            @END
            0;JMP