# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validação' do
    subject { create(:url) }

    it { should validate_presence_of(:original_url) }
    it { should validate_presence_of(:short_url) }
    it { should validate_uniqueness_of(:short_url) }

    it 'valida o formato da URL original' do
      valid_url = build(:url, original_url: 'http://example.com')
      invalid_url = build(:url, original_url: 'invalid-url')

      expect(valid_url).to be_valid
      expect(invalid_url).not_to be_valid
    end

    it 'valida a expiração da data no futuro' do
      valid_url = build(:url, expires_at: 1.day.from_now)
      invalid_url = build(:url, expires_at: 1.day.ago)

      expect(valid_url).to be_valid
      expect(invalid_url).not_to be_valid
    end
  end

  describe 'callbacks' do
    it 'gera uma url encurtada entre 5 ou 10 caracteres' do
      url = build(:url, short_url: nil)
      url.save

      expect(url.short_url).not_to be_nil
      expect(url.short_url.length).to be_between(5, 10)
    end

    it 'gera uma url encurtada contendo apenas letras e números' do
      url = build(:url, short_url: nil)
      url.save

      expect(url.short_url).to match(/^[A-Za-z0-9]+$/)
    end

    it 'garante que a URL encurtada é única' do
      url1 = create(:url)
      url2 = build(:url, original_url: 'http://another-example.com')

      expect(url2).to be_valid
      expect(url2.short_url).not_to eq(url1.short_url)
    end
  end
end
