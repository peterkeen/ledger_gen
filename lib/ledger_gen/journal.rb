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
      @transactions.map(&:to_s).join("\n\n") + "\n"
    end

    def pretty_print
      IO.popen("ledger -f - print", mode='r+') do |io|
        io.write to_s
        io.close_write
        io.read
      end
    end
  end
end
