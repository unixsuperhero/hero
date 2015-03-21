#!/usr/bin/env ruby

require 'awesome_print'
require 'optparse'

module H
  extend self

  def test(args=ARGV)
    {
      responds_to_options: {
        original: ARGV.respond_to?(:options),
        original_via_method_param: args.clone.respond_to?(:options),
        cloned: args.clone.respond_to?(:options),
        duped: args.dup.respond_to?(:options),
      },
    }
  end
end

ap H.test ARGV # => {:responds_to_options=>{:original=>true, :original_via_method_param=>true, :cloned=>true, :duped=>false}}

ap H.test ARGV.clone # => {:responds_to_options=>{:original=>true, :original_via_method_param=>true, :cloned=>true, :duped=>false}}

# >> {
# >>     :responds_to_options => {
# >>                          :original => true,
# >>         :original_via_method_param => true,
# >>                            :cloned => true,
# >>                             :duped => false
# >>     }
# >> }
# >> {
# >>     :responds_to_options => {
# >>                          :original => true,
# >>         :original_via_method_param => true,
# >>                            :cloned => true,
# >>                             :duped => false
# >>     }
# >> }
