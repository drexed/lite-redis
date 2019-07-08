# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::Transaction do
  after do

    described_class.discard
  rescue StandardError
    nil

  end

  describe '.multi' do
    it 'to be "OK"' do
      expect(described_class.multi).to eq('OK')
    end

    response = ['OK', 'OK', true, %w[1 2]]

    it 'to be { ... }' do
      transaction = described_class.multi do |multi|
        multi.set('key1', '1')
        multi.set('key2', '2')
        multi.expire('key1', 123)
        multi.mget('key1', 'key2')
      end

      expect(transaction).to eq(response)
    end
  end

  describe '.discard' do
    it 'to raise error' do
      expect { described_class.discard }.to raise_error(Redis::CommandError)
    end

    it 'to be "OK"' do
      described_class.multi

      expect(described_class.discard).to eq('OK')
    end
  end

  describe '.watch' do
    # TODO
  end

  describe '.unwatch' do
    # TODO
  end

end
