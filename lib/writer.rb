class Writer
  attr_reader :path

  def initialize(destination)
    @path = "./data/" + destination
  end
end