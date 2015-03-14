# -*- encoding : utf-8 -*-
require 'rails_helper'

describe HomePage::ApiProviderHost do
  describe '#to_s' do
    it 'behaves like this' do
      provider = 'name_of_host'
      Setting.defaults['home_page.apis.providers.name_of_host.hosts.development'] = 'http://localhost:3001'
      
      # no fallback or alias mapping needed
      expect(
        described_class.new(provider, 'development').to_s
      ).to be == 'http://localhost:3001'
      
      # fallback to development
      expect(
        described_class.new(provider, 'test').to_s
      ).to be == 'http://localhost:3001'
      
      # alias mapping needed
      expect(
        described_class.new(provider, 'dev').to_s
      ).to be == 'http://localhost:3001'
            
      # alias not found
      expect{
        described_class.new(provider, 'unknown_environment').to_s
      }.to raise_error(
        NotImplementedError, 
        'Your environment is unknown. Please update alias mapping!'
      )
      
      # environment not supported by provider
      expect{
        described_class.new(provider, 'staging').to_s
      }.to raise_error(
        NotImplementedError, 
        'The API provider does not support your environment!'
      )
    end
  end
end