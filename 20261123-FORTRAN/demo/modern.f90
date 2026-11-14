! 現代の Fortran (自由形式、Fortran 2018 の範囲): 配列演算、where、do concurrent、module
module stats
    implicit none
contains
    pure function mean(x) result(m)
        real, intent(in) :: x(:)
        real :: m
        m = sum(x) / size(x)
    end function mean
end module stats

program modern
    use stats
    implicit none
    real :: a(5) = [1.0, 2.0, 3.0, 4.0, 5.0]
    real :: b(5), m(2, 2)
    integer :: i

    ! 配列を丸ごと演算する (ループを書かない)
    b = a**2 + 1.0
    print '(a, 5f6.1)', "a**2 + 1 = ", b
    print '(a, f6.2)', "平均       = ", mean(b)

    ! where: 条件つきの配列代入
    where (b > 10.0)
        b = 10.0
    end where
    print '(a, 5f6.1)', "上限 10    = ", b

    ! do concurrent: 反復の順序に依存しないと宣言する
    do concurrent (i = 1:5)
        a(i) = a(i) * 10.0
    end do
    print '(a, 5f6.1)', "10 倍      = ", a

    ! 行列積は組み込み関数
    m = reshape([1.0, 3.0, 2.0, 4.0], [2, 2])
    print '(a, 4f6.1)', "m * m      = ", matmul(m, m)
end program modern
