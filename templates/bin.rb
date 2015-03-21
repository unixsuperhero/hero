#!/usr/bin/env ruby

require 'awesome_print'
require 'optparse'
require 'mash'

module H
  class BaseSubCommand
    class << self
      def command_matches?(cmd=ARGV.clone.shift)
        matching_names.include? cmd
      end

      def matching_names # sub-command names and the acceptable aliases
        %w{ examples e ex example }
      end

      def run(args=ARGV.clone)
        new(args).run
      end
    end

    attr_accessor :args, :options
    def initialize(args=ARGV.clone)
      @args = args
      @options = Mash.new

      parse_options
    end

    def parse_options
      args.options do |opts|
        opts.on('-n', '--name=NAME', 'set the name') do |name|
          options.name = name
        end
      end
    end

    def run
      "running the #{self.class.name} command"
    end
  end

  module BinNameHere
    class Add < H::BaseSubCommand
      class << self
        def matching_names # sub-command names and the acceptable aliases
          %w{ new n create c add a }
        end
      end
    end

    class Remove < H::BaseSubCommand
      class << self
        def matching_names # sub-command names and the acceptable aliases
          %w{ remove rm r delete del d }
        end
      end
    end
  end


  class << self
    def run(args=ARGV.dup)
      subcmd = args.shift

      handler = handlers.find do |cmdhandler|
        cmdhandler.command_matches?(subcmd)
      end

      return 'command not found' if handler == nil

      handler.run(args)
    end

    def handlers
      BinNameHere.constants.map do |subcmd|
        BinNameHere.const_get(subcmd)
      end
    end
  end
end

ap H.run

__END__




:/__END__/+1 r!ruby templates/bin.rb add -n josh; echo; echo
:/__END__/+1 r!ruby templates/bin.rb a -n josh; echo; echo
:/__END__/+1 r!ruby templates/bin.rb remove -n josh; echo; echo
:/__END__/+1 r!ruby templates/bin.rb rm -n josh; echo; echo
:/__END__/+1 r!ruby templates/bin.rb sub_command_not_found -n josh; echo; echo

