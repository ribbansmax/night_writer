require 'minitest/autorun'
require 'minitest/pride'
require './lib/translation'

class TranslationTest < Minitest::Test
  def test_it_exists_and_has_attributes
    file_to_read = "messages.txt"
    file_to_make = "braille.txt"
    translation = Translation.new(file_to_read, file_to_make)

    assert_equal file_to_read, translation.origin
    assert_equal file_to_make, translation.destination
  end
end