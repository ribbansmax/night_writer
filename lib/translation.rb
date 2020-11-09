class Translation
  attr_reader :destination, :reader, :english, :characters
  def initialize(origin, destination)
    @destination = destination
    @reader = Reader.new(origin)
    @english = is_english?
    make_characters
  end

  def whole_shebang
    final_translation = translate
    if english
      final_translation = stage_braille(final_translation)
    else
      final_translation = stage_english(final_translation)
      @characters = final_translation[0].length
    end
    Writer.new(destination, final_translation)
  end

  def is_english?
    line = reader.first_line
    line.gsub(/[0.]/, '') != ""
  end

  def make_characters
    if english
      @characters = reader.characters
    end
  end

  def split_english
    lines = reader.lines
    english = []
    lines.each do |line|
      english << line.chars
    end
    english.flatten
  end

  def split_braille
    lines = reader.lines
    braille = []
    lines.each_slice(3) do |three_lines|
      temp = []
      until three_lines[0].empty? do
        temp << three_lines[0].slice!(0..1) + three_lines[1].slice!(0..1) + three_lines[2].slice!(0..1)
      end
      braille << temp
    end
    braille.flatten
  end

  def translate
    if english
      language = LanguageSwap.new(split_english, english)
    else
      language = LanguageSwap.new(split_braille, english)
    end
    language.translation
  end

  def combine_english(characters)
    characters.join
  end

  def combine_braille(characters)
    characters = characters.map do |character|
      [character[0..1], character[2..3], character[4..5]]
    end.transpose
    characters.map do |character|
      character.join
    end
  end

  def stage_braille(characters)
    staged_braille = []
    characters.map! do |character|
      [character[0..1], character[2..3], character[4..5]]
    end
    characters = characters.transpose
    characters.each_slice(3) do |three_lines|
      until three_lines[0].empty? do
        staged_braille << three_lines[0].slice!(0..39)
        staged_braille << three_lines[1].slice!(0..39)
        staged_braille << three_lines[2].slice!(0..39)
      end
    end
    staged_braille
  end

  def stage_english(characters)
    [characters]
  end
end