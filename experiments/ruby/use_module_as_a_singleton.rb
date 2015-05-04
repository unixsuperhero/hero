#!/usr/bin/env ruby

require 'awesome_print'

module H
  extend self

  attr_accessor :frog

  def set_frog
    @frog = :froggie
  end

  def test(args=ARGV.clone, inp=$stdin, out=$stdout)
    set_frog

    ap using_the_frog_accessor: frog
    frog
  end

  def is_frog_still_set?
    frog
  end
end

H.test # => :froggie
H.is_frog_still_set? # => :froggie

# >> {
# >>     :using_the_frog_accessor => :froggie
# >> }
