require 'rspec'
require File.dirname(__FILE__) + '/../lib/payroll_processor'

describe 'How it coordinates entire application' do

  it 'orchestrates messages passed between correct objects' do
    payday = "payday"
    payroll_details = "details"

    input_reader = double("input_reader")
    allow(input_reader).to receive(:next_payday).and_return(payday)

    payroll_engine = double("payroll_engine")
    allow(payroll_engine).to receive(:run_payroll).with(payday).and_return(payroll_details)

    output_writer = double("output_writer")
    expect(output_writer).to receive(:write_pay_record).with(payroll_details)

    payroll_processor = PayrollProcessor.new(input_reader, payroll_engine, output_writer)

    payroll_processor.run_payroll()
  end
end