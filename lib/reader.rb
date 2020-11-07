class Reader
  attr_reader :path
  def initialize(path)
    @path = "./data/" + path
  end
end