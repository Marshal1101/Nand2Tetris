# Assembler

import os, sys, glob

class Parser:
    """입력 파일/스트림을 열고 분석할 준비를 한다."""
    def __init__(self):
        print("=========init==========")
        self.is_ready = False
        self.dir = os.getcwd()
        print(f"[System] cd: {self.dir}")
        if len(sys.argv) < 2:
            print("Error: missing arg, type => \"python3 assembler.py (/path/)(file.asm)\"")
            return
        print(sys.argv)
        self.args = sys.argv[1:]
        print("[System] args:", self.args)
        
        self.argv1_split = self.args[0].split("/")
        print("[System] argv1_split:", self.argv1_split)
        
        self.file = self.argv1_split[-1]
        print("[System] file:", self.file)

        is_finding_one_file = True
        self.path = ""
        if self.file == "":
            is_finding_one_file = False
        elif self.file.find(".asm") == -1:
            is_finding_one_file = False
            self.file == ""
        
        print("[System] path1:", self.path)
        if not is_finding_one_file: self.path = "/".join(self.argv1_split)
        else: self.path = "/".join(self.argv1_split[:-1])
        print("[System] path2:", self.path)
        print("[System] path3:", self.path)
        print("[System] full_path:", self.dir + self.path + "/*.asm")
        # self.file_name, self.file_ext = self.file.split(".")
        dirlist = glob.glob(self.dir + self.path + "/*.asm")
        print(f"[System] dirlist1 {dirlist}")
        

        ## check, is there file in path 
        if len(dirlist) == 0: 
            print("[System Error]: invalid Path")
            return
        
        if is_finding_one_file:
            print(f"[System] Now finding {self.file} in the path")

            exit_flag = True
            for file in dirlist:
                print(f"[System] checking {file}")
                if file.find(self.file) != -1:
                    exit_flag = False
                    break
            if exit_flag:
                print("[System Error]: invalid Filename")
                return

            dirlist = [f"{self.dir}/{self.path}/{self.file}"]
            print(f"[System] Check {self.file}")
            print("[System] file open: READY")
        else:
            print(f"[System] Check {self.path} folder has .asm check.")
            print("[System] file open: READY")

        self.is_ready = True
        
        self.file_name = ""
        self.ext = ""
        for f in dirlist:
            fsplit = f.split("/")
            print(f"[System] file path filename {fsplit}")
            if fsplit[-1].find("\\") != -1:
                self.file_name, self.ext = fsplit[-1].split("\\")[1].split(".")
            else:
                self.file_name, self.ext = fsplit[-1].split(".")
            print(f"[System] file_name: {self.file_name}")
            fi = open(f, 'r')
            self.lines = fi.readlines()
            print(f"[System] ...READING Assembly Code Lines\n {self.lines}")
            self.exe()
            print(f"[System] ...FINISH")
            fi.close()

    def exe(self):
        if not self.is_ready: return
        print(f"[System] ...TRANSLATING")
        # 0PASS
        self.commands = []
        for line in self.lines:
            com = ""
            prev = ""
            for s in line:
                if s == "/" and prev == "/":
                    if com != "/":
                        self.commands.append(com[0:-1])
                    break
                if s == "\n" and com != "":
                    self.commands.append(com)
                prev = s
                if s != " ": com += s

        self.cur = -1
        self.com_cnt = len(self.commands) - 1
        print(f"[System] commands\n {self.commands}")

        # 모듈 불러옴
        symToCode = Code()
        symbolTable = SymbolTable()
        print("[System] Module imported: Code, SymbolTable")

        # 1PASS
        self.rom_addr = 0
        new_commands = []
        while (self.hasMoreCommands()):
            self.advance()
            if self.commandType() == "L_COMMAND":
                symbolTable.addEntry(self.symbol(), self.rom_addr)
            else:
                new_commands.append(self.commands[self.cur])
                self.rom_addr += 1
        print("[System] 1PASS finish")

        # 2PASS
        self.commands = new_commands
        self.cur = -1
        self.com_cnt = len(self.commands) - 1
        bin_code = ""
        while (self.hasMoreCommands()):
            self.advance()
            if self.commandType() == "A_COMMAND":
                com = self.symbol()
                if com.isdigit():
                    bin_code += format(int(com), 'b').zfill(16) + "\n"
                else:
                    if symbolTable.contains(com):
                        bin_code += format(symbolTable.getAddress(com), 'b').zfill(16) + "\n"
                    else:
                        symbolTable.addEntry(com)
                        bin_code += format(symbolTable.getAddress(com), 'b').zfill(16) + "\n"
            else:
                bin_code += "111"
                bin_code += symToCode.comp(self.comp())
                bin_code += symToCode.dest(self.dest())
                bin_code += symToCode.jump(self.jump())
                bin_code += "\n"

        print("[System] 2PASS finish")
        print(f"[System] symbol table(dictionary): {symbolTable.table}")
        print(f"[System] hack codes translated. \n{bin_code}")

        ## write
        print(f"[System] import to:", self.dir + self.path + "/" + self.file_name + ".hack")
        fo = open(self.dir + self.path + "/" + self.file_name + ".hack", 'w')
        fo.write(bin_code)
        fo.close()


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
        curr_com = self.commands[self.cur]
        if curr_com[0] == "@":
            return "A_COMMAND"
        elif curr_com[0] == "(":
            return "L_COMMAND"
        else:
            return "C_COMMAND"

    def symbol(self) -> str:
        if self.commandType() == "A_COMMAND":
            return self.commands[self.cur][1:]
        elif self.commandType() == "L_COMMAND":
            return self.commands[self.cur][1:-1]
    
    def dest(self) -> str:
        if self.commandType() != "C_COMMAND": return
        if "=" in self.commands[self.cur]:
            return self.commands[self.cur].split("=")[0]
        else: return

    def comp(self) -> str:
        if self.commandType() != "C_COMMAND": return
        if "=" in self.commands[self.cur]:
            compjump = self.commands[self.cur].split("=")[1]
            if ";" in compjump:
                return compjump.split(";")[0]
            return compjump
        else:
            if ";" in self.commands[self.cur]:
                return self.commands[self.cur].split(";")[0]

    def jump(self) -> str:
        if self.commandType() != "C_COMMAND": return
        if ";" in self.commands[self.cur]:
            return self.commands[self.cur].split(";")[1]


