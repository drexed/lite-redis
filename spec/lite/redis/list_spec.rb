# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::List do

  describe '.find' do
    it 'to be nil' do
      expect(described_class.find(:example)).to eq(nil)
    end

    it 'to be "2"' do
      described_class.create(:example, 'one')
      described_class.create(:example, 2)
      described_class.create(:example, 'three')

      expect(described_class.find(:example, 2)).to eq('2')
    end
  end

  describe '.first' do
    it 'to be nil' do
      expect(described_class.first(:example)).to eq(nil)
    end

    it 'to be "three"' do
      described_class.create(:example, 'one')
      described_class.create(:example, 2)
      described_class.create(:example, 'three')

      expect(described_class.first(:example)).to eq('three')
    end

    it 'to be ["three", "2"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 2)
      described_class.create(:example, 'three')

      expect(described_class.first(:example, 2)).to eq(%w[three 2])
    end

    it 'to be ["three", "2", "one"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 2)
      described_class.create(:example, 'three')

      expect(described_class.first(:example, 4)).to eq(%w[three 2 one])
    end
  end

  describe '.last' do
    it 'to be nil' do
      expect(described_class.last(:example)).to eq(nil)
    end

    it 'to be "one"' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example, 'three')

      expect(described_class.last(:example)).to eq('one')
    end

    it 'to be ["2", "one"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 2)
      described_class.create(:example, 'three')

      expect(described_class.last(:example, 2)).to eq(%w[2 one])
    end

    it 'to be ["three", "2", "one"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 2)
      described_class.create(:example, 'three')

      expect(described_class.last(:example, 4)).to eq(%w[three 2 one])
    end
  end

  describe '.between' do
    it 'to be []' do
      expect(described_class.between(:example)).to eq([])
    end

    it 'to be ["2"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 2)
      described_class.create(:example, 'three')

      expect(described_class.between(:example, 2, 2)).to eq(['2'])
    end

    it 'to be ["2", "one"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 2)
      described_class.create(:example, 'three')

      expect(described_class.between(:example, 2, 3)).to eq(%w[2 one])
    end

    it 'to be ["three", "2", "one"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 2)
      described_class.create(:example, 'three')

      expect(described_class.between(:example)).to eq(%w[three 2 one])
    end
  end

  describe '.all' do
    it 'to be []' do
      expect(described_class.all(:example)).to eq([])
    end

    it 'to be ["three", "2", "one"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 2)
      described_class.create(:example, 'three')

      expect(described_class.all(:example)).to eq(%w[three 2 one])
    end
  end

  describe '.count' do
    it 'to be 0' do
      expect(described_class.count(:example)).to eq(0)
    end

    it 'to be 3' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example, 'three')

      expect(described_class.count(:example)).to eq(3)
    end
  end

  describe '.create' do
    it 'to be ["1"], ["2"], ["3"], ["4"]' do
      described_class.create('example_1', '1')

      expect(described_class.all('example_1')).to eq(['1'])
    end

    it 'to be ["three", "2", "1"]' do
      described_class.create(:example, '1')
      described_class.create(:example, 2)
      described_class.create(:example, 'three')

      expect(described_class.all(:example)).to eq(%w[three 2 1])
    end

    it 'to be ["four", "three", "2", "1"]' do
      described_class.create(:example, %w[1 2 three four])

      expect(described_class.all(:example)).to eq(%w[four three 2 1])
    end

    it 'to be ["three", "2", "1"] with prepend option' do
      described_class.create(:example, '1')
      described_class.create(:example, 2, :prepend)
      described_class.create(:example, 'three')

      expect(described_class.all(:example)).to eq(%w[three 2 1])
    end

    it 'to be ["four", "three", "2", "1"] with prepend option' do
      described_class.create(:example, %w[1 2 three four], :prepend)

      expect(described_class.all(:example)).to eq(%w[four three 2 1])
    end

    it 'to be ["three", "1", "2"] with append option' do
      described_class.create(:example, '1')
      described_class.create(:example, 2, :append)
      described_class.create(:example, 'three')

      expect(described_class.all(:example)).to eq(%w[three 1 2])
    end

    it 'to be ["1", "2", "three", "four"]' do
      described_class.create(:example, %w[1 2 three four], :append)

      expect(described_class.all(:example)).to eq(%w[1 2 three four])
    end
  end

  describe '.create!' do
    it 'to be []' do
      described_class.create!(:example, 2)

      expect(described_class.all(:example)).to eq([])
    end

    it 'to be [] when creating multiple' do
      described_class.create!(:example, [1, 2, 3, 4])

      expect(described_class.all(:example)).to eq([])
    end

    it 'to be ["three", "2", "1"]' do
      described_class.create(:example, '1')
      described_class.create!(:example, 2)
      described_class.create!(:example, 'three')

      expect(described_class.all(:example)).to eq(%w[three 2 1])
    end

    it 'to be ["four", "three", "2", "1"]' do
      described_class.create(:example, '1')
      described_class.create!(:example, [2, 'three', 'four'])

      expect(described_class.all(:example)).to eq(%w[four three 2 1])
    end

    it 'to be ["three", "2", "1"] with prepend option' do
      described_class.create(:example, '1')
      described_class.create!(:example, 2, :prepend)
      described_class.create!(:example, 'three')

      expect(described_class.all(:example)).to eq(%w[three 2 1])
    end

    it 'to be ["four", "three", "2", "1"] with prepend option' do
      described_class.create(:example, '1')
      described_class.create!(:example, [2, 'three', 'four'], :prepend)

      expect(described_class.all(:example)).to eq(%w[four three 2 1])
    end

    it 'to be ["three", "1", "2"] with append option' do
      described_class.create(:example, '1')
      described_class.create!(:example, 2, :append)
      described_class.create!(:example, 'three')

      expect(described_class.all(:example)).to eq(%w[three 1 2])
    end

    it 'to be ["1", "2", "three", "four"]' do
      described_class.create(:example, '1')
      described_class.create!(:example, [2, 'three', 'four'], :append)

      expect(described_class.all(:example)).to eq(%w[1 2 three four])
    end
  end

  describe '.create_limit' do
    it 'to be ["three", "two"]' do
      described_class.create_limit(:example, 'one', 2)
      described_class.create_limit(:example, 'two', 2)
      described_class.create_limit(:example, 'three', 2)

      expect(described_class.all(:example)).to eq(%w[three two])
    end

    it 'to be ["four", "three", "two"]' do
      described_class.create_limit(:example, %w[one two three four], 3)

      expect(described_class.all(:example)).to eq(%w[four three two])
    end

    it 'to be ["three", "two"] with prepend option' do
      described_class.create_limit(:example, 'one', 2)
      described_class.create_limit(:example, 'two', 2, :prepend)
      described_class.create_limit(:example, 'three', 2)

      expect(described_class.all(:example)).to eq(%w[three two])
    end

    it 'to be ["four", "three", "two"] with prepend option' do
      described_class.create_limit(:example, %w[one two three four], 3, :prepend)

      expect(described_class.all(:example)).to eq(%w[four three two])
    end

    it 'to be ["three", "one"]' do
      described_class.create_limit(:example, 'one', 2)
      described_class.create_limit(:example, 'two', 2, :append)
      described_class.create_limit(:example, 'three', 2)

      expect(described_class.all(:example)).to eq(%w[three one])
    end

    it 'to be ["one", "two", "three"]' do
      described_class.create_limit(:example, %w[one two three four], 3, :append)

      expect(described_class.all(:example)).to eq(%w[one two three])
    end
  end

  describe '.create_limit!' do
    it 'to be []' do
      described_class.create_limit!(:example, 'one', 2)
      described_class.create_limit!(:example, 'two', 2)
      described_class.create_limit!(:example, 'three', 2)

      expect(described_class.all(:example)).to eq([])
    end

    it 'to be [] when creating multiple at a time' do
      described_class.create_limit!(:example, %w[one two three], 2)

      expect(described_class.all(:example)).to eq([])
    end

    it 'to be ["three", "two"]' do
      described_class.create_limit(:example, 'one', 2)
      described_class.create_limit!(:example, 'two', 2)
      described_class.create_limit!(:example, 'three', 2)

      expect(described_class.all(:example)).to eq(%w[three two])
    end

    it 'to be ["four", "three", "two"]' do
      described_class.create_limit(:example, 'one', 3)
      described_class.create_limit!(:example, %w[two three four], 3)

      expect(described_class.all(:example)).to eq(%w[four three two])
    end

    it 'to be ["three", "two"] with prepend option' do
      described_class.create_limit(:example, 'one', 2)
      described_class.create_limit!(:example, 'two', 2, :prepend)
      described_class.create_limit!(:example, 'three', 2)

      expect(described_class.all(:example)).to eq(%w[three two])
    end

    it 'to be ["four", "three", "two"] with prepend option' do
      described_class.create_limit(:example, 'one', 3)
      described_class.create_limit!(:example, %w[two three four], 3, :prepend)

      expect(described_class.all(:example)).to eq(%w[four three two])
    end

    it 'to be ["three", "one"]' do
      described_class.create_limit(:example, 'one', 2)
      described_class.create_limit!(:example, 'two', 2, :append)
      described_class.create_limit!(:example, 'three', 2)

      expect(described_class.all(:example)).to eq(%w[three one])
    end

    it 'to be ["one", "two", "three"]' do
      described_class.create_limit(:example, 'one', 3)
      described_class.create_limit!(:example, %w[two three four], 3, :append)

      expect(described_class.all(:example)).to eq(%w[one two three])
    end
  end

  describe '.create_before' do
    it 'to be ["three", "four", "two", "one"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example, 'three')

      described_class.create_before(:example, 'two', 'four')

      expect(described_class.all(:example)).to eq(%w[three four two one])
    end
  end

  describe '.create_after' do
    it 'to be ["three", "two", "four", "one"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example, 'three')

      described_class.create_after(:example, 'two', 'four')

      expect(described_class.all(:example)).to eq(%w[three two four one])
    end
  end

  describe '.update' do
    it 'to be nil' do
      expect(described_class.update(:example, 1, 'v1')).to eq(nil)
    end

    it 'to be ["four", "five", "three"]' do
      described_class.create(:example, 'one', :append)
      described_class.create(:example, 'two', :append)
      described_class.create(:example, 'three', :append)

      described_class.update(:example, 0, 'four')
      described_class.update(:example, -2, 'five')

      expect(described_class.all(:example)).to eq(%w[four five three])
    end
  end

  describe '.move' do
    it 'to be nil' do
      expect(described_class.move(:example1, :example2)).to eq(nil)
    end

    it 'to be "3"' do
      described_class.create(:example1, 1, :append)
      described_class.create(:example1, 'two', :append)
      described_class.create(:example1, '3', :append)

      expect(described_class.move(:example1, :example2)).to eq('3')
    end

    it 'to be ["1", "two"]' do
      described_class.create(:example1, 1, :append)
      described_class.create(:example1, 'two', :append)
      described_class.create(:example1, '3', :append)

      described_class.move(:example1, :example2)

      expect(described_class.all(:example1)).to eq(%w[1 two])
    end

    it 'to be ["3"]' do
      described_class.create(:example1, 1, :append)
      described_class.create(:example1, 'two', :append)
      described_class.create(:example1, '3', :append)

      described_class.move(:example1, :example2)

      expect(described_class.all(:example2)).to eq(['3'])
    end
  end

  describe '.move_blocking' do
    # TODO
  end

  describe '.destroy' do
    it 'to be 0' do
      expect(described_class.destroy(:example, 1, 'v1')).to eq(0)
    end

    it 'to be 2' do
      described_class.create(:example, 'v1', :append)
      described_class.create(:example, 'v2', :append)
      described_class.create(:example, 'v2', :append)
      described_class.create(:example, 'v2', :append)
      described_class.create(:example, 'v1', :append)

      described_class.destroy(:example, 1, 'v1')
      described_class.destroy(:example, -2, 'v2')

      expect(described_class.count(:example)).to eq(2)
    end
  end

  describe '.destroy_first' do
    it 'to be nil' do
      expect(described_class.destroy_first(:example)).to eq(nil)
    end

    it 'to be ["two", "one"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example, 'three')

      described_class.destroy_first(:example)

      expect(described_class.all(:example)).to eq(%w[two one])
    end

    it 'to be ["one"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example, 'three')
      described_class.create(:example, 'four')

      described_class.destroy_first(:example, 3)

      expect(described_class.all(:example)).to eq(['one'])
    end
  end

  describe '.destroy_last' do
    it 'to be nil' do
      expect(described_class.destroy_last(:example)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example, 'three')

      described_class.destroy_last(:example)

      expect(described_class.all(:example)).to eq(%w[three two])
    end

    it 'to be ["four"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example, 'three')
      described_class.create(:example, 'four')

      described_class.destroy_last(:example, 3)

      expect(described_class.all(:example)).to eq(['four'])
    end
  end

  describe '.destroy_except' do
    it 'to be nil' do
      expect(described_class.destroy_except(:example, 2, 3)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example, 'three')
      described_class.create(:example, 'four')

      described_class.destroy_except(:example, 2, 3)

      expect(described_class.all(:example)).to eq(%w[three two])
    end
  end

  describe '.destroy_all' do
    it 'to be nil' do
      expect(described_class.destroy_all(:example)).to eq(nil)
    end

    it 'to be []' do
      described_class.create(:example, 'one')
      described_class.create(:example, 'two')
      described_class.create(:example, 'three')

      described_class.destroy_all(:example)

      expect(described_class.all(:example)).to eq([])
    end
  end

  describe '.pop' do
    it 'to be nil' do
      expect(described_class.pop(:example)).to eq(nil)
    end

    it 'to be "one"' do
      described_class.create(:example, 'one', :append)
      described_class.create(:example, 'two', :append)
      described_class.create(:example, 'three', :append)

      expect(described_class.pop(:example)).to eq('one')
    end

    it 'to be "three"' do
      described_class.create(:example, 'one', :append)
      described_class.create(:example, 'two', :append)
      described_class.create(:example, 'three', :append)

      expect(described_class.pop(:example, :append)).to eq('three')
    end

    it 'to be ["two", "three"]' do
      described_class.create(:example, 'one', :append)
      described_class.create(:example, 'two', :append)
      described_class.create(:example, 'three', :append)
      described_class.pop(:example)

      expect(described_class.all(:example)).to eq(%w[two three])
    end

    it 'to be ["one", "two"]' do
      described_class.create(:example, 'one', :append)
      described_class.create(:example, 'two', :append)
      described_class.create(:example, 'three', :append)
      described_class.pop(:example, :append)

      expect(described_class.all(:example)).to eq(%w[one two])
    end
  end

  describe '.pop_blocking' do
    # TODO
  end

end
