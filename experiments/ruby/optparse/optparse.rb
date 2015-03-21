#!/Users/macbookpro/.rbenv/versions/2.1.0/bin/ruby

require 'optparse'
require 'awesome_print'

aiopts = { raw: true, index: false }
options = {
  subcmd_a: nil,
  subcmd_a: nil,
}

add_options = OptionParser.new do |opts|
  # TODO: Put command-line options here

  puts opts.class.ai(aiopts)
  opts.banner = "Usage: #{$0} add [options] file tag1 [tag2, tag3, ...]"

  opts.on('-aSUBCMD', [:add, :rm, :mv, :update], 'Category to place the tags in') do |cat|
    puts "parsing SUBCMD (as :add): #{cat}"
    options[:subcmd_a] = cat
  end
end.parse!

ap OptionParser::Switch.guess('=SUBCMD_B')
ap argv: ARGV, add_opts: add_options, raw: true, index: false

exit 0

__END__

add_options = OptionParser.new do |opts|
  # TODO: Put command-line options here

  puts opts.class.ai(aiopts)
  opts.banner = "Usage: #{$0} add [options] file tag1 [tag2, tag3, ...]"

  opts.on('-c', '--category=CAT', 'Category to place the tags in') do |cat|
    options[:category] = cat
  end


add_options = OptionParser.new do |opts|
  # TODO: Put command-line options here

  puts opts.class.ai(aiopts)
  opts.banner = "Usage: #{$0} add [options] file tag1 [tag2, tag3, ...]"

  opts.on('-c', '--category=CAT', 'Category to place the tags in') do |cat|
    options[:category] = cat
  end

  opts.on('-M', '--no-move', 'Do Not Move the file to the htag originals folder (default: --move)') do |m|
    options[:move] = false
  end

  opts.on('-m', '--move', 'Move the file to the htag originals folder (default: --move)') do |m|
    options[:move] = true
  end

  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end

update_options = OptionParser.new do |opts|
  # TODO: Put command-line options here

  opts.banner = "Usage: #{$0} update [options] file tag1 [tag2, tag3, ...]"

  opts.on('-c', '--category=CAT', 'Category to place the tags in') do |cat|
    options[:category] = cat
  end

  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end

main_options = OptionParser.new do |opts|
  # TODO: Put command-line options here

  opts.banner = "Usage: #{$0} command [options] [file] [tags, ...]"

  opts.on('-c', '--category=CAT', 'Category to place the tags in') do |cat|
    options[:category] = cat
  end

  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end

command = ARGV.shift

case command
  when 'add'
    add_options.parse!
    # process add args
  when 'update'
    update_options.parse!
    # process update args
  else
    ARGV.unshift command
    puts main_options
    # display main_options
end

