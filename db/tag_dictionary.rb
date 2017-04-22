require "related_word"
# require "byebug"

class TagDictionary

	attr_reader :dictionary

	def initialize
		@word_finder = RelatedWord.new
		if File.file?("db/seeds/dictionary_json.txt")
			@dictionary = JSON.parse(File.open("db/seeds/dictionary_json.txt").read)
			@dictionary = {} if @dictionary.empty?
		else
			@dictionary = {}
		end

		generate_dictionary if @dictionary == {}

	end

	private

	def generate_dictionary
		File.open("db/seeds/tags.txt").each do |tag|
			tag = tag.gsub("\t", "")
			tag = tag.gsub("\n", "")
			self.populate(tag)
		end
	end

	def populate(word)
		word_list = @word_finder.find(word)
		word_list = word_list.map { |line| line[:word].downcase}
		@dictionary[word.downcase] = word_list.uniq
	end

end

# Wordnik.configure do |config|
# 	config.api_key = '5c43d251812f5d116dd5d0df80c0ab2fb760fea7b03af5557'
# end
#
#
# puts Wordnik.word.get_related('sports', :type => 'hypernym', :use_canonical => true)
# #
# td = TagDictionary.new
# #
# #
# File.open("seeds/tags.txt").each do |tag|
# 	tag = tag.gsub("\t", "")
# 	tag = tag.gsub("\n", "")
# 	td.populate(tag)
# end
#
# output = File.open( "seeds/dictionary_json.txt","w" )
# output.write(td.dictionary.to_json)
# output.close
