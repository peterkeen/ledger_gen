# typed: strict

module LedgerGen
  class Journal
    extend T::Sig

    sig {returns(String)}
    attr_accessor :date_format

    sig {params(blk: T.proc.params(arg0: Journal).void).returns(Journal)}
    def self.build(&blk)
      journal = new
  
      blk.call(journal)

      return journal
    end
    
    sig {void}
    def initialize
      @transactions = T.let([], T::Array[Transaction])
      @date_format = T.let('%Y/%m/%d', String)
    end

    sig {params(blk: T.proc.params(arg0: Transaction).void).void}
    def transaction(&blk)
      txn = Transaction.new(date_format)
      @transactions << txn

      yield txn
    end

    sig {returns(String)}
    def to_s
      @transactions.map(&:to_s).join("\n\n") + "\n"
    end

    sig {params(ledger_options: String).returns(String)}
    def pretty_print(ledger_options='')
      if ledger_options == ''
        ledger_options = %Q{-y "#{date_format}" --sort=date}
      end

      IO.popen("ledger #{ledger_options} -f - print", 'r+') do |io|
        io.write to_s
        io.close_write
        io.read
      end
    end
  end
end
