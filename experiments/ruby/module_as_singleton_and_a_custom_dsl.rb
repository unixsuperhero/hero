#!/usr/bin/env ruby

require 'awesome_print'

require 'optparse'
require 'ostruct'
require 'mash'
require 'singleton'

module MainCommand
  extend self

  attr_accessor :args, :stdinput, :stdoutput
  def run(args=ARGV.clone, inp=$stdin, out=$stdout)
    @args, @stdinput, @stdoutput = args, inp, out

    parse_options

    if options.show_help
      return args.options
    end
  end

  def adapters
    @adapters ||= {}.to_mash
  end

  def register_adapter(id, kls)
    adapters.merge! id => kls
  end

  def parse_options
    args.options { |opts|
      opts.on('-h', '--help', 'print this message') do
        options.show_help = true
      end
    }.parse!
  end

  def options
    @options ||= OpenStruct.new.tap do |opts|
      # default options go here
      # or pass them to #new as a hash

      opts.show_help = false
    end
  end

  # ...helper methods go here...

end

class TestA
  extend MainCommand
  register_adapter :test_a, self

  class << self
    def assert message='registering :test_a as an adapter'
      if MainCommand.adapters[:test_a] == self
        sprintf 'PASS:%s: %s', self.name, message
      else
        sprintf 'FAIL:%s: %s', self.name, message
      end
    end
  end
end

class TestB
  MainCommand.register_adapter :test_b, self

  class << self
    def assert message='registering :test_b as an adapter'
      if MainCommand.adapters[:test_b] == self
        sprintf 'PASS:%s: %s', self.name, message
      else
        sprintf 'FAIL:%s: %s', self.name, message
      end
    end
  end
end

class TestC
  include MainCommand
  register_adapter :test_c, self rescue nil

  class << self
    def assert message='registering :test_c as an adapter'
      if MainCommand.adapters[:test_c] == self
        sprintf 'PASS:%s: %s', self.name, message
      else
        sprintf 'FAIL:%s: %s', self.name, message
      end
    end
  end
end

class SingletonCommand
  include Singleton

  class << self
    def register_adapter(id, kls)
      adapters.merge! id => kls
    end

    def adapters
      instance.adapters
    end
  end

  def adapters
    @adapters ||= {}.to_mash
  end
end

class BaseAdapter
  class << self
    def register(name)
      SingletonCommand.register_adapter name, self
    end
  end
end

class TestD < BaseAdapter
  register :test_d

  class << self
    def assert message='registering :test_d as an adapter'
      if SingletonCommand.adapters[:test_d] == self
        sprintf 'PASS:%s: %s', name, message
      else
        sprintf 'FAIL:%s: %s (%s)', name, message
      end
    end
  end
end

module Tests
  extend self

  def run
    tests.each do |kls|
      results[kls] = kls.assert
    end

    print_report
  end

  def tests
    [
      TestA,
      TestB,
      TestC,
      TestD,
    ]
  end

  def results
    @results ||= {}.to_mash
  end

  def print_report
    puts
    puts 'Results'
    puts 'Results'.gsub(/./, ?-)
    puts
    tests.each{|t| puts results[t] }
    puts
    puts 'Conclusion'
    puts 'Conclusion'.gsub(/./, ?-)
    puts
    puts conclusion
    puts
  end

  def conclusion
    <<-CONCLUSION
      If TestD passed, that is the preferred method.
    However, TestD does not use a module, thus the original
    hypothesis/goal was incorrect. Yet, a clean pattern was
    still identified, so on the other hand this experiment
    was a success.
    CONCLUSION
  end
end

Tests.run

# >>
# >> Results
# >> -------
# >>
# >> FAIL:TestA: registering :test_a as an adapter
# >> PASS:TestB: registering :test_b as an adapter
# >> FAIL:TestC: registering :test_c as an adapter
# >> PASS:TestD: registering :test_d as an adapter
# >>
# >> Conclusion
# >> ----------
# >>
# >>       If TestD passed, that is the preferred method.
# >>     However, TestD does not use a module, thus the original
# >>     hypothesis/goal was incorrect. Yet, a clean pattern was
# >>     still identified, so on the other hand this experiment
# >>     was a success.
# >>

