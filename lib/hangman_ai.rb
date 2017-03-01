require 'yaml'

class HangmanAi
	attr_accessor :secret_word, :known, :questioned

	def initialize(secret_word, known, questioned, tries)
		#load save game or choose a new word
		@secret_word = secret_word
		@known = known
		@questioned = questioned
		@tries = tries
	end 

	
	def display_man()
		puts ("\n" + @known.join(" "))
		if !(@known.include?("_"))
			puts "\nYou did it. You got all the letters?" 
			return true
		end
		puts "\nYou have got #{@tries} tries left"
		return false
	end

	def update_known(letter) 
		if letter === "save"
			HangmanSetup.save_game(@secret_word, @known, @tries, @questioned)
		
		elsif @questioned.include?(letter)
			puts "\nYou have already tried this letter!"
			@tries

		elsif @secret_word.include?(letter) 
			#replace placeholders with each letter gotten right
			i = 0
			@secret_word.scan(/./) do |l|
				if letter === l
					@known[i] = letter
				end
				i += 1
			end
			puts "\nYes you have got one"
			@questioned << letter

		else 
			puts "\nNope, that's not in there"
			@questioned << letter
			@tries -= 1
		end

	end

	def get_input()
		puts("\nWhich letter do you want to try?")
		letter = gets.strip
		
	end
	
end