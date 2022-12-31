//[filename] C:\Marshal1101\nand2tetris\nand2tetris\projects\07/StackArithmetic/StackTest\StackTest.asm
// C_PUSH constant 17
			@17
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 17
			@17
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// eq
            @SP
            AM=M-1
            D=M
            A=A-1
            D=M-D
            M=0
            @L3END_EQ
            D;JNE
            @SP
            A=M-1
            M=-1
            (L3END_EQ)
// C_PUSH constant 17
			@17
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 16
			@16
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// eq
            @SP
            AM=M-1
            D=M
            A=A-1
            D=M-D
            M=0
            @L6END_EQ
            D;JNE
            @SP
            A=M-1
            M=-1
            (L6END_EQ)
// C_PUSH constant 16
			@16
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 17
			@17
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// eq
            @SP
            AM=M-1
            D=M
            A=A-1
            D=M-D
            M=0
            @L9END_EQ
            D;JNE
            @SP
            A=M-1
            M=-1
            (L9END_EQ)
// C_PUSH constant 892
			@892
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 891
			@891
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// lt
            @SP
            AM=M-1
            D=M
            A=A-1
            D=M-D
            M=0
            @L12END_LT
            D;JGE
            @SP
            A=M-1
            M=-1
            (L12END_LT)
// C_PUSH constant 891
			@891
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 892
			@892
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// lt
            @SP
            AM=M-1
            D=M
            A=A-1
            D=M-D
            M=0
            @L15END_LT
            D;JGE
            @SP
            A=M-1
            M=-1
            (L15END_LT)
// C_PUSH constant 891
			@891
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 891
			@891
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// lt
            @SP
            AM=M-1
            D=M
            A=A-1
            D=M-D
            M=0
            @L18END_LT
            D;JGE
            @SP
            A=M-1
            M=-1
            (L18END_LT)
// C_PUSH constant 32767
			@32767
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 32766
			@32766
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// gt
            @SP
            AM=M-1
            D=M
            A=A-1
            D=M-D
            M=0
            @L21END_GT
            D;JLE
            @SP
            A=M-1
            M=-1
            (L21END_GT)
// C_PUSH constant 32766
			@32766
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 32767
			@32767
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// gt
            @SP
            AM=M-1
            D=M
            A=A-1
            D=M-D
            M=0
            @L24END_GT
            D;JLE
            @SP
            A=M-1
            M=-1
            (L24END_GT)
// C_PUSH constant 32766
			@32766
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 32766
			@32766
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// gt
            @SP
            AM=M-1
            D=M
            A=A-1
            D=M-D
            M=0
            @L27END_GT
            D;JLE
            @SP
            A=M-1
            M=-1
            (L27END_GT)
// C_PUSH constant 57
			@57
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 31
			@31
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// C_PUSH constant 53
			@53
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
// C_PUSH constant 112
			@112
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
// neg
            @SP
            A=M-1
            MD=-M
// and
            @SP
            AM=M-1
            D=M
            A=A-1
            MD=D&M
// C_PUSH constant 82
			@82
			D=A
            @SP
            AM=M+1
            A=A-1
            M=D
// or
            @SP
            AM=M-1
            D=M
            A=A-1
            MD=D|M
// not
            @SP
            A=M-1
            D=M
            MD=!D
// infinite loop for End
            (END)
            @END
            0;JMP