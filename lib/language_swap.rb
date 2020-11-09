class LanguageSwap
  attr_reader :translation
  def initialize(words, english)
    @braille_chart = { 
      'a' => '0.....',
      'b' => '0.0...',
      'c' => '00....',
      'd' => '00.0..',
      'e' => '0..0..',
      'f' => '000...',
      'g' => '0000..',
      'h' => '0.00..',
      'i' => '.00...',
      'j' => '.000..',
      'k' => '0...0.',
      'l' => '0.0.0.',
      'm' => '00..0.',
      'n' => '00.00.',
      'o' => '0..00.',
      'p' => '000.0.',
      'q' => '00000.',
      'r' => '0.000.',
      's' => '.00.0.',
      't' => '.0000.',
      'u' => '0...00',
      'v' => '0.0.00',
      'w' => '.000.0',
      'x' => '00..00',
      'y' => '00.000',
      'z' => '0..000',
      ' ' => '......',
      '$$$' => '.....0'
    }
    @english = english
    @translation = swap_characters(words)
  end

  def swap_characters(words)
    words.map! do |letter|
      swap_character(letter)
    end
    check_to_capitalize(words)
  end

  def check_to_capitalize(words)
    ticker = 0
    capitalized = []
    words.each do |character|
      if character == "$$$"
        ticker += 1
      elsif ticker >= 1
        ticker -= 1
        capitalized << character.upcase
      else
        capitalized << character
      end
    end
    capitalized
  end

  def swap_character(letter)
    if @english
      @braille_chart.fetch(letter)
    else
      @braille_chart.invert.fetch(letter)
    end
  end
end