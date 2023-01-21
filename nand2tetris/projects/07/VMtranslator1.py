# VWtranslator

import re, os, sys, glob

class Parser:
    """입력 파일/스트림을 열고 분석할 준비를 한다."""
    def __init__(self, file_path):
        self.file_path = file_path
        if self.file_path == None:
            print(f"[ERROR: Parser] file_path is not exist.")
            return

        fi = open(file_path, 'r')
        self.lines = fi.readlines()
        print(f"[Parser] ...READING VM Code Lines\n {self.lines}")
        self.exe()
        print(f"[Parser] ...FINISH")
        fi.close()


    def exe(self):
        print(f"[Parser] ...PARSING")

        # 0PASS
        self.commands = []
        for i in range(len(self.lines)):
            line = self.lines[i]
            com = ""
            prev = ""
            com_line = [] 
            for s in line:
                if s == "/" and prev == "/":
                    if com != "/":
                        com_line.append(com[0:-1])
                    break
                if s == "\n" and com != "":
                    com_line.append(com)
                    com = ""
                prev = s
                if s != " ": com += s
                elif com != "":
                    com_line.append(com)
                    com = ""
            if len(com_line):
                self.commands.append(com_line)

        self.cur = -1
        self.com_cnt = len(self.commands) - 1
        print(f"[Parser] VM commands\n {self.commands}")


    ## method
    def hasMoreCommands(self) -> bool:
        if self.cur < self.com_cnt:
            return True
        else: return False

    def advance(self) -> int:
        if self.hasMoreCommands():
            self.cur += 1
        return self.cur

    def commandType(self) -> str:
        arithmetic = {"add", "sub", "neg", "eq", "gt", "lt", "and", "or", "not"}

        curr_com = self.commands[self.cur]
        if curr_com[0] in arithmetic:
            return "C_ARITHMETIC"
        elif curr_com[0] == "push":
            return "C_PUSH"
        elif curr_com[0] == "pop":
            return "C_POP"
        elif curr_com[0] == "label":
            return "C_LABEL"
        elif curr_com[0] == "goto":
            return "C_GOTO"
        elif curr_com[0] == "if-goto":
            return "C_IF"
        elif curr_com[0] == "function":
            return "C_FUNCTION"
        elif curr_com[0] == "return":
            return "C_RETURN"
        elif curr_com[0] == "call":
            return "C_CALL"
        else:
            print(f"[System Error] line{self.cur+1}: invalid command error")
            return

    # 현재 명령의 첫 인수를 반환한다. C_ARITHMETIC 경우 명령 그 자체가 반환된다. C_RETURN 경우에 금지
    def arg1(self) -> str:
        curr_com = self.commands[self.cur]
        curr_com_type = self.commandType()
        if curr_com_type == "C_RETURN":
            print(f"[System Error] line{self.cur}: if current command is C_RETURN, impossible to call arg1()")
            return
        if curr_com_type == "C_ARITHMETIC":
            return curr_com[0]
        else:
            return curr_com[1]

    def arg2(self) -> int:
        curr_com = self.commands[self.cur]
        curr_com_type = self.commandType()
        if (
            curr_com_type == "C_PUSH" or
            curr_com_type == "C_POP" or
            curr_com_type == "C_FUNCTION" or
            curr_com_type == "C_CALL"
        ): return int(curr_com[2])


