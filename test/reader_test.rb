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
  end
end