RSpec.describe Fafx do
  it "Has a version number" do
    expect(Fafx::VERSION).not_to be nil
  end

  it "ExchangeRate GBP USD is bigger than zero" do
    actual = Fafx::ExchangeRate.at('2018-09-06', 'GBP', 'USD')
    expect(actual).to be > 0
  end
end
