#!/usr/bin/env ruby

require 'awesome_print'

module H
  extend self

  def test(args=ARGV.dup)
    '..code goes here...'
  end
end

ap H.test ARGV.clone

