require 'yaml'
require 'json'

yaml = Psych.load_stream(open('def.yml'))
profile = 'production'

class ::Hash
    def deep_merge(second)
        merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : Array === v1 && Array === v2 ? v1 | v2 : [:undefined, nil, :nil].include?(v2) ? v1 : v2 }
        self.merge(second.to_h, &merger)
    end
end

l = yaml.length
i = 0
while i < l  do
   if yaml[i]['profile'] == 'default'
      h1 = yaml[i]
   end
   if yaml[i]['profile'] == profile
      h2 = yaml[i]
   end
   i +=1
end

h3 = h2.deep_merge(h1)
#h1.merge!(h2)
#h3.delete('profile')
puts JSON.pretty_generate(h3)
