#!/usr/bin/env ruby

require 'awesome_print'

class Experiment

  def self.default_args(a,b=a)
    {
      a: a,
      b: b,
    }
  end

end

Experiment.default_args 'setting a only' # => {:a=>"setting a only", :b=>"setting a only"}

Experiment.default_args 'setting a', 'and b' # => {:a=>"setting a", :b=>"and b"}

