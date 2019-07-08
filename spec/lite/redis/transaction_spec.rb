# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::Transaction do
  after(:each) do
    Lite::Redis::Transaction.discard rescue nil
  end

  describe '.multi' do
    it 'to be "OK"' do
      expect(Lite::Redis::Transaction.multi).to eq('OK')
    end

    response = ['OK', 'OK', true, ['1', '2']]

    it 'to be #{response}' do
      transaction = Lite::Redis::Transaction.multi do |multi|
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
      expect { Lite::Redis::Transaction.discard }.to raise_error(Redis::CommandError)
    end

    it 'to be "OK"' do
      Lite::Redis::Transaction.multi

      expect(Lite::Redis::Transaction.discard).to eq('OK')
    end
  end

  describe '.watch' do
    # TODO
  end

  describe '.unwatch' do
    # TODO
  end

end
