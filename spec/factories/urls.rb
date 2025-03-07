# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    original_url { Faker::Internet.url }
    short_url { nil }
    expires_at { 1.week.from_now }
    access_count { 0 }

    trait :expired do
      expires_at { 1.day.ago }
    end
  end
end
