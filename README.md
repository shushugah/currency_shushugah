[![Code Climate](https://codeclimate.com/github/shushugah/currency_shushugah/badges/gpa.svg)](https://codeclimate.com/github/shushugah/currency_shushugah) [![Issue Count](https://codeclimate.com/github/shushugah/currency_shushugah/badges/issue_count.svg)](https://codeclimate.com/github/shushugah/currency_shushugah) [![Test Coverage](https://codeclimate.com/github/shushugah/currency_shushugah/badges/coverage.svg)](https://codeclimate.com/github/shushugah/currency_shushugah/coverage)
# CurrencyShushugah Gem

Applying best practices and ruby knowledge here.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'currency_shushugah'
```

And then execute:

    $ bundle

Or install it yourself via:

    $ gem install currency_shushugah

## Usage

```
# Configure the currency rates with respect to a base currency (here EUR):

Money.conversion_rates('EUR', {
  'USD'     => 1.11,
  'Bitcoin' => 0.0047,
  'CAD' => 1.39
})

# Instantiate Money objects:

fifty_eur = Money.new(50, 'EUR')

# Get amount and currency:

fifty_eur.amount   # => 50
fifty_eur.currency # => 'EUR'
fifty_eur.inspect  # => '50.00 EUR'

# Convert to a different currency (returns new Money instance)

fifty_eur.convert_to('USD') # => 55.50 USD
fifty_eur.convert_to('USD').currency # => 'USD'

# Perform operations in different currencies:

twenty_dollars = Money.new(20, 'USD')

# Arithmetics:

fifty_eur + twenty_dollars # => 68.02 EUR
fifty_eur - twenty_dollars # => 31.98 EUR
fifty_eur / 2              # => 25 EUR
twenty_dollars * 3         # => 60 USD
3 * twenty_dollars         # => 60 USD

# Comparisons:

twenty_dollars == Money.new(20, 'USD') # => true
twenty_dollars == Money.new(30, 'USD') # => false

fifty_eur_in_usd = fifty_eur.convert_to('USD')
fifty_eur_in_usd == fifty_eur          # => true

twenty_dollars > Money.new(5, 'USD')   # => true
twenty_dollars < fifty_eur             # => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports, feedback and pull requests are welcome on GitHub at https://github.com/shushugah/currency_shushugah. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
