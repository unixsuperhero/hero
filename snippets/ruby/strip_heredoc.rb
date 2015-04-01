module Heredoc
  extend self

  def strip(doc)
    lines = doc.lines
    padding = lines.first.split(/(?=\S)/, 2).first
    lines.map{|l| l.sub(padding, '') }.join
  end

  def test
    strip sample_text
  end

  def sample_text
    data = <<-ERB
      class BeautifiedConnect${env[*]^}V${ver//./} < ActiveRecord::Migration
        def up
          ConnectExtension.create(env: ${env}:sp Gem
        end
      end
    ERB
  end
end
