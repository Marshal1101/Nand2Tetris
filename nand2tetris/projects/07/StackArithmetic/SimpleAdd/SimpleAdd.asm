//[filename] C:\Marshal1101\nand2tetris\nand2tetris\projects\07/StackArithmetic/SimpleAdd\SimpleAdd.asm
// C_PUSH constant 7
			@7
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 8
			@8
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
// infinite loop for End
            (END)
            @END
            0;JMP