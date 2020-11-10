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
      '$$$' => '.....0',
      '!' => '..000.',
      "'" => '....0.',
      ',' => '..0...',
      '-' => '....00',
      '.' => '..00.0',
      '?' => '..0.00',
      '###' => '.0.000'
    }
    @num_chart = {
      'a' => '1',
      'b' => '2',
      'c' => '3',
      'd' => '4',
      'e' => '5',
      'f' => '6',
      'g' => '7',
      'h' => '8',
      'i' => '9',
      'j' => '0'
    }
    @english = english
    @translation = swap_characters(words)
  end

  def swap_characters(words)
    words = add_number_switch(words)
    words = check_to_capitalize_braille(words)
    words.map! do |letter|
      swap_character(letter)
    end
    words = check_to_capitalize(words)
    check_to_numberfy(words)
  end

  def check_to_capitalize_braille(words)
    words.map do |character|
      if character != character.downcase
        ["$$$", character.downcase]
      else
        character
      end
    end.flatten
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

  def check_to_numberfy(words)
    number = false
    numbered = []
    words.each do |character|
      if character == "###"
        number = true
      elsif character == " "
        number = false
        numbered << character
      elsif number
        numbered << @num_chart.fetch(character)
      else
        numbered << character
      end
    end
    numbered
  end

  def add_number_switch(words)
    switched = []
    numbers = 0
    words.each do |character|
      if @num_chart.invert.include?(character)
        numbers += 1
      else
        numbers = 0
      end
      if numbers == 0
        switched << character
      elsif numbers == 1
        character = @num_chart.invert.fetch(character)
        switched << ["###", character]
      else
        switched << @num_chart.invert.fetch(character)
      end
    end
    switched.flatten
  end
end