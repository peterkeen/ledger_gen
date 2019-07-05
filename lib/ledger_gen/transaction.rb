# typed: true
module LedgerGen
  class Transaction
    extend T::Sig

    def initialize(date_format=nil)
      @date_format = date_format || '%Y/%m/%d'
      @postings = []
      @comments = []
    end

    sig { params(date: T.any(Date, DateTime)).returns(T.any(Date, DateTime)) }
    def date(date)
      @date = date
    end

    sig { params(payee: String).returns(String) }
    def payee(payee)
      @payee = payee
    end

    def cleared!
      @cleared = true
    end

    def posting(*args)
      post = Posting.new
      @postings << post

      if args.length > 0
        post.account args.shift
        if args.length > 0
          post.amount args[0]
        end
      else
        yield post
      end
    end

    def comment(comment)
      @comments << comment
    end

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

    def date_string
      @date.strftime(@date_format)
    end

    def cleared_string
      @cleared ? ' *' : ''
    end
  end
end
