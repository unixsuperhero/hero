#!/usr/bin/env ruby

require 'awesome_print'

module H
  extend self

  def test #(args=ARGV.dup)
    s = '#one #two #three doesnot#count me n#either #four'
    matches = { # !> assigned but unused variable - matches
      encapsulated: s.scan(/(?<=(?<!\S)#)\w+/),
      back2back: s.scan(/(?<!\S)(?<=#)\w+/),
    }
  end
end

puts H.test.ai(raw: true, plain: false, index: false) # => nil
# ap H.test ARGV.clone

# >> {
# >>     :encapsulated => [
# >>         "one",
# >>         "two",
# >>         "three",
# >>         "four"
# >>     ],
# >>        :back2back => []
# >> }
