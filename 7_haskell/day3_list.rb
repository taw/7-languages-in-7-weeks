#!/usr/bin/env ruby

require "pp"

class Monad
  def self.perform(&blk)
    new.instance_eval(&blk)
  end
end

class ArrayMonad < Monad
  def pass(x)
    [x]
  end
  
  def bind(v)
    v.map{|vi| yield(vi)}.inject([], &:+)
  end
end

class Maze
  def initialize(nodes)
    @nodes = nodes
  end
  def neighbours(node)
    x,y = node
    @nodes.select{|xi,yi|
      (x-xi).between?(-1,1) and (y-yi).between?(-1,1) and (x-xi)*(y-yi) == 0 and [x,y] != [xi,yi]
    }
  end
  def without(node)
    Maze.new(@nodes - [node])
  end
  def find_paths(node_start, node_end)
    m = self
    ArrayMonad.perform{
      if node_start == node_end
        pass([node_start])
      else
        bind(m.neighbours(node_start)){|node_mid|
          bind(m.without(node_start).find_paths(node_mid, node_end)){|path|
            pass([node_start, *path])
          }
        }
      end
    }
  end
end

maze = Maze.new([[1,1], [1,2], [1,3], [2,1], [3,1], [3,2], [3,3], [3,4], [3,5], [2,5], [1,5], [1,6], [1,7], [3,6], [3,7], [2,7]])

puts "Paths from (1,1) to (1,7)"
puts maze.find_paths([1,1], [1,7]).map(&:inspect)
puts ""
puts "Paths from (1,1) to (3,7)"
puts maze.find_paths([1,1], [3,7]).map(&:inspect)
