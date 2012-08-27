#!/usr/bin/env ruby

class Tree
  attr_accessor :children, :node_name
  
  def initialize(tree={})
    if tree.one?
      tree.each_pair do |key, value|
        @node_name = key
        @children = []
        value.each_pair do |sub_key, sub_value|
          @children.push Tree.new({sub_key, sub_value})
        end
      end
    end
    return self
  end

  def visit_all(&block)
    visit(&block)
    @children.each {|c| c.visit_all(&block)}
  end

  def visit(&block)
    block.call self
  end
end

tree = Tree.new({'grandpa' => {'dad' => {'child 1' => {}, 'child 2' => {}}, 'uncle' => {'chile 3' => {}, 'chile 4' =>{}}}})
tree.visit_all {|node| puts node.node_name}
