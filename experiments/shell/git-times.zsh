#!/bin/zsh

#git show --name-status b82d7~1..head master | sed -nE '/^commit /,/^Date:/p;/^\s*$/p' | uniq >/tmp/g
#for a in $(cat /tmp/g)
#do
#  if echo "$a" | egrep '\S' >/dev/null
#  then
#    true
#  else
#    continue
#  fi
#
#  printf "%s " "$a"
#  if echo "$a" | grep '^Date' >/dev/null
#  then
#    echo
#  fi
#done
#true

cd ~/beautified
git show --name-status b82d7~1..head | sed -nE '/^commit /,/^Date:/p;/^\s*$/p' | while read x
do
  if echo "$x" | egrep '^\s*$' >/dev/null;
  then
    continue;
  fi;
  printf "%s " "$x";
  if echo "$x" | grep '^Date' >/dev/null;
  then
    echo;
  fi;
done | sed -E 's/commit (.......)\S*.*Date:\s*(.*)\s*$/printf "%s # %s\\n" date "\2" "\1"/;s/0.00[^"]*/0500/;s/date "[^A-Z]*/"/' >/tmp/gg

ruby <<RUBY >$HOME/git-times.rb

require 'pp'

file = IO.read '/tmp/gg'

f = []
f << '['
dates = []
f << ']'

file.lines.each do |line|
  date,sha = line.split(/\s*#\s*/)
  dates << '[' + [date, Time.parse(date).strftime('%s'), sha].map(&:inspect).join(?,) + ']'
end

IO.write '/tmp/o', ['[', dates.join(",\n"), ']'].join

RUBY

head /tmp/o

