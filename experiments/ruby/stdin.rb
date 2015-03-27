#!/usr/bin/env ruby

require 'awesome_print'

module H
  extend self

  def test(args=ARGV.dup)
    [args].push(IO.new(IO.sysopen('experiments/ruby/stdin.rb'))).map do |a|
      [:class, :any?, :count, :none?].map(&a.method(:send))
    end
  end
end

puts H.test($stdin).ai(raw: true, plain: false, index: false) # => nil
# ap H.test ARGV.clone

# >> [
# >>     [
# >>         IO < Object,
# >>         false,
# >>         0,
# >>         true
# >>     ],
# >>     [
# >>         IO < Object,
# >>         true,
# >>         18,
# >>         true
# >>     ]
# >> ]
