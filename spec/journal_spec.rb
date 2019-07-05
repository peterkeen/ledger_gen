# typed: false
require "spec_helper"

describe LedgerGen::Journal do
  it "should generate some ledger" do
    j = LedgerGen::Journal.build do |journal|
      journal.transaction do |txn|
        txn.payee "DTE Energy"
        txn.date Date.parse("2017/04/30")
        txn.cleared!

        txn.posting do |post|
          post.account "Expenses:Utils:Energy"
          post.amount 190
        end

        txn.posting do |post|
          post.account "Assets:PNC:Checking"
        end
      end
    end
    expect(j.to_s).to_not be_nil
  end
end
