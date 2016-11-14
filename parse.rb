require 'yaml'
require 'json'
require 'ostruct'

yaml = Psych.load_stream(open('def.yml'))
profile = 'production'

class DeepStruct < OpenStruct
  def initialize(hash=nil)
    @table = {}
    @hash_table = {}

    if hash
      hash.each do |k,v|
        @table[k.to_sym] = (v.is_a?(Hash) ? self.class.new(v) : v)
        @hash_table[k.to_sym] = v

        new_ostruct_member(k)
      end
    end
  end

  def to_h
    @hash_table
  end

end

l = yaml.length
i = 0
while i < l
    if yaml[i]['profile'] == 'default'
        h1 = yaml[i]
        #h1 = DeepStruct.new h1
        h1 = h1.to_json
        h1 = JSON.parse(h1, object_class: OpenStruct)
    end
    if yaml[i]['profile'] == profile
        h2 = yaml[i]
        #h2 = DeepStruct.new h2
        h2 = h2.to_json
        h2 = JSON.parse(h2, object_class: OpenStruct)
    end
    i += 1
end
#puts h2
#puts h1.spec.containers[0].env.eql?(h2.spec.containers[0].env)

h1.spec.containers[0].env = h2.spec.containers[0].env if h1.spec.containers[0].env.eql?(h2.spec.containers[0].env) == false
#puts h2.spec.containers[0].env

puts h1
#h1.spec.containers[0]['name'] = h2.spec.containers[0].['name'] if h1.spec.containers[0].['name'].eql?(h2.spec.containers[0].['name']) == false
#h1.delete(h1.profile)
#puts h1.to_h
