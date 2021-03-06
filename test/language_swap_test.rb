require './test/test_helper'

class LanguageSwapTest < Minitest::Test
  def test_it_can_swap_character
    words = ["h", "i"]
    english = true
    language = LanguageSwap.new(words, english)

    expected = "0.00.."

    assert_equal expected, language.swap_character("h")

    english = false
    words = ["0.00..", ".00..."]
    language = LanguageSwap.new(words, english)
    expected = "h"

    assert_equal expected, language.swap_character("0.00..")
  end

  def test_it_can_swap_language
    words = ["h", "i"]
    english = true
    language = LanguageSwap.new(words, english)
    expected = ["0.00..", ".00..."]

    assert_equal expected, language.swap_characters(["h","i"])

    english = false
    words = ["0.00..", ".00..."]
    language = LanguageSwap.new(words, english)
    expected = ["h", "i"]

    assert_equal expected, language.swap_characters(["0.00..", ".00..."])
  end

  def test_it_can_capitalize_english
    english = false
    words = [".....0", "0.00..", ".00..."]

    language = LanguageSwap.new(words, english)
    words = ["$$$", "h", "i"]
    expected = ["H", "i"]

    assert_equal expected, language.check_to_capitalize(words)
  end

  def test_it_can_capitalize_braille
    words = ["H", "i"]
    english = true
    language = LanguageSwap.new(words, english)

    expected = ["$$$", "h", "i"]

    assert_equal expected, language.check_to_capitalize_braille(words)
  end

  def test_it_can_switch_numbers_english
    english = false
    words = [".0.000", "0.....", "......", "0....."]

    language = LanguageSwap.new(words, english)
    words = ["###", "a", " ", "a"]
    expected = ["1", " ", "a"]

    assert_equal expected, language.check_to_numberfy(words)
  end

  def test_it_can_switch_numbers_braille
    english = true
    words = ["H", "i"]

    language = LanguageSwap.new(words, english)
    words = ["1", "2", " ", "a"]
    expected = ["###", "a", "b", " ", "a"]

    assert_equal expected, language.add_number_switch(words)

    english = true
    words = ["H", "i"]

    language = LanguageSwap.new(words, english)
    words = ["1", "2", "c", "a"]
    expected = ["###", "a", "b", " ", "c", "a"]
    assert_equal expected, language.add_number_switch(words)
  end
end