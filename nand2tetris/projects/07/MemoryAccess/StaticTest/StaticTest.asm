//[filename] C:\Marshal1101\nand2tetris\nand2tetris\projects\07/MemoryAccess/StaticTest\StaticTest.asm
// C_PUSH constant 111
			@111
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 333
			@333
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 888
			@888
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_POP static 8
			@SP
            AM=M-1
            D=M
            @24
            M=D
// C_POP static 3
			@SP
            AM=M-1
            D=M
            @19
            M=D
// C_POP static 1
			@SP
            AM=M-1
            D=M
            @17
            M=D
// C_PUSH static 3
			@19
			D=M
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH static 1
			@17
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
// C_PUSH static 8
			@24
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