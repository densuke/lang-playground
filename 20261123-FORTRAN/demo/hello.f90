! 自由形式の Hello World (拡張子 .f90 = 自由形式)
program hello
    implicit none
    character(len=*), parameter :: name = "Fortran"
    print '(a, a)', "Hello, world! from ", name
end program hello
