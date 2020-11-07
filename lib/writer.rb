class Writer
  attr_reader :path, :text

  def initialize(destination, text)
    @path = "./data/" + destination
    @text = text
  end
end