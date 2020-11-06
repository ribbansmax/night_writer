class Translation
  attr_reader :origin, :destination
  def initialize(file_to_read, file_to_write)
    @origin = file_to_read
    @destination = file_to_write
  end

  def is_english?(file)
    line = file.first_line
    !(line.gsub(/0./, '') == "")
  end
end