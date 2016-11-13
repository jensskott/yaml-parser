require 'yaml'
require 'json'
require 'deep_merge'

yaml = Psych.load_stream(open('def.yml'))
profile = 'develop'

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

h3 = h1.merge!(h2)
h3.delete('profile')
puts JSON.pretty_generate(h3)
