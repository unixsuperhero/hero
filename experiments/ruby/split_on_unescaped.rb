#!/usr/bin/env ruby

require 'awesome_print'

class String
  def split_on_unescaped(str, opts={})
    self.split(/\s*(?<!\\)#{str}\s*/).map{|s| s.gsub(/\\(?=#{str})/, '') }
  end
  def split_unescaped(str, opts={})
    return yield ' hi ' if block_given?
    self.split(/(?<!\\)#{str}/).map do |s|
      s = s.gsub(/\\(?=#{str})/, '')
      s = s.sub(/^\s*/,'').sub(/\s*$/,'') if opts[:trim] == true
      s = yield s if block_given?
      s
    end
  end
end

tags = 'one, t\,w\,o, three, fo\,ur'
t.split(/\s*(?<!\\),\s*/) # =>
ap tags_manual_split: t
t.split_on_unescaped(?,) # =>
ap tags: t

tasks = 'one; t\;w\;o; three; fo\;ur'
tasks.split(/\s*(?<!\\);\s*/) # =>
tasks.split_on_unescaped(?;) # =>


tags = 'one, t\,w\,o, three, fo\,ur'
t.split(/\s*(?<!\\),\s*/)
ap tags_manual_split: t
t.split_unescaped(?,, trim: true)
ap tags_trim: t
t.split_unescaped(?,) do |s|
  s.sub(/^\s*/, '')
end
ap tags_block: t
t.split_unescaped(?,)
ap tags: t

