# typed: true
module LedgerGen
  class Posting
    extend T::Sig

    sig { params(account: String).returns(String) }
    def account(account)
      @account = account
    end

    sig { params(amount: Numeric).returns(Numeric) }
    def amount(amount)
      @amount = amount
    end

    def to_s
      "#{@account}  #{amount_string}"
    end

    def amount_string
      if @amount.nil?
        ''
      else
        sprintf('$%0.2f', @amount)
      end
    end
  end
end
