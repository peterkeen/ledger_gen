# typed: strict

module LedgerGen
  class Posting
    extend T::Sig

    sig {void}
    def initialize
      @account = T.let('', String)
      @amount = T.let(0, Numeric)
    end

    sig { params(account: String).returns(String) }
    def account(account)
      @account = account
    end

    sig { params(amount: Numeric).returns(Numeric) }
    def amount(amount)
      @amount = amount
    end

    sig {returns(String)}
    def to_s
      "#{@account}  #{amount_string}"
    end

    sig {returns(String)}
    def amount_string
      if @amount.nil?
        ''
      else
        sprintf('$%0.2f', @amount)
      end
    end
  end
end
