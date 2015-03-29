#!/usr/bin/env ruby

require 'awesome_print'

module H
  extend self

  def test(args=ARGV.clone, inp=$stdin, out=$stdout)
    if out.tty?
      puts "output is tty; " * 200
    else
      puts "output is NOT tty."
    end
  end
end

H.test # => nil

# >> output is NOT tty.

__END__

ruby ~/repos/hero/experiments/ruby/stdout_tty.rb

ruby ~/repos/hero/experiments/ruby/stdout_tty.rb | cat -n

ruby ~/repos/hero/experiments/ruby/stdout_tty.rb | vim -

