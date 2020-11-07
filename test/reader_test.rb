require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/reader'

class ReaderTest < Minitest::Test
  def test_it_exists_and_has_attributes
    origin = "dummy.txt"
    reader = Reader.new(origin)

    expected = "./data/dummy.txt"

    assert_equal expected, reader.path
    assert_equal "hello world", reader.first_line
    assert_equal "this is world", reader.lines[1]
  end

  def test_it_can_tell_characters
    origin = "dummy.txt"
    reader = Reader.new(origin)

    assert_equal 24, reader.characters
  end
end