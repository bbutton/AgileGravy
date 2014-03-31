class TestUtils
  def self.create_input_file(input_file_root, input_file_contents)
    input_file_name = File.join(Dir.getwd(), input_file_root)

    File.delete(input_file_name) if File.exists?(input_file_name)
    input_file = File.new(input_file_name, "w")
    input_file.write(input_file_contents)
    input_file.close()
    input_file_name
  end

  def self.create_output_file(output_file_root)
    output_file_name = File.join(Dir.getwd(), output_file_root)
    File.delete(output_file_name) if File.exists?(output_file_name)
    output_file_name
  end
end