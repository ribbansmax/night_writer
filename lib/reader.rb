class Reader
  attr_reader :path, :lines, :first_line
  def initialize(path)
    @path = "./data/" + path
    line_maker
    @first_line = lines[0]
  end

  # this still needs a test (stubbit)
  def line_maker
    @lines = File.readlines(path, chomp: true)
  end

  def characters
    lines.sum do |line|
      line.length
    end
  end
end