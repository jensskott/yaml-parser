require 'yaml'
require 'recursive-open-struct'

yaml = Psych.load_stream(open('def.yml'))
profile = 'production'

l = yaml.length
i = 0
while i < l
  if yaml[i]['profile'] == 'default'
    h1 = yaml[i]
    h1 = RecursiveOpenStruct.new(h1, recurse_over_arrays: true)
  end
  if yaml[i]['profile'] == profile
    h2 = yaml[i]
    h1 = RecursiveOpenStruct.new(h1, recurse_over_arrays: true)

  end
  i += 1
end

puts h1
# puts JSON.pretty_generate(json)
