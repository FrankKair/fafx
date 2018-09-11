RSpec.describe Fafx do
  it 'Has a version number' do
    expect(Fafx::VERSION).not_to be nil
  end

  it 'ExchangeRate GBP USD is bigger than zero' do
    actual = Fafx::ExchangeRate.at('2018-09-06', 'GBP', 'USD')
    expect(actual).to be > 0
  end

  it 'Raise exception if date is out of range' do
    expect do
      Fafx::ExchangeRate.at('2015-09-06', 'GBP', 'USD')
    end.to raise_exception(KeyError)
  end

  it 'Raise exception if currency does not exist' do
    expect do
      Fafx::ExchangeRate.at('2018-09-06', 'ZZZ', 'USD')
    end.to raise_exception(KeyError)
  end
end
