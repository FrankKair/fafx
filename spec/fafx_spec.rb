RSpec.describe Fafx do
  it 'Has a version number' do
    expect(Fafx::VERSION).not_to be nil
  end

  it 'ExchangeRate GBP USD is bigger than zero' do
    actual = Fafx::ExchangeRate.at(Date.today, 'GBP', 'USD')
    expect(actual).to be > 0
  end

  it 'Raise exception if date is out of range' do
    expect do
      Fafx::ExchangeRate.at(Date.today - 100, 'GBP', 'USD')
    end.to raise_exception(Fafx::DateError)
  end

  it 'Raise exception if date is not a Date object' do
    expect do
      Fafx::ExchangeRate.at('12-12-2019', 'GBP', 'USD')
    end.to raise_exception(Fafx::DateError)
  end

  it 'Raise exception if currency does not exist' do
    expect do
      Fafx::ExchangeRate.at(Date.today, 'ZZZ', 'USD')
    end.to raise_exception(Fafx::CurrencyError)
  end
end
