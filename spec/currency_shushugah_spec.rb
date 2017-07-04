require 'spec_helper'

describe Money do
  before :each do
    Money.conversion_rates('EUR', 'USD' => 1.11)
    @ten_euro = Money.new(10, 'EUR')
    @five_usd = Money.new(5, 'USD')
    @seventeen_euro = Money.new(17, 'EUR')
  end

  describe 'conversions' do
    it 'responds to .conversion_rates' do
      expect(Money).to respond_to(:conversion_rates)
    end

    it 'return self when converts to own currency' do
      expect(@ten_euro.convert_to('EUR')).to eq @ten_euro
    end

    it 'raise error when converting to invalid currency' do
      expect { @ten_euro.convert_to('CAD') }.to raise_error('InvalidCurrency')
    end

    it 'should return new instance if converted to different currency' do
      expect(@ten_euro.convert_to('USD')).to eq(Money.new(11.1, 'USD'))
      expect(@ten_euro.convert_to('USD').inspect).to eql '11.10 USD'
    end
  end

  describe 'accessor and display methods' do
    it '#inspect' do
      expect(@ten_euro.inspect).to eql '10.00 EUR'
      expect(@ten_euro.convert_to('USD').inspect).to eql '11.10 USD'
    end

    it '#currency' do
      expect(@ten_euro.send(:currency)).to eql 'EUR'
    end

    it '#quantity' do
      expect(@ten_euro.send(:quantity)).to eql 10
    end
  end

  describe 'arithmetics' do
    it 'adds' do
      expect(@ten_euro).to respond_to(:+)
      expect((@ten_euro + @ten_euro).inspect).to eql '20.00 EUR'
      expect((@ten_euro + @five_usd).inspect).to eql '14.50 EUR'
      expect((@five_usd + @five_usd).inspect).to eql '10.00 USD'
    end

    it 'subtracts' do
      expect((@ten_euro - @ten_euro).inspect).to eq '0.00 EUR'
      expect((@ten_euro - @five_usd).inspect).to eq '5.50 EUR'
    end

    it 'multiplies' do
      expect(@ten_euro).to respond_to(:*)
      expect(@ten_euro * 3).to eq Money.new(30, 'EUR')
      expect(3 * @ten_euro).to eq Money.new(30, 'EUR')
      expect(@ten_euro * 0).to eq Money.new(0, 'EUR')
    end

    it 'divides' do
      expect(@ten_euro).to respond_to(:*)
      expect(@ten_euro / 2).to eq Money.new(5, 'EUR')
      expect { @ten_euro / 0 }.to raise_error('InvalidDivision')
    end
  end

  describe 'comparison operators' do
    it 'different currencies still equal' do
      expect(@ten_euro == (@ten_euro.convert_to 'USD')).to eql true
      expect(@ten_euro != @seventeen_euro).to eql true
    end

    it 'inequalities' do
      expect(@ten_euro < @seventeen_euro).to eql true
      expect(@ten_euro > @seventeen_euro).to eql false
    end
  end
end
