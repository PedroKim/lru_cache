class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    val = 0
    self.each_with_index { |el, idx| val += el.hash ^ idx.hash }
    val
  end
end

class String
  def hash
    chars = self.split('').map(&:ord)
    chars.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end