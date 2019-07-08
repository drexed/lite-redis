# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::Configuration do
  after do
    Lite::Redis.configure do |config|
      config.client = Redis.new
    end
  end

  describe '#configure' do
    it 'to be "foo" for client' do
      Lite::Redis.configuration.client = 'foo'

      expect(Lite::Redis.configuration.client).to eq('foo')
    end
  end

end
