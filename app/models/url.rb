# frozen_string_literal: true

class Url < ApplicationRecord
  has_many :access_logs, dependent: :destroy

  validates :original_url, presence: true, format: { with: URI::regexp(%w[http https]) }
  validates :short_url, presence: true, uniqueness: true
  validates :expires_at, allow_nil: true, date: { after: Time.current }

  before_validation :generate_short_url, on: :create

  def expired?
    expires_at.present? && expires_at < Time.current
  end

  private

  def generate_short_url
    length = rand(5..10) # Entre 5 e 10
    self.short_url = SecureRandom.alphanumeric(length) while short_url.blank? || Url.exists?(short_url: short_url)
  end
end
