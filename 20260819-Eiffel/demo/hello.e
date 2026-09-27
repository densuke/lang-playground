class
	HELLO

create
	make

feature

	make
			-- Say hello, then sum 1..10 with a loop that carries its own contract.
		local
			i, sum: INTEGER
		do
			print ("Hello, World!%N")
			from
				i := 1
			invariant
				partial_sum: sum = (i - 1) * i // 2
			until
				i > 10
			loop
				sum := sum + i
				i := i + 1
			variant
				11 - i
			end
			print ("sum 1..10 = " + sum.out + "%N")
		end

end
