require 'rspec'
require_relative '../lib/payroll_writer'

describe 'Writes payroll data to output sink' do

  it 'Writes a single payroll record to sink' do
    pay_record = PayRecord.new("Bill", 100, "01/01/2014")
    sink = StringIO.new("", "w")

    payroll_writer = PayrollWriter.new(sink)

    payroll_writer.write_pay_record(pay_record)

    expect(sink.string).to eq("Check|Bill|$100|100|01/01/2014\n")
  end

  it 'writes nothing if input pay_records are nil' do
    pay_record = nil
    sink = StringIO.new("", "w")

    payroll_writer = PayrollWriter.new(sink)

    payroll_writer.write_pay_record(pay_record)

    expect(sink.string).to eq("")
  end
end