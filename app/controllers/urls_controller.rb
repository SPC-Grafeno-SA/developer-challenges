# frozen_string_literal: true

class UrlsController < ApplicationController
  def create
    url = Url.new(url_params)
    if url.save
      render json: { short_url: short_url(url) }, status: :created
    else
      render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    url = Url.find_by(short_url: params[:short_url])
    if url && !url.expired?
      url.increment!(:access_count)
      AccessLog.create(url: url, accessed_at: Time.current)
      redirect_to url.original_url, allow_other_host: true
    else
      render json: { error: 'URL não encontrada ou expireda' }, status: :not_found
    end
  end

  def stats
    url = Url.find_by(short_url: params[:short_url])
    if url
      render json: {
        access_count: url.access_count,
        access_logs: url.access_logs.order(accessed_at: :desc).map { |log| { accessed_at: log.accessed_at } }
      }
    else
      render json: { error: 'URL não encontrada' }, status: :not_found
    end
  end

  private

  def url_params
    params.require(:url).permit(:original_url, :expires_at)
  end

  def short_url(url)
    "#{request.base_url}/#{url.short_url}"
  end
end
