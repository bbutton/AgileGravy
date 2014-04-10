class PayrollWriter
  def initialize(sink)
    @sink = sink
  end

  def write_pay_record(pay_record)
    pay_data = "Check|#{pay_record.name}|$#{pay_record.pay}|100|#{pay_record.pay_date}"
    @sink.write(pay_data + "\n")
  end
end