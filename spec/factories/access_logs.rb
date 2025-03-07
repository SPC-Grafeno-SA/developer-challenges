# frozen_string_literal: true

FactoryBot.define do
  factory :access_log do
    url
    accessed_at { Time.current }
  end
end
