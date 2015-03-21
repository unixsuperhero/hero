#!/usr/bin/env ruby

require 'awesome_print'


=begin

write a method for each possible solution, then benchmark them

get the length of smallest string and use that as the first max len
grab the len of 2 strings being compared and grab the smaller length


1. loop thru char x char and break at the first difference
2. loop from max_possible_len to 0, compare whole string
   a.slice(0,len) == b.slice(0,len)
3. when comparing 2, make an array of all possible slices,
   sort by len desc...then use #find to grab the longest one

=end

module CompareStrings
  extend self

  def longest_common_prefix(list)
    first = list.first
    list.inject(first) do |base,str|
      max = [base.length, str.length].min
      maxlen = max.downto(0).to_a.find{|x| base.slice(0,x) == str.slice(0,x) }
      base.slice(0,maxlen)
    end
  end
end

ap CompareStrings.longest_common_prefix(Dir['/Applications/Google Chrome.app/**/*'])

