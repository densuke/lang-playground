module shared_file
import StdEnv

// file を 2 か所で使う。ユニーク性を破るので型検査で拒否される
Start :: *World -> (*File, *File)
Start world
    # (_, file, world) = fopen "/tmp/abc.txt" FWriteText world
    = (file, fwritec 'a' file)
