require '../lib/payroll_processor'
require '../lib/employee'
require '../specs/test_utils'

describe 'whole system interaction' do

  RSpec.configure do |c|
    c.filter_run_excluding :pending => true
  end

  it 'pays a single employee on first of the month', :pending => true do
    expected_output = "Check|Bill|$100|100|01/01/2014\n"
    employee_list = Employee.new("Bill", 1200)

    input_file_name = TestUtils.create_input_file('SingleEmployeePaymentTest-in.txt',"Payday|01/01/2014\n")
    output_file_name = TestUtils.create_output_file('SingleEmployeePaymentTest-out.txt')

    PayrollProcessor.run(input_file_name, output_file_name, employee_list)

    File.open(output_file_name, "r") do |writer|
      writer.readlines[0].should == (expected_output)
    end
  end

  it 'does not pay anyone if not first of month', :pending => true do
    employee_list = Employee.new("Bill", 1200)

    input_file_name = TestUtils.create_input_file('NoEmployeePaymentTest-in.txt', "Payday|01/02/2014\n")
    output_file_name = TestUtils.create_output_file('NoEmployeePaymentTest-out.txt')

    PayrollProcessor.run(input_file_name, output_file_name, employee_list)

    File.open(output_file_name, "r") do |writer|
      writer.readlines.length.should.equal? 0
    end
  end

  it 'pays everyone if first of the month', :pending => true do
    bills_pay = "Check|Bill|$100|100|01/01/2014\n"
    sallys_pay = "Check|Sally|$200|101|01/01/2014\n"

    employee_list = [Employee.new("Bill", 1200), Employee.new("Sally", 2400)]

    input_file_name = TestUtils.create_input_file('MultiEmployeePaymentTest-in.txt', "Payday|01/01/2014\n")
    output_file_name = TestUtils.create_output_file('MultiEmployeePaymentTest-out.txt')

    PayrollProcessor.run(input_file_name, output_file_name, employee_list)

    File.open(output_file_name, "r") do |writer|
      writer.readline.should == (bills_pay)
      writer.readline.should == (sallys_pay)
    end
  end

  it 'pays a single person on multiple valid paydays', :pending => true do
    first_output = "Check|Bill|$100|100|01/01/2014\n"
    second_output = "Check|Bill|$100|101|02/01/2014\n"
    employee_list = [Employee.new("Bill", 1200)]

    input_file_name = TestUtils.create_input_file('SingleEmployeeMultiPaydayPaymentTest-in.txt', "Payday|01/01/2014\nPayday|02/01/2014\n")
    output_file_name = TestUtils.create_output_file('SingleEmployeeMultiPaydayPaymentTest-out.txt')

    PayrollProcessor.run(input_file_name, output_file_name, employee_list)

    File.open(output_file_name, "r") do |writer|
      writer.readline.should == (first_output)
      writer.readline.should == (second_output)
    end
  end

  it 'pays appropriate people for multiple paydays', :pending => true do
    input_data = "Payday|01/01/2014\nPayday|02/28/2014\nPayday|03/01/2014\n"
    bills_first_pay = "Check|Bill|$100|100|01/01/2014\n"
    bills_second_pay = "Check|Bill|$100|100|03/01/2014\n"
    sallys_first_pay = "Check|Sally|$200|101|01/01/2014\n"
    sallys_second_pay = "Check|Sally|$200|101|03/01/2014\n"

    reader = Tempfile.new('MultiPaydayPaymentTest')
    writer = Tempfile.new('MultiPaydayPaymentTest')
    writer.write(input_data)
    employee_list = [ Employee.new("Bill", 1200), Employee.new("Sally", 2400)]
    payroll_engine = PayrollEngine.new(employee_list)
    payroll_processor = PayrollProcessor.new(reader, payroll_engine, writer)

    payroll_processor.run_payroll(employee_list)

    pay_details = writer.readlines()
    pay_details[0].should == (bills_first_pay)
    pay_details[1].should == (sallys_first_pay)
    pay_details[2].should == (bills_second_pay)
    pay_details[3].should == (sallys_second_pay)
  end
end
