require "currency_shushugah/version"

class Money
  attr_accessor :currency, :amount
	@@currencies = {}
	@@base_currency = ""

	def self.conversion_rates(currency, hash)
		@@currencies[currency] = hash
		@@base_currency = currency
	end

	def initialize(amount, currency)
		@amount = amount.round(2)
		@currency = currency
	end

	def convert_to(currency_code)
		return self if currency == currency_code
		if @@currencies[currency] && @@currencies[currency].has_key?(currency_code)
			Money.new(@@currencies[currency][currency_code]*amount, currency_code)	
		else
			Money.new(amount/@@currencies[currency_code][currency], currency_code)
		end	
	end

	def inspect
		"#{'%0.2f' % @amount} #{@currency}"
	end

  [:+, :-].each do |method_name|
  	define_method method_name do |arg|
  	if currency == arg.currency	
  		normalized_amount, normalized_arg_amount, currency_param = amount, arg.amount, currency
  	elsif [currency, arg.currency].include?(@@base_currency)
  		normalized_amount, normalized_arg_amount, currency_param = self.convert_to(@@base_currency).amount, arg.convert_to(@@base_currency).amount, @@base_currency
  	else
  		normalized_arg_amount, currency_param = arg.convert_to(currency).amount, currency	  		
  	end
  		Money.new(normalized_amount.send(method_name, normalized_arg_amount), currency_param)
  	end
  end

  [:*, :/].each do |method_name|
  	define_method method_name do |arg|
  		Money.new(amount.send(method_name, arg), currency)
  	end
  end

  [:>,:<,:==].each do |method_name|
  	define_method method_name do |arg|
  		amount.send(method_name, arg.convert_to(currency).amount) 
  	end
  end
end
