class
	BANK

inherit
	EXCEPTIONS

create
	make

feature

	make
			-- Keep the contract, then break it as the caller, as the callee,
			-- and break the class invariant.
		local
			acc: ACCOUNT
			step: INTEGER
		do
			create acc
			if step = 0 then
				acc.deposit (100)
				print ("deposit (100)        -> balance = " + acc.balance.out + "%N")
				print ("deposit (-5)         -> ")
				acc.deposit (-5)
			elseif step = 1 then
				print ("buggy_deposit (50)   -> ")
				acc.buggy_deposit (50)
			elseif step = 2 then
				acc.deposit (30)
				print ("withdraw (80)        -> ")
				acc.withdraw (80)
			end
		rescue
			print (meaning (exception))
			print (" [")
			print (tag_name)
			print ("]%N")
			step := step + 1
			retry
		end

end
