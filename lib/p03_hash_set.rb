class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    self[key] << key
    @count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].pop
      @count -= 1
    end
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    @count = 0
    elements = @store.flatten
    @store = Array.new(2 * num_buckets) { Array.new }
    elements.each { |el| insert(el) }
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end
end