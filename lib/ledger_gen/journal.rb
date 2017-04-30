module LedgerGen
  class Journal
    def self.build
      journal = new
  
      yield journal

      return journal
    end
    
    def initialize
      @transactions = []
    end

    def transaction
      txn = Transaction.new
      @transactions << txn

      yield txn
    end

    def to_s
      @transactions.map(&:to_s).join("\n\n")
    end
  end
end
