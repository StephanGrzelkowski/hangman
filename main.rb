load 'lib/hangman_ai.rb'
load 'lib/hangman_setup.rb'


secret_word, known, questioned, tries = HangmanSetup.load_or_new()

game = HangmanAi.new(secret_word, known, questioned, tries)	

puts "\nIf you wish to save at any point just type \'save\'"
#show initial length
game.display_man

#game loop
finished = false
while !finished
	letter = game.get_input
	game.update_known(letter) 
	finished = game.display_man
end