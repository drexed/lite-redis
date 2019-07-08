# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::Set do

  describe '.find' do
    it 'to be nil' do
      expect(described_class.find(:example)).to eq(nil)
    end

    it 'to be ["2", "1"]' do
      described_class.create(:example, '1')
      described_class.create(:example, 2)

      expect(described_class.find(:example)).to eq(%w[2 1])
    end
  end

  describe '.combine' do
    it 'to be nil' do
      expect(described_class.combine(:example, :example2)).to eq(nil)
    end

    it 'to be ["1", "2", "4"]' do
      described_class.create(:example, '1')
      described_class.create(:example, 2)
      described_class.create(:example2, '2')
      described_class.create(:example2, 4)

      expect(described_class.combine(:example, :example2)).to eq(%w[1 2 4])
    end
  end

  describe '.difference' do
    it 'to be nil' do
      expect(described_class.difference(:example, :example2)).to eq(nil)
    end

    it 'to be nil' do
      described_class.create(:example, '1')
      described_class.create(:example, 1)
      described_class.create(:example2, '1')
      described_class.create(:example2, 1)

      expect(described_class.difference(:example, :example2)).to eq(nil)
    end

    it 'to be ["1"]' do
      described_class.create(:example, '1')
      described_class.create(:example, 2)
      described_class.create(:example2, '2')
      described_class.create(:example2, 3)

      expect(described_class.difference(:example, :example2)).to eq(['1'])
    end

    it 'to be ["3"]' do
      described_class.create(:example, 1)
      described_class.create(:example, 2)
      described_class.create(:example2, '2')
      described_class.create(:example2, '3')

      expect(described_class.difference(:example2, :example)).to eq(['3'])
    end
  end

  describe '.intersection' do
    it 'to be nil' do
      expect(described_class.intersection(:example, :example2, :example3)).to eq(nil)
    end

    it 'to be nil' do
      described_class.create(:example, '1')
      described_class.create(:example, 2)
      described_class.create(:example2, '3')
      described_class.create(:example2, 4)
      described_class.create(:example3, '5')
      described_class.create(:example3, 6)

      expect(described_class.intersection(:example, :example2, :example3)).to eq(nil)
    end

    it 'to be ["2"]' do
      described_class.create(:example, '1')
      described_class.create(:example, 2)
      described_class.create(:example2, '2')
      described_class.create(:example2, 3)
      described_class.create(:example3, '2')
      described_class.create(:example3, 4)

      expect(described_class.intersection(:example, :example2, :example3)).to eq(['2'])
    end
  end

  describe '.sample' do
    it 'to be nil' do
      expect(described_class.sample(:example)).to eq([])
    end

    it 'to be ["1", "2", "4"]' do
      described_class.create(:example, '1')
      described_class.create(:example, 2)
      described_class.create(:example2, '2')
      described_class.create(:example2, 4)

      expect(described_class.combine(:example, :example2)).to eq(%w[1 2 4])
    end
  end

  describe '.value?' do
    it 'to be true' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')

      expect(described_class.value?(:example, 'one')).to eq(true)
    end

    it 'to be false' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')

      expect(described_class.value?(:example, 'three')).to eq(false)
    end
  end

  describe '.count' do
    it 'to be 2' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')

      expect(described_class.count(:example)).to eq(2)
    end
  end

  describe '.create' do
    it 'to be ["one"]' do
      described_class.create(:example, 'one')

      expect(described_class.find(:example)).to eq(['one'])
    end

    it 'to be ["two", "one"]' do
      described_class.create(:example, 'one', 'two')

      expect(described_class.find(:example)).to eq(%w[two one])
    end
  end

  describe '.create_differenece' do
    it 'to be ["one"]' do
      described_class.create(:example1, 'one')
      described_class.create(:example1, 'two')
      described_class.create(:example2, 'two')
      described_class.create(:example2, 'three')
      described_class.create_difference(:example3, :example1, :example2)

      expect(described_class.find(:example3)).to eq(['one'])
    end
  end

  describe '.create_intersection' do
    it 'to be ["two"]' do
      described_class.create(:example1, 'one')
      described_class.create(:example1, 'two')
      described_class.create(:example2, 'two')
      described_class.create(:example2, 'three')
      described_class.create(:example3, 'two')
      described_class.create(:example3, 'four')
      described_class.create_intersection(:example4, :example1, :example2, :example3)

      expect(described_class.find(:example4)).to eq(['two'])
    end
  end

  describe '.create_combination' do
    it 'to be ["four", "three", "two", "one"]' do
      described_class.create(:example1, 'one')
      described_class.create(:example1, 'two')
      described_class.create(:example2, 'two')
      described_class.create(:example2, 'three')
      described_class.create(:example3, 'two')
      described_class.create(:example3, 'four')
      described_class.create_combination(:example4, :example1, :example2, :example3)

      expect(described_class.find(:example4)).to eq(%w[four three two one])
    end
  end

  describe '.move' do
    it 'to be "three"' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example2, 'three')
      described_class.create(:example2, 'four')
      described_class.move(:example2, :example, 'four')

      expect(described_class.find(:example2)).to eq(['three'])
    end
  end

  describe '.destroy' do
    it 'to be ["three", "one"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example, 'three')
      described_class.destroy(:example, 'two')

      expect(described_class.find(:example)).to eq(%w[three one])
    end

    it 'to be ["two"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example, 'three')
      described_class.destroy(:example, %w[three one])

      expect(described_class.find(:example)).to eq(['two'])
    end
  end

  describe '.scan' do
    # TODO
  end

end
