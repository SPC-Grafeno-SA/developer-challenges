# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Urls', type: :request do
  describe 'POST /urls' do
    it 'cria uma URL encurtada' do
      post '/urls', params: { url: { original_url: 'http://example.com' } }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to have_key('short_url')
    end

    it 'retorna erro para uma URL inválida' do
      post '/urls', params: { url: { original_url: 'invalid-url' } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to have_key('errors')
    end
  end

  describe 'GET /:short_url' do
    let(:url) { create(:url) }

    it 'redireciona para a URL original' do
      get "/#{url.short_url}"

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(url.original_url)
    end

    it 'retorna um 404 para uma URL expirada' do
      expired_url = create(:url, :expired)
      get "/#{expired_url.short_url}"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to have_key('error')
    end
  end

  describe 'GET /:short_url/stats' do
    let(:url) { create(:url) }

    it 'retorna os "stats" para a URL encurtada' do
      create_list(:access_log, 3, url: url)

      3.times { get "/#{url.short_url}" }

      get "/#{url.short_url}/stats"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include(
        'access_count' => 3,
        'access_logs' => be_an(Array)
      )
    end

    it 'retorna um 404 para uma URL encurtada inexistente.' do
      get '/invalid/stats'

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to have_key('error')
    end
  end
end
