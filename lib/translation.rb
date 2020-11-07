class Translation
  attr_reader :destination, :reader
  def initialize(origin, destination)
    @destination = destination
    @reader = Reader.new(origin)
  end

  def is_english?
    line = reader.first_line
    line.gsub(/[0.]/, '') != ""
  end

  def characters
    reader.characters
  end

  def split_english
    lines = reader.lines
    english = []
    lines.each do |line|
      english << line.chars
    end
    english.flatten
  end
end