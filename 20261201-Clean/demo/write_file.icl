module write_file
import StdEnv
// *File: ほかと共有されないファイル。書いた結果が次の入力になる
WriteABC :: *File -> *File
WriteABC file = fwritec 'c' (fwritec 'b' (fwritec 'a' file))

Start :: *World -> String
Start world
    # (_, file, world) = fopen "/tmp/abc.txt" FWriteText world
    # (_, world) = fclose (WriteABC file) world
    # (_, file, world) = fopen "/tmp/abc.txt" FReadText world
    # (line, _) = freadline file
    = line
