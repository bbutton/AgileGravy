class PayrollWriter
  def initialize(sink)
    @sink = sink
  end

  def write_pay_record(pay_records)
    if(pay_records.length > 0) then
      check_number = 100
      pay_records.each do |pay_record|
        pay_data = "Check|#{pay_record.name}|$#{pay_record.pay}|#{check_number}|#{pay_record.pay_date}"
        @sink.write(pay_data + "\n")
        check_number += 1
      end
    end
  end
end