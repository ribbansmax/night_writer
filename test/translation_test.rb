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

  def test_it_can_return_characters
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.expects(:characters).returns(6)

    translation = Translation.new("", "")

    assert_equal 6, translation.characters
  end

  def test_it_can_split_english_by_character
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.expects(:lines).returns(["hello world", "this is world"])
    translation = Translation.new("", "")
    expected = ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d", "t", "h", "i", "s", " ", "i", "s", " ", "w", "o", "r", "l", "d"]

    assert_equal expected, translation.split_english
  end
end