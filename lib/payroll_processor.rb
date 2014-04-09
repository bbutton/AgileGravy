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
end