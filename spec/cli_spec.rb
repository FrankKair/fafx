# frozen_string_literal: true

require 'spec_helper'
require 'stringio'

RSpec.describe Fafx::CLI do
  let(:stdout) { StringIO.new }
  let(:stderr) { StringIO.new }

  it 'prints help when no arguments are given' do
    exit_code = described_class.run([], out: stdout, err: stderr)

    expect(exit_code).to eq(0)
    expect(stdout.string).to include('Usage: fafx [options]')
    expect(stderr.string).to eq('')
  end

  it 'prints the most recent rates' do
    allow(Fafx::ExchangeRate).to receive(:most_recent).and_return('USD' => 1.08, 'GBP' => 0.84)

    exit_code = described_class.run(['--recent'], out: stdout, err: stderr)

    expect(exit_code).to eq(0)
    expect(stdout.string).to include("USD 1.08\n")
    expect(stdout.string).to include("GBP 0.84\n")
  end

  it 'updates data from the CLI' do
    allow(Fafx::ExchangeRate).to receive(:update_data)

    exit_code = described_class.run(['--update'], out: stdout, err: stderr)

    expect(exit_code).to eq(0)
    expect(Fafx::ExchangeRate).to have_received(:update_data)
    expect(stdout.string).to include('Exchange rates data updated!')
  end

  it 'returns an error for invalid options' do
    exit_code = described_class.run(['recent'], out: stdout, err: stderr)

    expect(exit_code).to eq(1)
    expect(stderr.string).to include('invalid option: recent')
  end

  it 'prints the version' do
    exit_code = described_class.run(['--version'], out: stdout, err: stderr)

    expect(exit_code).to eq(0)
    expect(stdout.string).to include("fafx #{Fafx::VERSION}")
  end

  it 'reports runtime errors to stderr' do
    allow(Fafx::ExchangeRate).to receive(:dates_available).and_raise(Fafx::DataError, 'offline')

    exit_code = described_class.run(['--dates'], out: stdout, err: stderr)

    expect(exit_code).to eq(1)
    expect(stderr.string).to include('offline')
  end
end
