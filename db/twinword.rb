require 'unirest'
# These code snippets use an open-source library. http://unirest.io/ruby
class TwinWord

	def find(text)
		response = Unirest.post "https://twinword-topic-tagging.p.mashape.com/generate/",
		headers:{
			"X-Mashape-Key" => "Hnznd4D41jmshPeLT467pQmsKg3qp1p925KjsnZjLxFifDmpmV",
			"Content-Type" => "application/x-www-form-urlencoded",
			"Accept" => "application/json"
		},
		parameters:{
			"text" => text
		}
		json = JSON.parse(response.raw_body)
		if json["keyword"]
			return keywords = json["keyword"].keys
		else
			return nil
		end
	end

end

# tw = TwinWord.new
#
# text = "\n\nInternationally-acclaimed Jewish feminist artist Helène Aylon presents her conclusion to The G-d Project: Nine Hous
# es Without Women, her 20-year series highlighting the dismissal of women in Jewish traditions and text. In Afterword: Fo
# r the Children, Aylon dedicates her finale in the series to the future generations, challenging all who regard The Ten C
# ommandments not to shrug off a dark foreboding which emanates in her view, from the patriarchy - not from God.\n\n The t
# ext of the Second Commandment holds future generations responsible for the sins of their fathers. The artist’s examinati
# on of this text reveals a universal dilemma through its connection to contemporary policies and practices that shape the
#  world our children will inherit. The concept of “Tikkun Olam” (correction of the world) holds significance in Aylon’s i
# mmersive digital installation, as her continuous attempt at “repairing” the revered text becomes​ a​ quiet yet assertive
#  protest. \n\nLocation: Epstein\nRoom: Kniznick Gallery \nEvent sponsor(s): Hadassah-Brandeis Institute \n\n"
#
#
# puts keywords
