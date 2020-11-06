class Translation
  attr_reader :origin, :destination
  def initialize(file_to_read, file_to_write)
    @origin = file_to_read
    @destination = file_to_write
  end
end