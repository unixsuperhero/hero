#!/usr/bin/env ruby

require 'awesome_print'

class String
  def split_unescaped(str, opts={}, &block)
    self.split(/(?<!\\)#{str}/).map do |s|
      s = s.gsub(/\\(?=#{str})/, '')
      s = s.sub(/^\s*/,'').sub(/\s*$/,'') if opts[:trim] == true
      s = block.call(s) if block != nil
      s
    end
  end
end
class World
  def self.task_path; '/tmp/tasks'; end
end

module F
  extend self

  def args(argv)
    argv.flatten
  end

  def multi(*argv)
    CliTasks::Commands.mcreate *args(argv)
  end
  def many(*argv)
    CliTasks::Commands.mcreate *args(argv)
  end
  def mcreate(*argv)
    ap function: :mcreate, argv: args(argv)
    CliTasks::Commands.mcreate *args(argv)
  end

  def create(*argv)
    ap function: :create, argv: args(argv)
    CliTasks::Commands.create *args(argv)
  end
  def new(*argv)
    CliTasks::Commands.create *args(argv)
  end
  def add(*argv)
    CliTasks::Commands.create *args(argv)
  end
  def c(*argv)
    CliTasks::Commands.create *args(argv)
  end
  def n(*argv)
    CliTasks::Commands.create *args(argv)
  end
  def a(*argv)
    CliTasks::Commands.create *args(argv)
  end

  def edit(*argv)
    ap function: :edit, argv: args(argv)
  end

  def search(*argv)
    if args(argv).any?{|arg| arg == '-e' }
      CliTasks::Commands.edit *args(argv).reject{|arg| arg == '-e' }
    else
      ap function: :search, argv: args(argv)
    end
  end

  def import(*argv)
    if args(argv).any?
      tasks = IO.read(argv[0]).split(/\s*\n+\s*/)
      CliTasks::Commands.mcreate *tasks
    else
      f = Tempfile.new('tasks')
      system ENV['EDITOR'] || 'vim', f.path
      tasks = IO.read(f.path).split(/\s*\n+\s*/)
      CliTasks::Commands.mcreate *tasks
    end
  end


end

module CliTasks
  class Commands
    class << self
      def edit(*args)
        edit_files grep(*args)
      end

      def edit_files(*files)
        ap files: files, ffiles: files.flatten
        system(ENV['EDITOR'] || 'vim', '-O', '+wincmd |', *files.flatten)
      end

      def search(*args)
        if (args[0] || '').strip =~ /-(s|-simple)/i
          puts grep(*args.tap(&:shift))
        else
          Viewer.print(*grep(*args))
        end
      end

      def next_filename(runs=0)
        timestamp = Time.now.strftime('%Y%m%d%H%M%S').to_i
        file = '%s/%s.rb' % [world.task_path, timestamp + runs]
        runs < 20 && File.exist?(file) ? next_filename(runs+1) : file
      end

      def write(file, taskname='TASK NAME GOES HERE')
        ap file: file, taskname: taskname
        FileUtils.mkdir_p(world.task_path)
        checklog("Creating '#{file}'"){ IO.write(file, template(taskname)) }
        file
      end

      def mcreate(*tasks)
        edit_files *(tasks.flat_map do|taskname|
          next_filename.tap do |fn|
            write fn, taskname
          end
        end)
      end

      def create(*args)
        name = args.join ' '
        names = split_unescaped(name, ?;, trim: true)
        mcreate *names
      end

      def rebuild
        LinkBuilder.all
      end

      def world
        @world ||= World
      end

      def stories
        world.stories
      end

      def list(*args)
        if args.any?
          Viewer.print *args
        else
          Viewer.print '%s/*' % world.task_path
        end
      end

      private

      def named_tags(name='')
        name.split_unescaped(?#, trim: true).tap(&:shift)
      end

      def grep(*args)
        args.inject([world.task_path]){|files,arg|
          #pp     "grep -ril '#{arg}' -- '#{files.join "' '"}'"
          grep = `grep -ril '#{arg}' -- '#{files.join "' '"}'`
          lines = grep.lines.map(&:chomp)
        }
      end

      def checklog(msg, &block)
        print "#{msg}..."
        block.call
        puts 'done'
      end

      def template(name='CHANGEME', tags=nil)
        tags ||= named_tags name
        data = <<-STORY
          story %q(#{name}) do
            status queued
            #restricted_to weekdays
            #restricted_to weekends

            tags '#{tags * ', '}'

            points 1
            created_by 'unassigned'
            assigned_to :unassigned

            description <<-"__TASK_DESCRIPTION__"

            __TASK_DESCRIPTION__
          end
        STORY
        pattern = data.scan(/\A(\s+)/).uniq.min_by{|s| s.length }.first
        data.gsub(/^#{pattern}/, '')
      end

      def split_unescaped(text, str, opts={}) # &block too
        text.split(/(?<!\\)#{str}/).map do |s|
          s = s.gsub(/\\(?=#{str})/, '')
          s = s.sub(/^\s*/,'').sub(/\s*$/,'') if opts[:trim] == true
          s = yield s if block_given?
          s
        end
      end
    end
  end
end

__END__
:19,70s/\v^\s*\zs(edit|edit_files|search|next_filename|write|mcreate|create|rebuild|world|stories|list|grep|checklog|template|split_unescaped)/CliTasks::Commands.\1/c

# vim: ft=ruby
