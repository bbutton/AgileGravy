class PayrollEngine
  def initialize(employee)
    @employee = employee
  end

  def run_payroll(pay_date)
    "Check|#{@employee.name}|$#{@employee.yearly_salary/12}|100|#{pay_date}"
  end
end