module LedgerGen
  class Transaction
    def initialize
      @postings = []
    end

    def date(date)
      @date = date
    end

    def payee(payee)
      @payee = payee
    end

    def cleared!
      @cleared = true
    end

    def posting
      post = Posting.new
      @postings << post
      yield post
    end

    def to_s
      lines = ["#{date_string}#{cleared_string} #{@payee}"]
      @postings.each do |post|
        lines << "    " + post.to_s
      end

      lines.join("\n")
    end

    private

    def date_string
      @date.strftime("%Y/%m/%d") 
    end

    def cleared_string
      @cleared ? ' *' : ''
    end
  end
end
