class ToolsController < ApplicationController
  layout false

  skip_before_action :verify_authenticity_token, only: [:scratch, :scratch_save]
  before_action :set_scratch, only: [:scratch, :scratch_save]

  def google_history
    log_dir = format('%s/google', './public')
    @queries = Dir['%s/*.json' % log_dir].map{|qf|
      f = IO.read(qf)
      j = JSON.parse(f)
      format '<a href="http://hero.dev/google/%s">%s</a><br/>', URI.encode(j['query']), j['query']
    }
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
  end

  def scratch_save
    data = params[:data]

    if @scratch.update(data: data)
      render json: {status: 'saved', data: format("%d lines, %d bytes saved", data.lines.count, data.length)}
    else
      render json: {status: 'error', data: format("unknown error occurred: %s", @status.errors.full_messages)}
    end
  end

  private

  def set_scratch
    @scratch = Scratch.find_or_create_by(id: 1)
  end
end
