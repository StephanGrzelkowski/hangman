class HangmanAi
	attr_accessor :secret_word, :known, :questioned

	def initialize()
		@secret_word = HangmanAi.get_word()
		@tries = 6 
		@known = []
		@secret_word.length.times do 
			@known << "_"
		end
		@questioned = []
	end 

	def HangmanAi.get_word()
		words = []
		File.open("5desk.txt",'r').each_line do |word|
			words << word.strip if (word.strip.length > 4 && word.strip.length < 12)
		end
		rand_select = rand(words.length).to_i
		secret_word = words[rand_select]
	end	

	def display_man()
		puts @known
		if !(@known.include?("_"))
			puts "You did it. You got all the letters?" 
			return true
		end
		puts "You have got #{@tries} tries left"
		return false
	end

	def update_known(letter) 
		if @questioned.include?(letter)
			puts "You have already tried this letter!"
			@tries

		elsif @secret_word.include?(letter) 
			i = 0
			@secret_word.scan(/./) do |l|
				if letter === l
					@known[i] = letter
				end
				i += 1
			end
			puts "Yes you have got one"

		else 
			puts "Nope, that's not in there"
			@questioned << letter
			@tries -= 1
		end
	end

	def get_input()
		puts("Which letter do you want to try?")
		letter = gets.strip
	end
end

game = HangmanAi.new	
finished = false 
while !finished
	game.display_man
	letter = game.get_input
	game.update_known(letter) 
	finished = game.display_man
end