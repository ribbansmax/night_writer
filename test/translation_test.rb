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
    file_to_read = "dummy.txt"
    file_to_make = "braille.txt"
    translation = Translation.new(file_to_read, file_to_make)

    assert translation.is_english?

    translation2 = Translation.new("braille_dummy.txt", file_to_make)

    assert_equal false, translation2.is_english?
  end
end