class PayrollReader
  def initialize(source)
    @source = source
  end

  def next_payday
    line = @source.readline
    parts = line.strip.split('|')
    parts[1]
  end
end