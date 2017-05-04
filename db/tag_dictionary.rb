require "related_word"


class TagDictionary
	attr_reader :dictionary

	def initialize
		@word_finder = RelatedWord.new

		if File.file?("db/seeds/dictionary_json.txt") && !File.zero?("db/seeds/dictionary_json.txt")
			@dictionary = JSON.parse(File.open("db/seeds/dictionary_json.txt").read)
			@dictionary = {} if @dictionary.empty?
		else
			@dictionary = {}
		end

		generate_dictionary if @dictionary == {}
		write_to_file if File.file?("db/seeds/dictionary_json.txt") && File.zero?("db/seeds/dictionary_json.txt")

	end


	private

	def generate_dictionary
		File.open("db/seeds/tags.txt").each do |tag|
			tag = tag.gsub("\t", "")
			tag = tag.gsub("\n", "")
			tag = tag.split(":")
			populate(tag[0]) unless tag == "Other"
		end
	end

	def write_to_file

		output = File.open( "db/seeds/dictionary_json.txt","w" )
		output.write(@dictionary.to_json)
		output.close
	end

	def populate(word)
		word_list = @word_finder.find(word)
		word_list = word_list.map { |line| line[:word].downcase}
		word_list = word_list.map {|w| w.singularize}
		word_list.each do |w|
					@dictionary[w] = word.downcase
		end
		@dictionary[word.downcase] = word.downcase
	end

end
