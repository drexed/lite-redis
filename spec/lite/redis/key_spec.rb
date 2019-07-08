# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::Key do

  describe '.exists?' do
    it 'to be false' do
      expect(described_class.exists?(:example)).to eq(false)
    end

    it 'to be true' do
      Lite::Redis::String.create(:example, 'hello')

      expect(described_class.exists?(:example)).to eq(true)
    end
  end

  describe '.type?' do
    it 'to be "none"' do
      expect(described_class.type?(:example)).to eq('none')
    end

    it 'to be "string"' do
      Lite::Redis::String.create(:example, 'hello')

      expect(described_class.type?(:example)).to eq('string')
    end
  end

  describe '.ttl?' do
    it 'to be 2' do
      Lite::Redis::String.create(:example, 'hello')
      described_class.expire(:example, 2)

      expect(described_class.ttl?(:example)).to eq(2)
    end
  end

  describe '.rename' do
    it 'to be nil' do
      Lite::Redis::String.create(:example, 'hello')
      described_class.rename(:example, :example2)

      expect(Lite::Redis::String.find(:example)).to eq(nil)
    end

    it 'to be "hello"' do
      Lite::Redis::String.create(:example, 'hello')
      described_class.rename(:example, :example2)

      expect(Lite::Redis::String.find(:example2)).to eq('hello')
    end
  end

  describe '.rename!' do
    it 'to be nil' do
      Lite::Redis::String.create(:example, 'hello')
      described_class.rename!(:example, :example2)

      expect(Lite::Redis::String.find(:example)).to eq(nil)
    end

    it 'to be "world"' do
      Lite::Redis::String.create_each(:example, 'hello', :example2, 'world')
      described_class.rename!(:example, :example2)

      expect(Lite::Redis::String.find(:example2)).to eq('world')
    end
  end

  describe '.destroy' do
    it 'to be nil' do
      Lite::Redis::String.create(:example, 'hello')
      described_class.destroy(:example)

      expect(Lite::Redis::String.find(:example)).to eq(nil)
    end
  end

  describe '.persist' do
    it 'to be "hello"' do
      Lite::Redis::String.create(:example, 'hello')
      described_class.expire(:example, 2)
      described_class.persist(:example)
      sleep(3)

      expect(Lite::Redis::String.find(:example)).to eq('hello')
    end
  end

  describe '.expire' do
    it 'to be nil' do
      Lite::Redis::String.create(:example, 'hello')
      described_class.expire(:example, 2)
      sleep(3)

      expect(Lite::Redis::String.find(:example)).to eq(nil)
    end
  end

  describe '.expire_in' do
    it 'to be nil' do
      Lite::Redis::String.create(:example, 'hello')
      described_class.expire_in(:example, 2)
      sleep(3)

      expect(Lite::Redis::String.find(:example)).to eq(nil)
    end
  end

  describe '.dump' do
    # TODO
  end

  describe '.match' do
    it 'to be nil' do
      expect(described_class.match(:example)).to eq(nil)
    end

    it 'to be ["key:a", "key:b", "key:c"]' do
      Lite::Redis::String.create_each('key:a', '1', 'key:b', '2', 'key:c', '3', 'akeyd', '4', 'key1', '5')

      expect(described_class.match('key:*')).to eq(['key:a', 'key:b', 'key:c'])
    end
  end

  describe '.migrate' do
    # TODO
  end

  describe '.move' do
    # TODO
  end

  describe '.object' do
    # TODO
  end

  describe '.restore' do
    # TODO
  end

  describe '.sort' do
    # TODO
  end

  describe '.scan' do
    # TODO
  end

end