class CodeWriter:
    ## write open ready
    def __init__(self, parser=None) -> None:
        self.Parser = parser
        self.file_path = None
        self.fo = None
        self.export_file = None

    ## open a parsering vm file
    def setFileName(self, parser: Parser) -> None:
        # 코드 작성기에게 새로운 VM파일 번역이 시작되었음을 알린다.
        self.parser = parser
        self.file_path = parser.file_path

        if self.file_path == None:
            print(f"[ERROR: CodeWriter] parser.file_path is not exist.")
            return

        self.export_file = self.file_path[:-3] + ".asm"
        self.fo = open(self.export_file, 'w')
        self.fo.write(f"//[filename] {self.export_file}")
        print(f"[CodeWriter] import to: {self.export_file}")
        
        vm = self.parser
        while vm.hasMoreCommands():
            vm.advance()
            curr_com = vm.commandType()
            if curr_com == "C_ARITHMETIC":
                self.writerArithmetic(vm.arg1())
            elif curr_com == "C_PUSH":
                self.writePushPop("C_PUSH", vm.arg1(), vm.arg2())
            elif curr_com == "C_POP":
                self.writePushPop("C_POP", vm.arg1(), vm.arg2())

        self.close()

    def writerArithmetic(self, command: str) -> None:
        # 주어진 산술 명령을 번역한 어셈블리 코드를 기록한다.
        # arithmetic = {"add", "sub", "neg", "eq", "gt", "lt", "and", "or", "not"}
        # pop = "@SP\nM=M-1\nA=M\nD=M\n"
        # push = "@SP\nA=M\nM=D\n@SP\nM=M+1\n"
        # print(f"[writerArith:cur_com] {command}")
        asm_code = f"\n// {command}"
        if command == "add":
            ## add = pop D+=M[SP-1] and pop D+=M[SP-1]
            asm_code += f"""
            @SP
            AM=M-1
            D=M
            A=A-1
            MD=D+M"""
        elif command == "sub":
            asm_code += f"""
            @SP
            AM=M-1
            D=M
            A=A-1
            MD=M-D"""
        elif command == "neg":
            asm_code += f"""
            @SP
            A=M-1
            MD=-M"""
        elif command == "eq":
            asm_code += f"""
            @SP
            AM=M-1
            D=M
            A=A-1
            D=M-D
            M=0
            @L{self.parser.cur+1}END_EQ
            D;JNE
            @SP
            A=M-1
            M=-1
            (L{self.parser.cur+1}END_EQ)"""
        elif command == "gt":
            asm_code += f"""
            @SP
            AM=M-1
            D=M
            A=A-1
            D=M-D
            M=0
            @L{self.parser.cur+1}END_GT
            D;JLE
            @SP
            A=M-1
            M=-1
            (L{self.parser.cur+1}END_GT)"""
        elif command == "lt":
            asm_code += f"""
            @SP
            AM=M-1
            D=M
            A=A-1
            D=M-D
            M=0
            @L{self.parser.cur+1}END_LT
            D;JGE
            @SP
            A=M-1
            M=-1
            (L{self.parser.cur+1}END_LT)"""
        elif command == "and":
            asm_code += f"""
            @SP
            AM=M-1
            D=M
            A=A-1
            MD=D&M"""
        elif command == "or":
            asm_code += f"""
            @SP
            AM=M-1
            D=M
            A=A-1
            MD=D|M"""
        elif command == "not":
            asm_code += f"""
            @SP
            A=M-1
            D=M
            MD=!D"""
        self.fo.write(asm_code)


    def writePushPop(self, command: str, segment: str, index: int) -> None:
        # {"local", "argument", "this", "that",
        #  "static", "temp", "constant", "pointer"}
        if index and index > 32767:
            print(f"[Error CodeWrieter push] index outbound of 0~32767")
            return
        asm_code = f"\n// {command} {segment} {index}\n\t\t\t"
        pt = ""
        if segment == "local": pt = "LCL"
        elif segment == "argument": pt = "ARG"
        elif segment == "this": pt = "THIS"
        elif segment == "that": pt = "THAT"
        elif segment == "temp":
            pt = f"R{5+index}"
        elif segment == "pointer":
            if index == 0: pt = "THIS"
            elif index == 1: pt = "THAT"
        elif segment == "static":
            pt = f"{16+index}"
        elif segment == "constant":
            pt = f"{index}"

        if (
            segment == "local" or
            segment == "argument" or
            segment == "this" or
            segment == "that"):
            if command == "C_PUSH":
                asm_code += f"""@{index}
            D=A
            @{pt}
            A=D+M
            D=M
            @SP
            AM=M+1
            A=A-1
            M=D"""
            elif command == "C_POP":
                asm_code += f"""@{index}
            D=A
            @{pt}
            D=D+M
            @SP
            A=M
            M=D
            @SP
            AM=M-1
            D=M
            A=A+1
            A=M
            M=D"""
        else: # segment == "temp", "static", "pointer", "constant"
            if command == "C_PUSH":
                if segment == "constant":
                    asm_code += f"@{pt}\n\t\t\tD=A"
                else:
                    asm_code += f"@{pt}\n\t\t\tD=M"
                asm_code += f"""
            @SP
            AM=M+1
            A=A-1
            M=D"""
            elif command == "C_POP":
                asm_code += f"""@SP
            AM=M-1
            D=M
            @{pt}
            M=D"""

        self.fo.write(asm_code)

    def close(self) -> None:
        inf_loop_code = f"""\n// infinite loop for End
            (END)
            @END
            0;JMP"""
        self.fo.write(inf_loop_code)
        self.fo.close()


class Path:
    def __init__(self) -> None:
        self.cwd = os.getcwd()
        print(f"[PATH] current working path: {self.cwd}")
        self.argv = sys.argv
        self.args = []
        p = re.compile(r'\\|/')
        self.arg1_split = p.split(self.argv[1])
        # print(f"[PATH] arg1_split: {self.arg1_split}")
    
    def getFilePath(self) -> list:
        self.is_one_file = False
        self.file_path_queue = []
        if self.arg1_split[-1].find(".vm") != -1:
            self.is_one_file = True
            file_path = self.cwd + "/" + "/".join(self.arg1_split)
            if os.path.isfile(file_path):
                self.file_path_queue.append(file_path)
            else:
                print(f"[PATH ERROR: invalid file path")

        else:
            dir_path = self.cwd + "/" + "/".join(self.arg1_split)
            if os.path.isdir(dir_path):
                self.file_path_queue = glob.glob(dir_path + "/*.vm")
            else:
                print(f"[PATH ERROR: invalid directory path")

        print(f"[PATH] files: {self.file_path_queue}")
        return self.file_path_queue

if __name__ == "__main__":
    read_file_path = Path().getFilePath()
    code_writer = CodeWriter()
    for file_path in read_file_path:
        parser = Parser(file_path)
        code_writer.setFileName(parser)