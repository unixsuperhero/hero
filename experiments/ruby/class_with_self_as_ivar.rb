#!/usr/bin/env ruby

require 'awesome_print'

class Hero
  def initialize(v)
    @v = v                             # =>
  end

  def self
    @v                                 # =>
  end
end

test = Hero.new 'hello world'          # =>

ap test: test, raw: true, index: false # =>

