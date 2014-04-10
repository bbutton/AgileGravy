require 'rspec'
require_relative '../lib/payroll_reader'

describe 'Reads records from input source describing date for which payroll is to be run' do

  it 'Reads paydate from input source' do
    source = StringIO.new("Paydate|01/01/2014\n")
    reader = PayrollReader.new(source)

    pay_date = reader.next_payday

    expect(pay_date).to eq("01/01/2014")
  end
end