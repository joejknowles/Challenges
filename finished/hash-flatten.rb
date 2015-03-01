class Hash
  def flattened_keys
    to_be_added = []
    to_be_removed = []
    self.each do |k1, v1|
      if v1.class == Hash
        v1.each do |k2, v2|
          to_be_added.push(k1.class == String || k2.class ==String ? "#{k1}_#{k2}" : "#{k1}_#{k2}".to_sym)
          to_be_added.push(v2)
          to_be_removed.push(k1)
        end
      end
    end
    #Need to keep adding until nothing left to be added
    while to_be_added.length>0
      self[to_be_added.shift]=to_be_added.shift
    end
    #Need to keep deleting until nothing left to be removed
    (0...to_be_removed.length).each do |i|
      self.delete(to_be_removed[i])
    end
    again=false
    self.each do |key, value|
      if value.class == Hash
        again = true
      end
    end
    if again
      self.flattened_keys
    end
    return self
  end
end




deep_hash = {id: 1, info: {name: {blah: {'bee' => 'example'}, blum: {pee: 'pee'}}}, another: 'one', to_be: {done: 'YAY'}}
puts deep_hash.flatten
{id: 1, info: {name: 'example'}}.flatten