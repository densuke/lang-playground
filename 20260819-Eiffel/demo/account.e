class
	ACCOUNT

feature -- Access

	balance: INTEGER

feature -- Element change

	deposit (sum: INTEGER)
			-- Add `sum' to the balance.
		require
			non_negative: sum >= 0
		do
			balance := balance + sum
		ensure
			balance_increased: balance = old balance + sum
		end

	buggy_deposit (sum: INTEGER)
			-- Same contract as `deposit', but the body forgets to add.
		require
			non_negative: sum >= 0
		do
		ensure
			balance_increased: balance = old balance + sum
		end

	withdraw (sum: INTEGER)
			-- Take `sum' out. Forgets to check that there is enough money.
		require
			non_negative: sum >= 0
		do
			balance := balance - sum
		ensure
			balance_decreased: balance = old balance - sum
		end

invariant
	balance_non_negative: balance >= 0

end
