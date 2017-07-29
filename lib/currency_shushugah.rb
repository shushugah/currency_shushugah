require 'currency_shushugah/version'
require 'currency_shushugah/errors'

module CurrencyShushugah
  # Understands currency and quantity
  class Money
    include Comparable

    attr_reader :quantity, :currency
    protected :currency, :quantity

    def self.conversion_rates(base_currency, hash_rates)
      @rates = hash_rates.merge(base_currency => 1)
    end

    def initialize(quantity, currency)
      raise UnsupportedCurrency unless rates[currency]
      @quantity = quantity
      @currency = currency
    end

    def <=>(other)
      return unless other.class == self.class
      quantity <=> other.convert_to(currency).quantity
    end

    def inspect
      "#{'%0.2f' % quantity} #{currency}"
    end

    def convert_to(other_currency)
      raise UnsupportedCurrency unless rates[other_currency]
      return self if currency == other_currency
      new_quantity = @quantity * rates[other_currency] / rates[currency]
      new_money(new_quantity, other_currency)
    end

    def +(other)
      new_money(quantity + other.convert_to(currency).quantity)
    end

    def -(other)
      self + -other
    end

    def -@
      new_money(-quantity)
    end

    def coerce(other)
      [self, other]
    end

    def *(other)
      new_money(quantity * other)
    end

    def /(other)
      raise DivisionByZero if other.zero?
      self * (1.0 / other)
    end

    def new_money(quantity, currency = @currency)
      Money.send :new, quantity.round(2), currency
    end

    def self.rates
      Money.instance_variable_get(:@rates)
    end

    private

    def rates
      self.class.rates
    end
  end
end
