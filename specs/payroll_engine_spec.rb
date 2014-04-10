require 'rspec'
require File.dirname(__FILE__) + '/../lib/employee'
require File.dirname(__FILE__) + '/../lib/payroll_engine'

describe 'Pays people the appropriate amount on the right day of the month' do

  it 'pays a single person on the first of the month' do
    employee = Employee.new("Bill", 1200)
    payroll_engine = PayrollEngine.new employee

    payroll_details = payroll_engine.run_payroll("01/01/2014")

    expect(payroll_details).to eq(PayRecord.new("Bill", 100, "01/01/2014"))
  end

  it 'pays no one if not the first of the month' do
    employee = Employee.new("Bill", 1200)
    payroll_engine = PayrollEngine.new(employee)

    payroll_details = payroll_engine.run_payroll("01/02/2014")

    expect(payroll_details).to eq(nil)
  end



end