class Code:
    """dest=comp;jump 필드를 이진 코드로 변환한다."""
    def __init__(self):
        self.comp_field = {
            "0":    0b101010,
            "1":    0b111111,
            "-1":   0b111010,
            "D":    0b001100,
            "X":    0b110000,
            "!D":   0b001101,
            "!X":   0b110001,
            "-D":   0b001111,
            "-X":   0b110011,
            "D+1":  0b011111,
            "X+1":  0b110111,
            "D-1":  0b001110,
            "X-1":  0b110010,
            "D+X":  0b000010,
            "D-X":  0b010011,
            "X-D":  0b000111,
            "D&X":  0b000000,
            "D|X":  0b010101,
        }

    """dest 연상기호를 3비트 2진코드로 반환한다."""
    def dest(self, symbol: str) -> str:
        if symbol == None:  return "000"
        if symbol == "M":   return "001"
        if symbol == "D":   return "010"
        if symbol == "MD":  return "011"
        if symbol == "A":   return "100"
        if symbol == "AM":  return "101"
        if symbol == "AD":  return "110"
        if symbol == "ADM": return "111"
        else:
            print(f"[System Error]: no-dest: {symbol}")

    """comp 연상기호를 7비트 2진코드로 반환한다."""
    def comp(self, symbol: str) -> str:
        com = symbol
        a = "0"
        if "A" in symbol:
            com = symbol.replace("A", "X")
        if "M" in symbol:
            com = symbol.replace("M", "X")
            a = "1"
        return a + format(self.comp_field[com], 'b').zfill(6)

    """jump 연상기호를 3비트 2진코드로 반환한다."""
    def jump(self, symbol: str) -> str:
        if symbol == None:  return "000"
        if symbol == "JGT": return "001"
        if symbol == "JEQ": return "010"
        if symbol == "JGE": return "011"
        if symbol == "JLT": return "100"
        if symbol == "JNE": return "101"
        if symbol == "JLE": return "110"
        if symbol == "JMP": return "111"


class SymbolTable:
    """사전 정의된 테이블과 새 테이블을 생성한다."""
    def __init__(self):
        self.table = {}
        self.cur_addr = 16
        self.pdf_symbol = {
            "SP":   0, 
            "LCL":  1,
            "ARG":  2,
            "THIS": 3,
            "THAT": 4,
            "R0":   0,
            "R1":   1,
            "R2":   2,
            "R3":   3,
            "R4":   4,
            "R5":   5,
            "R6":   6,
            "R7":   7,
            "R8":   8,
            "R9":   9,
            "R10": 10,
            "R11": 11,
            "R12": 12,
            "R13": 13,
            "R14": 14,
            "R15": 15,
            "SCREEN": 16384,
            "KBD": 24576,
        }
        

    """(symbol, address) 쌍을 테이블에 추가한다."""
    def addEntry(self, symbol: str, address: int = -1):
        if address == -1:
            self.table[symbol] = self.cur_addr
            self.cur_addr += 1
        else: self.table[symbol] = address

    """기호 테이블이 주어진 symbol을 포함하는가?"""
    def contains(self, symbol: str) -> bool:
        if symbol in self.pdf_symbol: return True
        if symbol in self.table: return True
        return False

    """symbol과 연결된 주소를 반환한다."""
    def getAddress(self, symbol:str) -> int:
        if symbol in self.pdf_symbol: return self.pdf_symbol[symbol]
        if symbol in self.table: return self.table[symbol]



if __name__=='__main__':
    asm = Parser()