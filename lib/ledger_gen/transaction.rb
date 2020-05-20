# typed: strict
module LedgerGen
  class Transaction
    extend T::Sig

    sig {params(date_format: String).void}
    def initialize(date_format='%Y/%m/%d')
      @date_format = T.let(date_format, String)
      @postings = T.let([], T::Array[Posting])
      @comments = T.let([], T::Array[String])

      @date = T.let(nil, T.nilable(T.any(Date, DateTime)))
      @payee = T.let(nil, T.nilable(String))
      @cleared = T.let(false, T::Boolean)
    end

    sig {params(date: T.any(Date, DateTime)).returns(T.any(Date, DateTime))}
    def date(date)
      @date = date
    end

    sig {params(payee: String).returns(String)}
    def payee(payee)
      @payee = payee
    end

    sig {void}
    def cleared!
      @cleared = true
    end

    sig do
      params(
        account: T.nilable(String), 
        amount: T.nilable(Float),
        blk: T.nilable(T.proc.params(arg0: Posting).void)
      ).void
    end
    def posting(account=nil, amount=nil, &blk)
      post = Posting.new
      @postings << post

      if account
        post.account account
        if amount
          post.amount amount
        end
      end

      if block_given?
        blk.call(post)
      end
    end

    sig {params(comment: String).void}
    def comment(comment)
      @comments << comment
    end

    sig {returns(String)}
    def to_s
      lines = ["#{date_string}#{cleared_string} #{@payee}"]

      @comments.each do |comment|
        lines << "    ; #{comment}"
      end

      @postings.each do |post|
        lines << "    " + post.to_s
      end

      lines.join("\n")
    end

    private

    sig {returns(String)}
    def date_string
      T.must(@date).strftime(@date_format)
    end

    sig {returns(String)}
    def cleared_string
      @cleared ? ' *' : ''
    end
  end
end
