require 'rspec'
require_relative '../lib/payroll_writer'

describe 'Writes payroll data to output sink' do

  it 'Writes a single payroll record to sink' do
    pay_records = [PayRecord.new("Bill", 100, "01/01/2014")]
    sink = StringIO.new("", "w")

    payroll_writer = PayrollWriter.new(sink)

    payroll_writer.write_pay_record(pay_records)

    expect(sink.string).to eq("Check|Bill|$100|100|01/01/2014\n")
  end

  it 'writes nothing if input pay_records are nil' do
    pay_records = []
    sink = StringIO.new("", "w")

    payroll_writer = PayrollWriter.new(sink)

    payroll_writer.write_pay_record(pay_records)

    expect(sink.string).to eq("")
  end

  it 'Writes a single payroll record to sink' do
    pay_records = [PayRecord.new("Bill", 100, "01/01/2014"), PayRecord.new("Sally", 200, "01/01/2014")]
    sink = StringIO.new("", "w")

    payroll_writer = PayrollWriter.new(sink)

    payroll_writer.write_pay_record(pay_records)

    expect(sink.string).to eq("Check|Bill|$100|100|01/01/2014\nCheck|Sally|$200|101|01/01/2014\n")
  end
end