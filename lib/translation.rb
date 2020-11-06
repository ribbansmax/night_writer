class Translation
  attr_reader :origin, :destination
  def initialize(file_to_read, file_to_write)
    @origin = file_to_read
    @destination = file_to_write
  end

  def loo(file)
    line = file.first_line
    if line.gsub(/0./, '') == ""
      "braille"
    else
      "english"
    end
  end
end