class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ping
    render text: 'pong'
  end

  def google
    log_dir = format('%s/google', './public')
    FileUtils.mkdir_p log_dir

    q = params[:q]
    log = params[:q].gsub(/\s+/, ?_)
    @abs_log = format('%s/%s.json', log_dir, log)

    if File.file? @abs_log
      @json = JSON.parse(IO.read(@abs_log))
    else
      results =  Google::Search::Web.new query: q
      @links = results.map do |r|
        {
          "title" => r.title,
          "url" => r.uri,
          "iurl" => r.uri.sub(/\Ahttps/,'http'),
        }
      end

      @json = { "query" => q, "when" => Time.now.to_s, "epoch" => Time.now.to_i, "links" => @links }

      IO.write @abs_log, JSON.pretty_generate(@json)
    end

    @queries = Dir['%s/*.json' % log_dir].map{|qf|
      f = IO.read(qf)
      j = JSON.parse(f)
      format '<a href="http://hero.dev/google/%s">%s</a><br/>', URI.encode(j['query']), j['query']
    }

    @json.merge!('queries' => @queries)
    render :google, layout: 'bins'
  end
end
