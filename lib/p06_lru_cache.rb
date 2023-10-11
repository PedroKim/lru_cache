require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

# LRU - Least Recently Used
# - a cache of the n most-recently-used items.
# - if something doesn't get looked at often enough, you trash it.

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      old_node = @map[key]
      node = update_node!(old_node)
    else
      eject! if @max <= @store.count
      val = calc!(key)
      node = @store.append(key, val)
    end
    @map[key] = node
    node.val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.remove(node.key)
    @store.append(node.key, node.val)
  end

  def eject!
    removal_node = @store.first
    @map.delete(removal_node.key)
    @store.remove(removal_node.key)
  end
end