# frozen_string_literal: false

require 'spec_helper'

RSpec.describe Lite::Redis::String do

  describe '.find' do
    it 'to be nil' do
      expect(Lite::Redis::String.find(:example)).to eq(nil)
    end

    it 'to be "123"' do
      Lite::Redis::String.create(:example1, '123')
      Lite::Redis::String.create(:example2, 123)

      expect(Lite::Redis::String.find(:example1)).to eq('123')
      expect(Lite::Redis::String.find(:example2)).to eq('123')
    end
  end

  describe '.find_each' do
    it 'to be [nil, nil]' do
      expect(Lite::Redis::String.find_each(:example, :example2)).to eq([nil, nil])
    end

    it 'to be ["one", "two"]' do
      Lite::Redis::String.create('example', 'one')
      Lite::Redis::String.create('example2', 'two')

      expect(Lite::Redis::String.find_each('example', 'example2')).to eq(['one', 'two'])
    end

    it 'to be ["1", "2"]' do
      Lite::Redis::String.create('example', '1')
      Lite::Redis::String.create('example2', 2)

      expect(Lite::Redis::String.find_each('example', 'example2')).to eq(['1', '2'])
    end
  end

  describe '.length' do
    it 'to be 11' do
      Lite::Redis::String.create(:example, 'hello world')

      expect(Lite::Redis::String.length(:example)).to eq(11)
    end
  end

  describe '.split' do
    it 'to be nil' do
      expect(Lite::Redis::String.split(:example, 0, 3)).to eq(nil)
    end

    it 'to be "hel"' do
      Lite::Redis::String.create(:example, 'hello world')

      expect(Lite::Redis::String.split(:example, 0, 2)).to eq('hel')
    end
  end

  describe '.create' do
    it 'to be "1"' do
      Lite::Redis::String.create(:example, '1')

      expect(Lite::Redis::String.find(:example)).to eq('1')
    end

    it 'to be "2"' do
      Lite::Redis::String.create(:example, '1')
      Lite::Redis::String.create(:example, '2')

      expect(Lite::Redis::String.find(:example)).to eq('2')
    end

    it 'to be "1"' do
      Lite::Redis::String.create(:example, '1')
      Lite::Redis::String.create(:example, '2', nx: true)

      expect(Lite::Redis::String.find(:example)).to eq('1')
    end

    it 'to be nil' do
      Lite::Redis::String.create(:example, '1', xx: true)

      expect(Lite::Redis::String.find(:example)).to eq(nil)
    end

    it 'to be "1"' do
      Lite::Redis::String.create(:example, '1', ex: 1)

      expect(Lite::Redis::String.find(:example)).to eq('1')
    end
  end

  describe '.create!' do
    it 'to be "1"' do
      Lite::Redis::String.create!(:example, '1')

      expect(Lite::Redis::String.find(:example)).to eq('1')
    end

    it 'to be "1"' do
      Lite::Redis::String.create(:example, '1')
      Lite::Redis::String.create!(:example, '2')

      expect(Lite::Redis::String.find(:example)).to eq('1')
    end
  end

  describe '.create_each' do
    it 'to be "world"' do
      Lite::Redis::String.create_each(:example, 'hello', :example2, 'world')

      expect(Lite::Redis::String.find(:example2)).to eq('world')
    end
  end

  describe '.create_each!' do
    it 'to be "hello"' do
      Lite::Redis::String.create_each!(:example, 'hello', :example2, 'world')

      expect(Lite::Redis::String.find(:example)).to eq('hello')
    end
  end

  describe '.create_until' do
    it 'to be nil' do
      Lite::Redis::String.create_until(:example, 'hello', 2)
      sleep(3)

      expect(Lite::Redis::String.find(:example)).to eq(nil)
    end
  end

  describe '.append' do
    it 'to be "hello"' do
      expect(Lite::Redis::String.append(:example, 'hello')).to eq('hello')
    end

    it 'to be "hello world"' do
      Lite::Redis::String.create(:example, 'hello')
      Lite::Redis::String.append(:example, ' world')

      expect(Lite::Redis::String.find(:example)).to eq('hello world')
    end
  end

  describe '.replace' do
    it 'to be nil' do
      expect(Lite::Redis::String.replace(:example, 'hello', 6)).to eq(nil)
    end

    it 'to be "hello redis"' do
      Lite::Redis::String.create(:example, 'hello world')
      Lite::Redis::String.replace(:example, 'redis', 6)

      expect(Lite::Redis::String.find(:example)).to eq('hello redis')
    end
  end

  describe '.decrement' do
    it 'to be -1' do
      expect(Lite::Redis::String.decrement('example')).to eq(-1)
    end

    it 'to be 1' do
      Lite::Redis::String.create('example', 2)

      expect(Lite::Redis::String.decrement('example')).to eq(1)
    end

    it 'to be 3' do
      Lite::Redis::String.create('example', 5)

      expect(Lite::Redis::String.decrement('example', 2)).to eq(3)
    end
  end

  describe '.increment' do
    it 'to be 1' do
      expect(Lite::Redis::String.increment('example')).to eq(1)
    end

    it 'to be 2' do
      Lite::Redis::String.create('example', 1)

      expect(Lite::Redis::String.increment('example')).to eq(2)
    end

    it 'to be 5' do
      Lite::Redis::String.create(:example, 1)

      expect(Lite::Redis::String.increment('example', 4)).to eq(5)
    end
  end

  describe '.reset' do
    it 'to be nil' do
      expect(Lite::Redis::String.reset(:example)).to eq(nil)
    end

    it 'to be "0"' do
      Lite::Redis::String.create(:example, 2)
      Lite::Redis::String.reset(:example)

      expect(Lite::Redis::String.find(:example)).to eq('0')
    end

    it 'to be "2"' do
      Lite::Redis::String.create(:example, 4)
      Lite::Redis::String.reset(:example, 2)

      expect(Lite::Redis::String.find(:example)).to eq('2')
    end
  end

  describe '.bit_count' do
    it 'to be 0' do
      expect(Lite::Redis::String.bit_count(:example)).to eq(0)
    end

    it 'to be 26' do
      Lite::Redis::String.create(:example, 'foobar')

      expect(Lite::Redis::String.bit_count(:example)).to eq(26)
    end

    it 'to be 4' do
      Lite::Redis::String.create(:example, 'foobar')

      expect(Lite::Redis::String.bit_count(:example, 0, 0)).to eq(4)
    end

    it 'to be 6' do
      Lite::Redis::String.create(:example, 'foobar')

      expect(Lite::Redis::String.bit_count(:example, 1, 1)).to eq(6)
    end

    it 'to be 10' do
      Lite::Redis::String.create(:example, 'foobar')

      expect(Lite::Redis::String.bit_count(:example, 0, 1)).to eq(10)
    end
  end

  describe '.bit_where' do
    it 'to be ...' do
      Lite::Redis::String.create(:sample1, 'abc')
      Lite::Redis::String.create(:sample2, 123)

      Lite::Redis::String.bit_where(:and, 'sample1&2', :sample1, :sample2)
      Lite::Redis::String.bit_where(:or, 'sample1|2', :sample1, :sample2)
      Lite::Redis::String.bit_where(:xor, 'sample1^2', :sample1, :sample2)
      # Lite::Redis::String.bit_where(:not, 'sample1~2', :sample1, :sample2)

      expect(Lite::Redis::String.find('sample1&2')).to eq("!\"#")
      expect(Lite::Redis::String.find('sample1|2')).to eq('qrs')
      expect(Lite::Redis::String.find('sample1^2')).to eq('PPP')
      # expect(Lite::Redis::String.find('sample1~2')).to eq('qrs')
    end
  end

  describe '.get_bit' do
    it 'to be 0' do
      Lite::Redis::String.create(:example, 'a')

      expect(Lite::Redis::String.get_bit(:example, 3)).to eq(0)
      expect(Lite::Redis::String.get_bit(:example, 4)).to eq(0)
      expect(Lite::Redis::String.get_bit(:example, 5)).to eq(0)
      expect(Lite::Redis::String.get_bit(:example, 6)).to eq(0)
    end

    it 'to be 1' do
      Lite::Redis::String.create(:example, 'a')

      expect(Lite::Redis::String.get_bit(:example, 1)).to eq(1)
      expect(Lite::Redis::String.get_bit(:example, 2)).to eq(1)
      expect(Lite::Redis::String.get_bit(:example, 7)).to eq(1)
    end
  end

  describe '.set_bit' do
    it 'to be 0' do
      Lite::Redis::String.set_bit(:example, 10, 0)

      expect(Lite::Redis::String.set_bit(:example, 10, 0)).to eq(0)
      expect(Lite::Redis::String.set_bit(:example, 10, 1)).to eq(0)
    end

    it 'to be 1' do
      Lite::Redis::String.set_bit(:example, 10, 1)

      expect(Lite::Redis::String.get_bit(:example, 10)).to eq(1)
    end
  end

end
