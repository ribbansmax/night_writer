require './lib/translator'

translation = Translator.new(ARGV[0], ARGV[1])

puts "Created '#{ARGV[1]}' containing #{translation.characters} characters"