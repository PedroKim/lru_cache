require 'byebug'

class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_accessor :count
  
  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    i = count + i if i < 0
    return nil if i < 0
    @store[i]
  end

  def []=(i, val)
    i = count + i if i < 0
    resize! if i > capacity - 1
    @count += 1 if @store[i].nil?
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |val|
      return true if val == val
    end
    false
  end

  def push(val)
    resize! if count == capacity
    @store[count] = val
    @count += 1 unless val.nil?
  end

  def unshift(val)
    @count += 1
    resize! if count == capacity
    i = count - 1
    while i > 0
      @store[i] = @store[i - 1]
      i -= 1
    end
    @store[0] = val
  end

  def pop
    return nil if count == 0

    val = @store[count - 1]
    @store[count - 1] = nil
    @count -= 1

    return val
  end

  def shift
    return nil if count == 0
    val = @store[0]

    i = 1
    while i < capacity
      @store[i - 1] = @store[i]
      i += 1
    end

    @count -= 1 unless val.nil?
    @store[capacity - 1] = nil

    return val
  end

  def first
    self[0]
  end

  def last
    self[count - 1]
  end

  def each(&prc)
    i = 0
    while i < count
      prc.call(self[i])
      i += 1
    end
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    (0...capacity).each do |i|
      return false if self[i] != other[i]
    end

    true
  end

  alias_method :<<, :push
  %i(length size).each { |method| alias_method method, :count }

  private

  def resize!
    @count = 0
    elements = @store.store.dup
    @store = StaticArray.new(2 * capacity)
    (0...elements.length).each { |i| self[i] = elements[i] }
  end
end