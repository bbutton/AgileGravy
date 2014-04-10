require_relative '../lib/pay_record'

class PayrollEngine
  def initialize(employee)
    @employee = employee
  end

  def run_payroll(pay_date)
    pay_record = PayRecord.new(@employee.name, @employee.yearly_salary/12, pay_date)
  end
end