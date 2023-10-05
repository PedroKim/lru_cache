class MaxIntSet
  attr_reader :store

  def initialize(max)
    @max = max
    @store = Array.new(max)
  end

  def [](num)
    validate!(num)
    idx = num % @max
    @store[idx]
  end

  def []=(num, val)
    validate!(num)
    idx = num % @max
    @store[idx] = val
  end

  def insert(num)
    self[num] = true
  end

  def remove(num)
    self[num] = false
  end

  def include?(num)
    self[num]
  end

  private

  def is_valid?(num)
    num < @max && num >= 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
  end

  def remove(num)
  end

  def include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    idx = num % num_buckets
    @store[idx]
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
  end

  def remove(num)
  end

  def include?(num)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end
end