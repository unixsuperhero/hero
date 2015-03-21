#!/Users/macbookpro/.rbenv/versions/2.1.0/bin/ruby

require 'awesome_print'

a = 1            #
b = 2            # =>
c = 3            # =>

d = a * b * c    #

puts [__FILE__, __LINE__]
puts DATA.each_line.map{|x| x}.join("1\n")

__END__
[
    "testing.rb",
    11,
    ""
]
[
    "testing.rb",
    11,
    ""
]
