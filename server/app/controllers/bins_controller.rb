class BinsController < ApplicationController
  def google
    fork do
      system(format("%s/bin/google", ENV['HOME']), *params[:q])
      exit
    end
    render text: 'google: ok'
  end
end
