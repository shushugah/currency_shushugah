require 'spec_helper'

module CurrencyShushugah
  describe Money do
    let(:ten_euro) { described_class.new(10, 'EUR') }
    let(:five_usd) { described_class.new(5, 'USD') }
    let(:seventeen_euro) { described_class.new(17, 'EUR') }

    before do
      described_class.conversion_rates('EUR', 'USD' => 1.11)
    end

    describe 'conversions' do
      it '.conversion_rates' do
        expect(described_class).to respond_to(:conversion_rates)
      end

      it 'return self when converts to own currency' do
        expect(ten_euro.convert_to('EUR')).to eq ten_euro
      end

      it 'raise error when converting to invalid currency' do
        expect { ten_euro.convert_to('CAD') }
          .to raise_error(UnsupportedCurrency)
      end

      it 'conversion changes currency and relative quantity' do
        expect(ten_euro.convert_to('USD'))
          .to eq(described_class.new(11.1, 'USD'))
      end
    end

    describe '#inspect' do
      it '10 EUR' do
        expect(ten_euro.inspect).to eql '10.00 EUR'
      end

      it '10 EUR converted to USD' do
        expect(ten_euro.convert_to('USD').inspect).to eql '11.10 USD'
      end
    end

    describe 'addition and subtraction' do
      it 'adds same currencies' do
        expect((ten_euro + ten_euro).inspect).to eql '20.00 EUR'
      end

      it 'adds different currencies' do
        expect((ten_euro + five_usd).inspect).to eql '14.50 EUR'
      end

      it 'subtracts same currencies' do
        expect((ten_euro - ten_euro).inspect).to eq '0.00 EUR'
      end

      it 'subtracts different currencies' do
        expect((ten_euro - five_usd).inspect).to eq '5.50 EUR'
      end
    end

    describe 'multiplication and division' do
      it 'multiplies money instance by number' do
        expect(ten_euro * 3).to eq described_class.new(30, 'EUR')
      end

      it 'multiplies number by Money instance' do
        expect(3 * ten_euro).to eq described_class.new(30, 'EUR')
      end

      it 'money instance times zero shows same currency' do
        expect(ten_euro * 0).to eq described_class.new(0, 'EUR')
      end

      it 'divides by scalar' do
        expect(ten_euro / 2).to eq described_class.new(5, 'EUR')
      end

      it 'divides by zero raises error' do
        expect { ten_euro / 0 }.to raise_error(DivisionByZero)
      end
    end

    describe 'comparison operators' do
      it 'converted money instances are equal' do
        expect(ten_euro == described_class.new(11.10, 'USD')).to be true
      end

      it 'different quantities are not equal' do
        expect(ten_euro != seventeen_euro).to be true
      end

      it '17 euros is greater than 10 euro' do
        expect(ten_euro < seventeen_euro).to be true
      end

      it '10 euros is less than 17 euros' do
        expect(ten_euro > seventeen_euro).to be false
      end
    end
  end
end
