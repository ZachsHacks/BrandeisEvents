require 'engtagger'

class Method

end

string = "The rain in spain flies mainly down the plane."

tgr = EngTagger.new

tagged = tgr.get_nouns(string)

p tagged
