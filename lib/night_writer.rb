require './lib/translation'
require './lib/reader'
require './lib/writer'
require './lib/language_swap'

translation = Translation.new(ARGV[0], ARGV[1])
translation.whole_shebang

puts "Created '#{ARGV[1]}' containing #{translation.characters} characters"