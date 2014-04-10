require_relative '../lib/employee'
require_relative '../lib/payroll_reader'
require_relative '../lib/payroll_writer'
require_relative '../lib/payroll_engine'

class PayrollProcessor
  def initialize input_reader, payroll_engine, output_writer
    @input_reader = input_reader
    @payroll_engine = payroll_engine
    @output_writer = output_writer
  end

  def run_payroll
    pay_date = @input_reader.next_payday
    payroll_details = @payroll_engine.run_payroll pay_date
    @output_writer.write_pay_record payroll_details
  end

  def self.run(input_file_name, output_file_name, employee_list)
    input_file = File.open(input_file_name, "r")
    input_reader = PayrollReader.new(input_file)

    output_file = File.new(output_file_name, "w")
    output_writer = PayrollWriter.new(output_file)

    payroll_engine = PayrollEngine.new(employee_list)

    begin
      payroll_processor = PayrollProcessor.new(input_reader, payroll_engine, output_writer)
      payroll_processor.run_payroll
    ensure
      output_file.close
      input_file.close
    end
  end
end