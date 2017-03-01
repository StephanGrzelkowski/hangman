module HangmanSetup
	def self.load_or_new()
	puts "\nDo you want to load a recent game (type \"s\") or do you want to start a new one (type \"n\")?"
		o = gets.strip.downcase
		if o === "n"	
			secret_word = HangmanSetup.get_word()	
			known = []
			secret_word.length.times do 
				known << "_"
			end
			questioned = []	
			tries = 6

		elsif o === "s"
			data = load_game()
			secret_word = data[:secret_word]
			known = data[:known]
			tries = data[:tries]
			questioned = data[:questioned]

		end

		return secret_word, known, questioned, tries
	end

	def self.get_word() 
		#Loads in all words from 5desk.txt and chooses a random word with a lenght of 5 - 11 characters
		words = []
		File.open("lib/assets/5desk.txt",'r').each_line do |word|
			words << word.strip if (word.strip.length > 4 && word.strip.length < 12)
		end
		rand_select = rand(words.length).to_i
		@secret_word = words[rand_select]
		
	end	

	def self.load_game()
		t = File.open("lib/assets/hangman_save.txt","r") do |saveDat|
			data = YAML.load(saveDat)
		end
	end

	def self.save_game(secret_word, known, tries, questioned)		
		saveDat = {:secret_word => secret_word, :known => known, :tries => tries, :questioned => questioned} 
		
		t = File.open("lib/assets/hangman_save.txt","w")
		t.puts YAML.dump(saveDat)
		t.close
	end


end