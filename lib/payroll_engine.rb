require_relative '../lib/pay_record'

class PayrollEngine
  def initialize(employee_list)
    @employee_list = employee_list
  end

  def run_payroll(pay_date)
    pay_record = []

    date_parts = pay_date.split('/')
    if(date_parts[1] == "01") then
      @employee_list.each do |employee|
        pay_record << PayRecord.new(employee.name, employee.yearly_salary/12, pay_date)
      end
    end

    pay_record
  end
end