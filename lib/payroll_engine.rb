require_relative '../lib/pay_record'

class PayrollEngine
  def initialize(employee)
    @employee = employee
  end

  def run_payroll(pay_date)
    date_parts = pay_date.split('/')
    pay_record = PayRecord.new(@employee.name, @employee.yearly_salary/12, pay_date) unless date_parts[1] != "01"
  end
end