puts "Hello, world!"

proc fib {n} {
    if {$n < 2} { return $n }
    return [expr {[fib [expr {$n-1}]] + [fib [expr {$n-2}]]}]
}
set out {}
for {set i 0} {$i < 10} {incr i} { lappend out [fib $i] }
puts $out
