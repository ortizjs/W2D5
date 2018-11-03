class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key) 
      self[key.hash] << key
      @count += 1
    end
    
    if @count > num_buckets
      resize!
    end
    # new_key = key.hash
    # self[key] = true unless self.include?(key)
  end

  def include?(key)
    self[key.hash].include?(key)
    # self[key.hash] == true
    # @store.any? { |el| el.include?(key) }  
  end

  def remove(key)
    if include?(key)
      self[key.hash].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    i = num.hash % num_buckets
    @store[i]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    
    @store.each do |bucket|
      bucket.each do |el|
        i = el.hash % new_store.length
        new_store[i] << el
      end
    end
    
    @store = new_store
  end
end
