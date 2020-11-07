require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/translation'
require './lib/reader'

class TranslationTest < Minitest::Test
  def test_it_exists_and_has_attributes
    file_to_read = "dummy.txt"
    file_to_make = "braille.txt"
    translation = Translation.new(file_to_read, file_to_make)

    assert_equal file_to_make, translation.destination
    assert_instance_of Reader, translation.reader
  end

  def test_it_can_detect_english
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.expects(:first_line).returns("0.00.")

    translation = Translation.new("", "")

    assert_equal false, translation.is_english?

    reader.expects(:first_line).returns("english")

    assert translation.is_english?
  end
end