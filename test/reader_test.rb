require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/reader'

class ReaderTest < Minitest::Test
  def test_it_exists_and_has_attributes
    origin = "dummy.txt"
    reader = Reader.new(origin)

    expected = "hello world"

    assert_equal expected, reader.first_line
  end
end