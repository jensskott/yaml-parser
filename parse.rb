require 'yaml'
yaml = Psych.load_stream(open('def.yml'))
profile = 'production'

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
h1.merge!(h2)
h1.delete('profile')
puts h1
