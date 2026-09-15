# frozen_string_literal: true

RSpec.describe Fafx::ExchangeRate do
  let(:sample_rates) do
    {
      '2026-03-27' => {
        'EUR' => 1.0,
        'GBP' => 0.84,
        'USD' => 1.08,
        'JPY' => 161.0,
      },
      '2026-03-26' => {
        'EUR' => 1.0,
        'GBP' => 0.845,
        'USD' => 1.082,
        'JPY' => 160.5,
      }
    }
  end

  let(:core) { Fafx::Core.new(sample_rates) }

  before do
    allow(Fafx::Core).to receive(:default).and_return(core)
    allow(Fafx::Core).to receive(:reset!)
  end

  it 'has a version number' do
    expect(Fafx::VERSION).not_to be nil
  end

  it 'returns a rate for the most recent date' do
    expect(described_class.get('GBP', 'USD')).to eq(1.08 / 0.84)
  end

  it 'uses the previous friday for weekend dates' do
    sunday = Date.new(2026, 3, 29)

    expect(described_class.at(sunday, 'GBP', 'USD')).to eq(1.08 / 0.84)
  end

  it 'raises an exception if date is out of range' do
    expect do
      described_class.at(Date.new(2026, 3, 1), 'GBP', 'USD')
    end.to raise_exception(Fafx::DateError)
  end

  it 'raises an exception if date is not a Date object' do
    expect do
      described_class.at('12-12-2019', 'GBP', 'USD')
    end.to raise_exception(Fafx::DateError)
  end

  it 'raises and exception if currency does not exist' do
    expect do
      described_class.get('ZZZ', 'GBP')
    end.to raise_exception(Fafx::CurrencyError)
  end

  it 'raises an exception for nil currency' do
    expect do
      described_class.get(nil, 'GBP')
    end.to raise_exception(Fafx::CurrencyError)
  end

  it 'raises an exception for empty currency' do
    expect do
      described_class.get('', 'GBP')
    end.to raise_exception(Fafx::CurrencyError)
  end

  it 'includes EUR in the available currencies' do
    expect(described_class.currencies_available).to include('EUR')
  end

  it 'returns the most recent rates' do
    expect(described_class.most_recent).to eq(sample_rates['2026-03-27'])
  end

  it 'updates data and clears the cached core' do
    allow(Fafx::DataFetcher).to receive(:save_to_disk)

    described_class.update_data

    expect(Fafx::DataFetcher).to have_received(:save_to_disk)
    expect(Fafx::Core).to have_received(:reset!)
  end
end
