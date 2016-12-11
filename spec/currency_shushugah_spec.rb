require 'spec_helper'

describe Money do
	before :each do 
		@ten_euro = Money.new(10, "EUR")
		@five_usd = Money.new(5, "USD")
		@seventeen_euro = Money.new(17, "EUR")
		Money.conversion_rates("EUR",{"USD"=> 1.11})
	end

	describe ".conversion_rates" do
		it 'should respond to :conversion_rates' do
	    expect(Money).to respond_to(:conversion_rates)

	  end

	end

	describe "#new" do
    it "takes two parameters and returns a Money object" do
    	expect(@ten_euro).to be_an_instance_of Money
    end
	end

	describe "#amount" do
    it "returns an amount" do
    	expect(@ten_euro).to respond_to(:amount)
    end
	end

	describe "#currency" do
    it "returns the correct currency" do
    expect(@ten_euro.currency).to eql "EUR"
    end
	end

	describe "#convert_to" do 
		it "create new Money object with currency/amount" do 
			expect @ten_euro.convert_to("EUR").should equal @ten_euro
			expect @ten_euro.convert_to("USD").amount.should eql 11.1
			expect @ten_euro.convert_to("USD").currency.should eql "USD"
			expect Money.new(15,"USD").convert_to("EUR").amount.should eql 13.51
			expect Money.new(13.51,"EUR").convert_to("USD").amount.should eql 15.00
		end
	end

	describe "#inspect" do
  	it "returns the correct currency" do
      @ten_euro.inspect.should eql "10.00 EUR"
      @ten_euro.convert_to("USD").inspect.should eql "11.10 USD"
      
  	end 
  end   

  describe "#+" do
  	it "should respond to sum and return new instance" do
  	  expect(@ten_euro).to respond_to(:+)		
  	    (@ten_euro + @ten_euro).amount.should eql 20.0
	  	  (@ten_euro + @five_usd).amount.should eql 14.5
	  	  (@ten_euro + @five_usd).currency.should eql "EUR"
	  	  (@five_usd + @ten_euro).amount.should eql 14.5
	  	  (@five_usd + @ten_euro).currency.should eql "EUR"
	  	  (@five_usd + @five_usd).amount.should eql 10.0
	  	  (@five_usd + @five_usd).currency.should eql "USD"
		end	
	end

	  describe "#-" do
  	it "should respond to sum and return new instance" do
  		expect(@ten_euro).to respond_to(:-)		
	  	(@ten_euro - @ten_euro).amount.should eql 0.0
	 		(@ten_euro - @five_usd).amount.should eql 5.5
	  	(@ten_euro - @five_usd).currency.should eql "EUR"
	 		(@five_usd - @ten_euro).amount.should eql -5.5
	   	(@five_usd - @ten_euro).currency.should eql "EUR"
	 		(@five_usd - @five_usd).amount.should eql 0.0
	 		(@five_usd - @five_usd).currency.should eql "USD"
		end	
	end

	describe "#/" do
  	it "should respond to division and return new instance" do
	  	expect(@ten_euro).to respond_to(:/)		
	  	(@ten_euro / 10).amount.should eql 1.0
	  	(@ten_euro / 10).currency.should eql "EUR"
		end	
	end

	describe "#*" do
  	it "should respond to multiplication and return new instance" do
	  	expect(@ten_euro).to respond_to(:*)		
	  	(@ten_euro * 10).amount.should eql 100.0
	  	(@ten_euro * 10).currency.should eql "EUR"
	  	(@five_usd * 10).amount.should eql 50.0
	  	(@five_usd * 10).currency.should eql "USD"
		end	
	end

	describe "#equalities" do
  	it "should check comparison operators, including with same/different currencies" do
	  	expect(@ten_euro).to respond_to(:==)		
	  	expect(@ten_euro == (@ten_euro.convert_to("USD"))).to be_truthy
	  	expect(@ten_euro == (@ten_euro.convert_to("EUR"))).to be_truthy
	  	expect(@ten_euro > @ten_euro).to be_falsey
	  	expect(@ten_euro < @ten_euro).to be_falsey
	  	expect(@ten_euro == @seventeen_euro).to be_falsey
	  	expect(@ten_euro == (@seventeen_euro.convert_to("USD"))).to be_falsey
	  	expect(@ten_euro > @ten_euro.convert_to("USD")).to be_falsey
		end		
	end
end
