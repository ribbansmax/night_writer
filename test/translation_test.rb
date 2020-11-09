require './test/test_helper'

class TranslationTest < Minitest::Test
  def test_it_exists_and_has_attributes
    file_to_read = "dummy.txt"
    file_to_make = "braille.txt"
    translation = Translation.new(file_to_read, file_to_make, true)

    assert_equal file_to_make, translation.destination
    assert_instance_of Reader, translation.reader
  end

  def test_it_can_detect_english
    reader = mock()
    Reader.stubs(:new).returns(reader)
    reader.stubs(:characters).returns(1)

    translation = Translation.new("", "", false)

    assert_equal false, translation.english

    translation = Translation.new("", "", true)

    assert translation.english
  end

  def test_it_can_return_characters
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.expects(:characters).returns(6)

    translation = Translation.new("", "", true)

    assert_equal 6, translation.characters
  end

  def test_it_can_split_english_by_character
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.expects(:lines).returns(["hello world", "this is world"])
    reader.stubs(:characters).returns(["true"])
    translation = Translation.new("", "", true)
    expected = ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d", "t", "h", "i", "s", " ", "i", "s", " ", "w", "o", "r", "l", "d"]

    assert_equal expected, translation.split_english
  end

  def test_it_can_split_braille_by_character
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.expects(:lines).returns(["0..0", "...0", "0.0."])
    reader.stubs(:characters).returns(["true"])
    translation = Translation.new("", "", false)

    expected = ["0...0.",".0.00."]

    assert_equal expected, translation.split_braille
  end

  def test_it_can_chop_lines_vertically
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.expects(:lines).returns(["0..0", "...0", "0.0."])
    reader.stubs(:characters).returns(["true"])
    translation = Translation.new("", "", false)

    expected = ["0...0.",".0.00."]

    assert_equal expected, translation.line_chops(reader.lines)
  end

  def test_it_can_translate
    translation = Translation.new("dummy.txt", "", true)
    translation2 = Translation.new("braille_dummy.txt", "", false)

    expected = ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0..", ".0000.", "0.00..", ".00...", ".00.0.", "......", ".00...", ".00.0.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."]

    assert_equal expected, translation.translate

    expected = ["d","b"]

    assert_equal expected, translation2.translate
  end

  def test_it_can_combine_english
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.stubs(:characters).returns(["true"])
    translation = Translation.new("", "", true)

    expected = "hi"

    assert_equal expected, translation.combine_english(["h", "i"])
  end

  def test_it_can_combine_braille
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.stubs(:characters).returns(["true"])
    translation = Translation.new("", "", true)

    characters = ["00..00", "00..00"]
    expected = ["0000", "....", "0000"]

    assert_equal expected, translation.combine_braille(characters)
  end

  def test_it_can_stage_braille
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.stubs(:characters).returns(["true"])
    translation = Translation.new("", "", true)

    characters = ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0..", ".0000.", "0.00..", ".00...", ".00.0.", "......", ".00...", ".00.0.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."]
    expected = [["0.", "0.", "0.", "0.", "0.", "..", ".0", "0.", "0.", "0.", "00", ".0", "0.", ".0", ".0", "..", ".0", ".0", "..", ".0", "0.", "0.", "0.", "00"],
    ["00", ".0", "0.", "0.", ".0", "..", "00", ".0", "00", "0.", ".0", "00", "00", "0.", "0.", "..", "0.", "0.", "..", "00", ".0", "00", "0.", ".0"],
    ["..", "..", "0.", "0.", "0.", "..", ".0", "0.", "0.", "0.", "..", "0.", "..", "..", "0.", "..", "..", "0.", "..", ".0", "0.", "0.", "0.", ".."]]

    assert_equal expected, translation.stage_braille(characters)
  end

  def test_it_can_make_sure_braille_horizontally_stops_at_80
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.stubs(:characters).returns(["true"])
    translation = Translation.new("", "", true)

    characters = ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0..", ".0000.", "0.00..", ".00...", ".00.0.", "......", ".00...", ".00.0.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."]
    expected = [["0.", "0.", "0.", "0.", "0.", "..", ".0", "0.", "0.", "0.", "00", ".0", "0.", ".0", ".0", "..", ".0", ".0", "..", ".0", "0.", "0.", "0.", "00"],
    ["00", ".0", "0.", "0.", ".0", "..", "00", ".0", "00", "0.", ".0", "00", "00", "0.", "0.", "..", "0.", "0.", "..", "00", ".0", "00", "0.", ".0"],
    ["..", "..", "0.", "0.", "0.", "..", ".0", "0.", "0.", "0.", "..", "0.", "..", "..", "0.", "..", "..", "0.", "..", ".0", "0.", "0.", "0.", ".."]]

    assert_equal expected, translation.stage_braille(characters)

  end

  def test_it_can_do_the_whole_shebang
    translation = Translation.new("dummy.txt", "dummy_writer_test.txt", true)
    translation2 = Translation.new("braille_dummy.txt", "dummy_test_test.txt", false)

    translation.whole_shebang
    assert File.exist?("./data/dummy_writer_test.txt")
    translation2.whole_shebang
    assert File.exist?("./data/dummy_test_test.txt")

  end

  def test_it_can_stage_english
    reader = mock()
    Reader.expects(:new).returns(reader)
    reader.stubs(:characters).returns(["true"])
    translation = Translation.new("", "", true)

    assert_equal [["hello"]], translation.stage_english(["hello"])
  end
end