require_relative '../lib/pay_record'

class PayrollEngine
  def initialize(employee_list)
    @employee_list = employee_list
  end

  def run_payroll(pay_date)
    pay_record = nil

    date_parts = pay_date.split('/')
    if(date_parts[1] == "01") then
      employee = @employee_list[0]
      pay_record = PayRecord.new(employee.name, employee.yearly_salary/12, pay_date)
    end

    pay_record
  end
end