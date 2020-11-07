require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/translation'
require './lib/reader'
require './lib/language_swap'

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

  def test_it_can_split_braille_by_character
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.expects(:lines).returns(["0..0", "...0", "0.0."])
    translation = Translation.new("", "")

    expected = ["0...0.",".0.00."]

    assert_equal expected, translation.split_braille
  end

  def test_it_can_translate
    translation = Translation.new("dummy.txt", "")
    translation2 = Translation.new("braille_dummy.txt", "")

    expected = ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0..", ".0000.", "0.00..", ".00...", ".00.0.", "......", ".00...", ".00.0.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."]

    assert_equal expected, translation.translate

    expected = ["d","b"]

    assert_equal expected, translation2.translate
  end

  def test_it_can_combine_english
    reader = mock()
    Reader.expects(:new).returns(reader)
    translation = Translation.new("", "")

    expected = "hi"

    assert_equal expected, translation.combine_english(["h", "i"])
  end

  def test_it_can_combine_braille
    reader = mock()
    Reader.expects(:new).returns(reader)
    translation = Translation.new("", "")

    characters = ["00..00", "00..00"]
    expected = ["0000", "....", "0000"]

    assert_equal expected, translation.combine_braille(characters)
  end
end