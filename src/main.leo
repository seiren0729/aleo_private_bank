// The 'bank_seiren' program.
program bank_seiren.aleo {
    record Token {
        owner: address,
        amount: u64
    }

    mapping balances:field=>u64;

    transition issue(owner: address, amount: u64)-> Token {
        return Token {
            owner: owner,
            amount: amount
        };
    }

    transition deposit(token: Token, amount: u64)-> Token {
        let difference: u64 = token.amount - amount;

        let remaining: Token = Token {
            owner: token.owner,
            amount: difference
        };

        let hash: field = BHP256::hash_to_field(token.owner);

        return remaining then finalize(hash, amount);
    }

    finalize deposit(hash: field, amount: u64) {
        let current_amount: u64 = Mapping::get_or_use(balances, hash, 0u64);
        Mapping::set(balances, hash, current_amount + amount);
    }

    transition withdraw(recipient: address, amount: u64, rate: u64, periods: u64) -> Token {
        let hash: field = BHP256::hash_to_field(recipient);

        let total: u64 = calculate_interest(amount, rate, periods);

        let token: Token = Token {
            owner: recipient,
            amount: total
        };

        return token then finalize(hash, amount);
    }

    finalize withdraw(hash: field, amount: u64) {
        let current_amount: u64 = Mapping::get_or_use(balances, hash, 0u64);
        Mapping::set(balances, hash, current_amount - amount);
    }

    function calculate_interest(principal: u64, rate: u64, periods: u64) -> u64 {
        let amount: u64 = principal;

        for i:u64 in 0u64..100u64 {
            if i < periods {
                amount += (amount * rate) / 10000u64;
            }
        }

        return amount;
    }
}
