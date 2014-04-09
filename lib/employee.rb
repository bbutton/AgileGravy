class Employee
  attr_reader :name, :yearly_salary

  def initialize name, yearly_salary
    @name = name
    @yearly_salary = yearly_salary
  end
end