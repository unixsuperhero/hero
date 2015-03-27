#!/usr/bin/env ruby

require 'awesome_print'

def index_glob(dir='')
  Dir["#{dir}*"].flat_map do |f|
    next [] if File.basename(f)[/^[.]/]
    children = []
    children = index_glob(f += ?/) if File.directory?(f)
    children.unshift(f)
  end
end

def index_glob_two(dir='')
  Dir["#{dir}*"].flat_map do |f|
    next [] if File.basename(f)[/^[.]/]
    if File.directory?(f)
      f += ?/
      ['', f] + index_glob(f)
    else
      f
    end
    # children = []
    # children = index_glob(f += ?/) if File.directory?(f)
    # children.unshift(f)
  end
end

      def index_glob_3(dir='')
        Dir["#{dir}*"].map do |f|
          next [] if File.basename(f)[/^[.]/]
          if File.directory?(f)
            f += ?/
            puts
            puts f
            index_glob(f)
          else
            puts f
          end
          f
          # children = []
          # children = index_glob(f += ?/) if File.directory?(f)
          # children.unshift(f)
        end
      end

puts Dir.pwd # => nil
puts Dir.chdir('%s/hero/notes' % ENV['HOME']) # => nil
# puts index_glob # => nil
# puts index_glob_two # => nil
# puts index_glob_3 # => nil

def dirglob(dir='')
  pattern = dir.sub(/\/+$/, ?/) + ?*
  files = []
  dirs = []
  Dir[pattern].flat_map do |f|
    if File.directory?(f)
      f = f.sub(/\/*$/, ?/)
      dirs += ['', f] + dirglob(f)
    else
      files << f
    end
  end
  files + dirs
end

puts Dir.pwd # => nil
Dir.chdir('/Users/macbookpro/repos/hnotes')
puts Dir.pwd # => nil
# globbed = Dir[pattern = '*'].map do |f|
#   [Dir.pwd, pattern, f]
# end

# puts dirglob.ai(plain: true, index: false, raw: false)
puts dirglob

__END__

# >> /Users/macbookpro/repos/hero/experiments/ruby
# >> 0
# >> /Users/macbookpro/hero/notes
# >> /Users/macbookpro/repos/hnotes
# >> clitasks.gemspec
# >> Gemfile
# >> Gemfile.lock
# >> LICENSE
# >> project.files
# >> Rakefile
# >> README.md
# >>
# >> bin/
# >> bin/note
# >> bin/task
# >>
# >> clitasks-stories/
# >> clitasks-stories/config.yml
# >>
# >> clitasks-stories/index/
# >> clitasks-stories/index/20140421005800.rb
# >> clitasks-stories/index/20140421010200.rb
# >> clitasks-stories/index/20140421010600.rb
# >> clitasks-stories/index/20140421020200.rb
# >> clitasks-stories/index/20140422232916.rb
# >> clitasks-stories/index/20140422233214.rb
# >> clitasks-stories/index/20140422233537.rb
# >> clitasks-stories/index/20140422233812.rb
# >> clitasks-stories/index/20140422234102.rb
# >> clitasks-stories/index/20140422234537.rb
# >> clitasks-stories/index/20140422235000.rb
# >> clitasks-stories/index/20140422235200.rb
# >> clitasks-stories/index/20140422235300.rb
# >> clitasks-stories/index/20140423000507.rb
# >> clitasks-stories/index/20140423000844.rb
# >> clitasks-stories/index/20140423001409.rb
# >> clitasks-stories/index/20140423002056.rb
# >> clitasks-stories/index/20140423003427.rb
# >> clitasks-stories/index/20140423003655.rb
# >> clitasks-stories/index/20140423004527.rb
# >> clitasks-stories/index/20140423010200.rb
# >> clitasks-stories/index/20140423010346.rb
# >> clitasks-stories/index/20140423011057.rb
# >> clitasks-stories/index/20140423011433.rb
# >> clitasks-stories/index/20140423011551.rb
# >> clitasks-stories/index/20140423011623.rb
# >> clitasks-stories/index/20140423012226.rb
# >> clitasks-stories/index/20140423012347.rb
# >> clitasks-stories/index/20140423012405.rb
# >> clitasks-stories/index/20140423012434.rb
# >> clitasks-stories/index/20140423024742.rb
# >> clitasks-stories/index/20140425102904.rb
# >> clitasks-stories/index/20140425191357.rb
# >> clitasks-stories/index/20140425191921.rb
# >> clitasks-stories/index/20140425201100.rb
# >> clitasks-stories/index/20140425205726.rb
# >> clitasks-stories/index/20140425212720.rb
# >> clitasks-stories/index/20140426183100.rb
# >> clitasks-stories/index/20140508144511.rb
# >> clitasks-stories/index/20140508144606.rb
# >> clitasks-stories/index/20140509013250.rb
# >> clitasks-stories/index/20140524235849.rb
# >>
# >> doc/
# >> doc/docformattest.hero
# >> doc/fulcrum-features.pdf
# >> doc/kanban - agile methodology.pdf
# >> doc/web-based-competitors
# >> doc/write-your-own-gemspec.pdf
# >>
# >> examples/
# >> examples/first_story.rb
# >> examples/second_story.rb
# >>
# >> lib/
# >> lib/clitasks.rb
# >>
# >> lib/clitasks/
# >> lib/clitasks/commands.rb
# >> lib/clitasks/configuration.rb
# >> lib/clitasks/link_builder.rb
# >> lib/clitasks/note.rb
# >> lib/clitasks/runner.rb
# >> lib/clitasks/simple_dsl.rb
# >> lib/clitasks/split_on_unescaped.rb
# >> lib/clitasks/story.rb
# >> lib/clitasks/story_reader.rb
# >> lib/clitasks/version.rb
# >> lib/clitasks/viewer.rb
# >> lib/clitasks/world.rb
# >>
# >> notes/
# >>
# >> pv/
# >>
# >> test/
# >> test/test_helper.rb
# >>
# >> test/unit/
# >> test/unit/link_builder_test.rb
# >>
# >> test/unit/lib/
# >>
# >> test/unit/lib/clitasks/
# >> test/unit/lib/clitasks/story_test.rb
# >> test/unit/lib/clitasks/version_test.rb
# >>
# >> tmp/
# >> tmp/notes-index
# >> tmp/ttest
