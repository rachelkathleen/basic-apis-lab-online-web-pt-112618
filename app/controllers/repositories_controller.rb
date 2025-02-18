class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    begin
      @response = Faraday.get 'https://api.github.com/search/repositories' do |req|
        req.params['client_id'] = 'YOUR client_id'
        req.params['client_secret'] = 'YOUR client_secret'
        req.params['q'] = params[:query]
      end
    body = JSON.parse(@response.body)
    if @response.success?
      @items = body['items']
    else
      @error = body['message']
    end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again"
    end
      render 'search'
    end
  end
