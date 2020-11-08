class Writer
  attr_reader :path, :text

  def initialize(destination, text)
    @path = "./data/" + destination
    @text = text
    write_file
  end

  def write_file
    File.open(path, 'a+') do |file|
      text.each do |line|
        file.puts line.join
      end
    end
  end
end