# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::Set do

  describe '.find' do
    it 'to be nil' do
      expect(Lite::Redis::Set.find(:example)).to eq(nil)
    end

    it 'to be ["2", "1"]' do
      Lite::Redis::Set.create(:example, '1')
      Lite::Redis::Set.create(:example, 2)

      expect(Lite::Redis::Set.find(:example)).to eq(['2', '1'])
    end
  end

  describe '.combine' do
    it 'to be nil' do
      expect(Lite::Redis::Set.combine(:example, :example2)).to eq(nil)
    end

    it 'to be ["1", "2", "4"]' do
      Lite::Redis::Set.create(:example, '1')
      Lite::Redis::Set.create(:example, 2)
      Lite::Redis::Set.create(:example2, '2')
      Lite::Redis::Set.create(:example2, 4)

      expect(Lite::Redis::Set.combine(:example, :example2)).to eq(['1', '2', '4'])
    end
  end

  describe '.difference' do
    it 'to be nil' do
      expect(Lite::Redis::Set.difference(:example, :example2)).to eq(nil)
    end

    it 'to be nil' do
      Lite::Redis::Set.create(:example, '1')
      Lite::Redis::Set.create(:example, 1)
      Lite::Redis::Set.create(:example2, '1')
      Lite::Redis::Set.create(:example2, 1)

      expect(Lite::Redis::Set.difference(:example, :example2)).to eq(nil)
    end

    it 'to be ["1"]' do
      Lite::Redis::Set.create(:example, '1')
      Lite::Redis::Set.create(:example, 2)
      Lite::Redis::Set.create(:example2, '2')
      Lite::Redis::Set.create(:example2, 3)

      expect(Lite::Redis::Set.difference(:example, :example2)).to eq(['1'])
    end

    it 'to be ["3"]' do
      Lite::Redis::Set.create(:example, 1)
      Lite::Redis::Set.create(:example, 2)
      Lite::Redis::Set.create(:example2, '2')
      Lite::Redis::Set.create(:example2, '3')

      expect(Lite::Redis::Set.difference(:example2, :example)).to eq(['3'])
    end
  end

  describe '.intersection' do
    it 'to be nil' do
      expect(Lite::Redis::Set.intersection(:example, :example2, :example3)).to eq(nil)
    end

    it 'to be nil' do
      Lite::Redis::Set.create(:example, '1')
      Lite::Redis::Set.create(:example, 2)
      Lite::Redis::Set.create(:example2, '3')
      Lite::Redis::Set.create(:example2, 4)
      Lite::Redis::Set.create(:example3, '5')
      Lite::Redis::Set.create(:example3, 6)

      expect(Lite::Redis::Set.intersection(:example, :example2, :example3)).to eq(nil)
    end

    it 'to be ["2"]' do
      Lite::Redis::Set.create(:example, '1')
      Lite::Redis::Set.create(:example, 2)
      Lite::Redis::Set.create(:example2, '2')
      Lite::Redis::Set.create(:example2, 3)
      Lite::Redis::Set.create(:example3, '2')
      Lite::Redis::Set.create(:example3, 4)

      expect(Lite::Redis::Set.intersection(:example, :example2, :example3)).to eq(['2'])
    end
  end

  describe '.sample' do
    it 'to be nil' do
      expect(Lite::Redis::Set.sample(:example)).to eq(nil)
    end

    it 'to be ["1", "2", "4"]' do
      Lite::Redis::Set.create(:example, '1')
      Lite::Redis::Set.create(:example, 2)
      Lite::Redis::Set.create(:example2, '2')
      Lite::Redis::Set.create(:example2, 4)

      expect(Lite::Redis::Set.combine(:example, :example2)).to eq(['1', '2', '4'])
    end
  end

  describe '.value?' do
    it 'to be true' do
      Lite::Redis::Set.create(:example, 'one')
      Lite::Redis::Set.create(:example, 'two')

      expect(Lite::Redis::Set.value?(:example, 'one')).to eq(true)
    end

    it 'to be false' do
      Lite::Redis::Set.create(:example, 'one')
      Lite::Redis::Set.create(:example, 'two')

      expect(Lite::Redis::Set.value?(:example, 'three')).to eq(false)
    end
  end

  describe '.count' do
    it 'to be 2' do
      Lite::Redis::Set.create(:example, 'one')
      Lite::Redis::Set.create(:example, 'two')

      expect(Lite::Redis::Set.count(:example)).to eq(2)
    end
  end

  describe '.create' do
    it 'to be ["one"]' do
      Lite::Redis::Set.create(:example, 'one')

      expect(Lite::Redis::Set.find(:example)).to eq(['one'])
    end

    it 'to be ["two", "one"]' do
      Lite::Redis::Set.create(:example, 'one', 'two')

      expect(Lite::Redis::Set.find(:example)).to eq(['two', 'one'])
    end
  end

  describe '.create_differenece' do
    it 'to be ["one"]' do
      Lite::Redis::Set.create(:example1, 'one')
      Lite::Redis::Set.create(:example1, 'two')
      Lite::Redis::Set.create(:example2, 'two')
      Lite::Redis::Set.create(:example2, 'three')
      Lite::Redis::Set.create_difference(:example3, :example1, :example2)

      expect(Lite::Redis::Set.find(:example3)).to eq(['one'])
    end
  end

  describe '.create_intersection' do
    it 'to be ["two"]' do
      Lite::Redis::Set.create(:example1, 'one')
      Lite::Redis::Set.create(:example1, 'two')
      Lite::Redis::Set.create(:example2, 'two')
      Lite::Redis::Set.create(:example2, 'three')
      Lite::Redis::Set.create(:example3, 'two')
      Lite::Redis::Set.create(:example3, 'four')
      Lite::Redis::Set.create_intersection(:example4, :example1, :example2, :example3)

      expect(Lite::Redis::Set.find(:example4)).to eq(['two'])
    end
  end

  describe '.create_combination' do
    it 'to be ["four", "three", "two", "one"]' do
      Lite::Redis::Set.create(:example1, 'one')
      Lite::Redis::Set.create(:example1, 'two')
      Lite::Redis::Set.create(:example2, 'two')
      Lite::Redis::Set.create(:example2, 'three')
      Lite::Redis::Set.create(:example3, 'two')
      Lite::Redis::Set.create(:example3, 'four')
      Lite::Redis::Set.create_combination(:example4, :example1, :example2, :example3)

      expect(Lite::Redis::Set.find(:example4)).to eq(['four', 'three', 'two', 'one'])
    end
  end

  describe '.move' do
    it 'to be "three"' do
      Lite::Redis::Set.create(:example, 'one')
      Lite::Redis::Set.create(:example, 'two')
      Lite::Redis::Set.create(:example2, 'three')
      Lite::Redis::Set.create(:example2, 'four')
      Lite::Redis::Set.move(:example2, :example, 'four')

      expect(Lite::Redis::Set.find(:example2)).to eq(['three'])
    end
  end

  describe '.destroy' do
    it 'to be ["three", "one"]' do
      Lite::Redis::Set.create(:example, 'one')
      Lite::Redis::Set.create(:example, 'two')
      Lite::Redis::Set.create(:example, 'three')
      Lite::Redis::Set.destroy(:example, 'two')

      expect(Lite::Redis::Set.find(:example)).to eq(['three', 'one'])
    end

    it 'to be ["two"]' do
      Lite::Redis::Set.create(:example, 'one')
      Lite::Redis::Set.create(:example, 'two')
      Lite::Redis::Set.create(:example, 'three')
      Lite::Redis::Set.destroy(:example, ['three', 'one'])

      expect(Lite::Redis::Set.find(:example)).to eq(['two'])
    end
  end

  describe '.scan' do
    # TODO
  end

end
