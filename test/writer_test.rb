require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/writer'

class WriterTest < Minitest::Test
  def test_it_exists_and_has_attributes
    destination = "dummy_writer.txt"
    writer = Writer.new(destination)

    expected = "./data/dummy_writer.txt"

    assert_equal expected, writer.path
  end
end