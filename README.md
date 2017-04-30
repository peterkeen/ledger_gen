# LedgerGen

Generate [Ledger](https://ledger-cli.org) files using a convenient Ruby DSL.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ledger_gen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ledger_gen

## Usage

```ruby
j = LedgerGen::Journal.build do |journal|
  journal.transaction do |txn|
    txn.cleared!
    txn.date Date.parse('2017/04/30')
    txn.payee "DTE Energy"
    txn.posting do |post|
      post.account 'Expenses:Utils:Energy'
      post.amount 190.0
      post.currency '$'
    end
    txn.posting 'Assets:PNC:Checking', -190.0
  end
end

puts j.pretty_print # ledger binary required
puts j.to_s # not pretty, but it works without the binary
```

## Limitations

LedgerGen currently supports a very limited subset of Ledger. In particular, that means:

* Only supports dollars as commodity
* Does not insert thousands separator
* Can't insert journal-level comments
* No support for building things like periodic entries or automated transactions
* No support for virtual transactions

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/peterkeen/ledger_gen. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

