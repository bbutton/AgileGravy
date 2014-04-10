class PayRecord
  attr_reader :name, :pay, :pay_date

  def initialize(name, pay, pay_date)
    @name = name
    @pay = pay
    @pay_date = pay_date
  end

  def ==(other)
    @name == other.name && @pay == other.pay && @pay_date == other.pay_date
  end
end