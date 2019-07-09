# frozen_string_literal: true

require 'spec_helper'
require 'connection_pool'

RSpec.describe Lite::Redis::Base do

  describe '#caller' do
    it 'to be "123"' do
      string = Lite::Redis::String.new
      string.create(:example1, '123')

      expect(string.find(:example1)).to eq('123')
    end
  end

  describe '#connection_pool' do
    it 'to be "123"' do
      pool = ConnectionPool::Wrapper.new(size: 5, timeout: 5) { Redis.new }

      string = Lite::Redis::String.new(pool)
      string.create(:example1, '123')

      expect(string.find(:example1)).to eq('123')
    end
  end

end
