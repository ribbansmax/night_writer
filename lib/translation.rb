class Translation
  attr_reader :destination, :reader
  def initialize(origin, destination)
    @destination = destination
    @reader = Reader.new(origin)
  end

  def is_english?
    line = reader.first_line
    line.gsub(/[0.]/, '') != ""
  end

  def characters
    reader.characters
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
    times = lines.length / 3
    braille = []
    ticker = 0
    while ticker < times do
      num_chars = lines[(ticker +1) * 3 -1].length / 2
      characters = 0
      until num_chars == 0 do
        braille[characters] = []
        line_num = 0
        3.times do
          braille[characters] << lines[line_num].slice!(0..1)
          line_num += 1
        end
        braille[characters] = braille[characters].join
        characters += 1
        num_chars -=1
      end
      ticker += 1
    end
    braille
  end

  def translate
    if is_english?
      language = LanguageSwap.new(split_english, true)
      language.translation
    else
      language = LanguageSwap.new(split_braille, false)
      language.translation
    end
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
    characters.each_slice(3) do |three_lines|
      until three_lines[0].empty? do
        staged_braille << three_lines[0].slice!(0..79)
        staged_braille << three_lines[1].slice!(0..79)
        staged_braille << three_lines[2].slice!(0..79)
      end
    end
    staged_braille
  end
end