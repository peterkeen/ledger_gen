# typed: true
module LedgerGen
  class Journal
    attr_accessor :date_format

    def self.build
      journal = new
  
      yield journal

      return journal
    end
    
    def initialize
      @transactions = []
      @date_format = '%Y/%m/%d'
    end

    def transaction
      txn = Transaction.new(date_format)
      @transactions << txn

      yield txn
    end

    def to_s
      @transactions.map(&:to_s).join("\n\n") + "\n"
    end

    def pretty_print(ledger_options='')
      IO.popen("ledger #{ledger_options} -f - print", mode='r+') do |io|
        io.write to_s
        io.close_write
        io.read
      end
    end
  end
end
