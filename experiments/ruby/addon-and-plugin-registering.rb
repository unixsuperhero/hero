#!/usr/bin/env ruby

require 'awesome_print'

require 'optparse'
require 'ostruct'
require 'mash'
require 'singleton'


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

puts TestD.assert # => nil

# >> PASS:TestD: registering :test_d as an adapter
