#!/usr/bin/env ruby

require 'awesome_print'

module H
  extend self

  def test(args=ARGV.clone, inp=$stdin, out=$stdout)
    'this is where the test code goes'
  end
end

H.test # => "this is where the test code goes"

