# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::Hash do

  describe '.find' do
    it 'to be nil' do
      expect(described_class.find(:example, :name)).to be_nil
    end

    it 'to be "1"' do
      described_class.create(:example, :name, 1)

      expect(described_class.find(:example, :name)).to eq('1')
    end
  end

  describe '.find_each' do
    it 'to be ["1", "2"]' do
      described_class.create(:example, :name, 1)
      described_class.create(:example, :bday, 2)

      expect(described_class.find_each(:example, :name, :bday)).to eq(%w[1 2])
    end
  end

  describe '.all' do
    it 'to be { "name" => "hello", "bday" => "world" }' do
      described_class.create(:example, :name, 'hello')
      described_class.create(:example, :bday, 'world')

      expect(described_class.all(:example)).to eq('name' => 'hello', 'bday' => 'world')
    end
  end

  describe '.keys' do
    it 'to be ["name", "bday"]' do
      described_class.create(:example, :name, 'hello')
      described_class.create(:example, :bday, 'world')

      expect(described_class.keys(:example)).to eq(%w[name bday])
    end
  end

  describe '.values' do
    it 'to be ["hello", "world"]' do
      described_class.create(:example, :name, 'hello')
      described_class.create(:example, :bday, 'world')

      expect(described_class.values(:example)).to eq(%w[hello world])
    end
  end

  describe '.value_length' do
    # TODO
  end

  describe '.count' do
    it 'to be 2' do
      described_class.create(:example, :name, 'hello')
      described_class.create(:example, :bday, 'world')

      expect(described_class.count(:example)).to eq(2)
    end
  end

  describe '.exists?' do
    it 'to be false' do
      described_class.create(:example, :name, 'redis')

      expect(described_class.exists?(:example, :bday)).to be(false)
    end

    it 'to be false with both missing keys' do
      described_class.create(:example, :name, 'redis')

      expect(described_class.exists?(:example2, :bday)).to be(false)
    end
  end

  describe '.create' do
    it 'to be "hello"' do
      described_class.create(:example, :name, 'hello')

      expect(described_class.find(:example, :name)).to eq('hello')
    end
  end

  describe '.create!' do
    it 'to be "hello"' do
      described_class.create!(:example, :name, 'hello')

      expect(described_class.find(:example, :name)).to eq('hello')
    end

    it 'to be "hello" when trying to override' do
      described_class.create!(:example, :name, 'hello')
      described_class.create!(:example, :name, 'world')

      expect(described_class.find(:example, :name)).to eq('hello')
    end
  end

  describe '.create_each' do
    it 'to be "world"' do
      described_class.create_each(:example, :name, 'hello', :bday, 'world')

      expect(described_class.find(:example, :bday)).to eq('world')
    end
  end

  describe '.increment' do
    it 'to be "21"' do
      described_class.create(:example, :age, 19)
      described_class.increment(:example, :age, 2)

      expect(described_class.find(:example, :age)).to eq('21')
    end
  end

  describe '.destroy' do
    it 'to be nil' do
      described_class.create(:example, :name, 'hello')
      described_class.destroy(:example, :name)

      expect(described_class.find(:example, :name)).to be_nil
    end
  end

  describe '.scan' do
    # TODO
  end

end
