defmodule Account do
	defstruct user: User, balance: 1000

	def register(user), do: %__MODULE__{user: user}

	def transfer(accounts, from, to, value) do
		from = Enum.find(accounts, fn account -> account.user.email == from.user.email end)

		cond do
			check_balance(from.balance, value) -> {:error, "Insufficient balance!"}
			true ->
				to = Enum.find(accounts, fn account -> account.user.email == to.user.email end)
				from = %Account{from | balance: from.balance - value}
				to = %Account{to | balance: to.balance + value}
				[from, to]
		end
	end

	def withdraw(account, value) do
		cond do
			check_balance(account.balance, value) -> {:error, "Insufficient balance!"}

			true ->
				account = %Account{account | balance: account.balance - value}
				{:ok, account, "Email sent!"}
		end
	end

	defp check_balance(balance, value), do: balance < value
end
