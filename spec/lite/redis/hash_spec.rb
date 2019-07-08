# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::Hash do

  describe '.find' do
    it 'to be nil' do
      expect(Lite::Redis::Hash.find(:example, :name)).to eq(nil)
    end

    it 'to be "1"' do
      Lite::Redis::Hash.create(:example, :name, 1)

      expect(Lite::Redis::Hash.find(:example, :name)).to eq('1')
    end
  end

  describe '.find_each' do
    it 'to be ["1", "2"]' do
      Lite::Redis::Hash.create(:example, :name, 1)
      Lite::Redis::Hash.create(:example, :bday, 2)

      expect(Lite::Redis::Hash.find_each(:example, :name, :bday)).to eq(['1', '2'])
    end
  end

  describe '.all' do
    it 'to be { "name" => "hello", "bday" => "world" }' do
      Lite::Redis::Hash.create(:example, :name, 'hello')
      Lite::Redis::Hash.create(:example, :bday, 'world')

      expect(Lite::Redis::Hash.all(:example)).to eq({ 'name' => 'hello', 'bday' => 'world' })
    end
  end

  describe '.keys' do
    it 'to be ["name", "bday"]' do
      Lite::Redis::Hash.create(:example, :name, 'hello')
      Lite::Redis::Hash.create(:example, :bday, 'world')

      expect(Lite::Redis::Hash.keys(:example)).to eq(['name', 'bday'])
    end
  end

  describe '.values' do
    it 'to be ["hello", "world"]' do
      Lite::Redis::Hash.create(:example, :name, 'hello')
      Lite::Redis::Hash.create(:example, :bday, 'world')

      expect(Lite::Redis::Hash.values(:example)).to eq(['hello', 'world'])
    end
  end

  describe '.value_length' do
    # TODO
  end

  describe '.count' do
    it 'to be 2' do
      Lite::Redis::Hash.create(:example, :name, 'hello')
      Lite::Redis::Hash.create(:example, :bday, 'world')

      expect(Lite::Redis::Hash.count(:example)).to eq(2)
    end
  end

  describe '.exists?' do
    it 'to be false' do
      Lite::Redis::Hash.create(:example, :name, 'redis')

      expect(Lite::Redis::Hash.exists?(:example, :bday)).to eq(false)
    end

    it 'to be false' do
      Lite::Redis::Hash.create(:example, :name, 'redis')

      expect(Lite::Redis::Hash.exists?(:example2, :bday)).to eq(false)
    end
  end

  describe '.create' do
    it 'to be "hello"' do
      Lite::Redis::Hash.create(:example, :name, 'hello')

      expect(Lite::Redis::Hash.find(:example, :name)).to eq('hello')
    end
  end

  describe '.create!' do
    it 'to be "hello"' do
      Lite::Redis::Hash.create!(:example, :name, 'hello')

      expect(Lite::Redis::Hash.find(:example, :name)).to eq('hello')
    end

    it 'to be "hello"' do
      Lite::Redis::Hash.create!(:example, :name, 'hello')
      Lite::Redis::Hash.create!(:example, :name, 'world')

      expect(Lite::Redis::Hash.find(:example, :name)).to eq('hello')
    end
  end

  describe '.create_each' do
    it 'to be "world"' do
      Lite::Redis::Hash.create_each(:example, :name, 'hello', :bday, 'world')

      expect(Lite::Redis::Hash.find(:example, :bday)).to eq('world')
    end
  end

  describe '.increment' do
    it 'to be "21"' do
      Lite::Redis::Hash.create(:example, :age, 19)
      Lite::Redis::Hash.increment(:example, :age, 2)

      expect(Lite::Redis::Hash.find(:example, :age)).to eq('21')
    end
  end

  describe '.destroy' do
    it 'to be nil' do
      Lite::Redis::Hash.create(:example, :name, 'hello')
      Lite::Redis::Hash.destroy(:example, :name)

      expect(Lite::Redis::Hash.find(:example, :name)).to eq(nil)
    end
  end

  describe '.scan' do
    # TODO
  end

end
