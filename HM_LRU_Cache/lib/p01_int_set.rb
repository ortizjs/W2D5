class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max)
  end

  def insert(num)
    raise "Out of bounds" if num > @max || num < 0
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return true if @store[num] == true
    false
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    i = num % @store.length
    @store[i] = num
  end

  def remove(num)
    @store.each do |bucket|
      if bucket == num
        @store.delete(num)
        # bucket.delete(num)
      end
    end
  end

  def include?(num)
    @store.each do |bucket|
      return true if bucket == num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num) 
      self[num] << num
      @count += 1
    end
    
    if @count > num_buckets
      resize!
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    i = num % num_buckets
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
        i = el % new_store.length
        new_store[i] << el
      end
    end
    
    @store = new_store
  end
end
