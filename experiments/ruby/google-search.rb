#!/usr/bin/env ruby


require 'fileutils'
require 'uri'
require 'google-search'
require 'awesome_print'
require 'json'
require 'erb'

log_dir = format('%s/logs/google/web', ENV['HOME'])
FileUtils.mkdir_p log_dir

q = ARGV.join(' ')
log = q.gsub(/\s+/, ?_)
abs_log = format('%s/%s.json', log_dir, log)

if File.file? abs_log
  json = JSON.parse(IO.read(abs_log))
else
  results =  Google::Search::Web.new query: q
  links = results.map do |r|
    {
      "title" => r.title,
      "url" => r.uri,
    }
  end

  json = { "query" => q, "when" => Time.now.to_s, "epoch" => Time.now.to_i, "links" => links }

  IO.write abs_log, JSON.pretty_generate(json)
end

template = DATA.read

IO.write '/tmp/file.html', ERB.new(template).result(binding)
`open /tmp/file.html`
# render markdown file
# output it to /tmp wrapped in my split page templte

# ERB OUTPUT STARTS HERE
__END__

<html>
<head>
<style type="text/css">
  #lframe {
    width: 30%;
    margin: 0;
    padding: 0;
    float: left;
  }
  #rframe {
    width: 69%;
    height: 100%;
    border: solid black 1px;
    margin: 0;
    padding: 0;
    float: left;
  }
</style>
</head>
<body>
  <div id="lframe">
    <p><strong>query: </strong><%= json['query'] %></p>
    <p><strong>when: </strong><%= json['when'] %></p>
    <p><strong>epoch: </strong><%= json['epoch'] %></p>
    <% [*json['links']].each do |r| %>
      <a target="rframe" href="<%= r['url'] %>"><%= r['title'] %></a><br/>
      <br/>
    <% end %>
  </div>
  <iframe id="rframe" name="rframe" src="about:blank"></iframe>

</body>
</html>
