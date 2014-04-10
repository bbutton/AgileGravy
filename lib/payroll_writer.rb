class PayrollWriter
  def initialize(sink)
    @sink = sink
  end

  def write_pay_record(pay_record)
    @sink.write(pay_record + "\n")
  end
end