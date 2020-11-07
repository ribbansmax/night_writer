require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/writer'

class WriterTest < Minitest::Test
  def test_it_exists_and_has_attributes
    text = mock()
    destination = "dummy_writer.txt"
    writer = Writer.new(destination, text)

    expected = "./data/dummy_writer.txt"

    assert_equal expected, writer.path
  end

  def test_it_can_write_to_file
    text = ["hello world", "this is world"]
    destination = "dummy_writer.txt"
    writer = Writer.new(destination, text)

    assert File.exists?("./data/dummy_writer.txt")
  end
end