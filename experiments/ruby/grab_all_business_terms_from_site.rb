#!/usr/bin/env ruby

# businesscasestudies.co.uk/glossary

require 'awesome_print'
require 'nokogiri'
require 'net/http'
require 'uri'

module H
  extend self

  def test(args=ARGV.dup)
    url = args.shift || 'http://businesscasestudies.co.uk/glossary/'
    uri = URI(url)
    html = Net::HTTP.get(uri)
    ng = Nokogiri::HTML.parse(html)
    glossaries = ng.css('li.glossary').map do |glossary|
      t = glossary.css('.gloss-left').text
      d = glossary.css('.gloss-right').text
      format("- %s := %s =:\n", t, d)
    end.join
  end
end

puts H.test ARGV.clone

__END__
