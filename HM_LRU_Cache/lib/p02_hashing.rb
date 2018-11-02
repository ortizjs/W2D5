require_relative "p01_int_set.rb"

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    new_arr = self.map.with_index {|el, i| el.object_id + i}
    new_arr.reduce(:*).hash
  end
end

class String
  def hash
    chars = self.split("")
    new_h = chars.map.with_index { |ch, idx| ch.ord + idx }
    new_h.reduce(:*).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    new_h = self.map do |k, v| 
      if v.is_a?(Array)
        v = v.map.with_index {|val, i| val.object_id * i}.reduce(:+)
      end
      k.object_id + v.ord
    end
      
    new_h.reduce(:*).hash
  end
end
