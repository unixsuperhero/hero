#!/Users/macbookpro/.rbenv/shims/ruby

puts 'there are %d lines in DATA' % DATA.each_line.map{|x| x }.count

__END__
first line
second line
third line
