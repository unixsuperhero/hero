class NotesController < ApplicationController

def index
end

def tags
end

def no_tag
end

def tag
end

def show
end

def edit
end

  # def google
  #   fork do
  #     system(format("%s/bin/google", ENV['HOME']), *params[:q])
  #     exit
  #   end
  #   render text: 'google: ok'
  # end

  # def new_google
  #   log_dir = format('%s/google', './public')
  #   FileUtils.mkdir_p log_dir

  #   q = params[:q]
  #   log = params[:q].gsub(/\s+/, ?_)
  #   @abs_log = format('%s/%s.json', log_dir, log)

  #   if File.file? @abs_log
  #     @json = JSON.parse(IO.read(@abs_log))
  #   else
  #     results =  Google::Search::Web.new query: q
  #     @links = results.map do |r|
  #       {
  #         "title" => r.title,
  #         "url" => r.uri,
  #         "iurl" => r.uri.sub(/\Ahttps/,'http'),
  #       }
  #     end

  #     @json = { "query" => q, "when" => Time.now.to_s, "epoch" => Time.now.to_i, "links" => @links }

  #     IO.write @abs_log, JSON.pretty_generate(@json)
  #   end

  #   @queries = Dir['%s/*.json' % log_dir].map{|qf|
  #     f = IO.read(qf)
  #     j = JSON.parse(f)
  #     format '<a href="http://hero.dev/google/%s">%s</a><br/>', URI.encode(j['query']), j['query']
  #   }

  #   @json.merge!('queries' => @queries)
  #   render :new_google, layout: 'bins'
  # end
end
