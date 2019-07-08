# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::List do

  describe '.find' do
    it 'to be nil' do
      expect(Lite::Redis::List.find(:example)).to eq(nil)
    end

    it 'to be "2"' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 2)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.find(:example, 2)).to eq('2')
    end

    it 'to be { ... }' do
      response = { one: 'two', three: 4, five: ['six', 7], eight: { nine: 'ten', eleven: ['twelve', 13] } }
      Lite::Redis::List.create(:example, response)

      expect(Lite::Redis::List.find(:example)).to eq(response)
    end
  end

  describe '.first' do
    it 'to be nil' do
      expect(Lite::Redis::List.first(:example)).to eq(nil)
    end

    it 'to be "three"' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 2)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.first(:example)).to eq('three')
    end

    it 'to be ["three", "2"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 2)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.first(:example, 2)).to eq(['three', '2'])
    end

    it 'to be ["three", "2", "one"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 2)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.first(:example, 4)).to eq(['three', '2', 'one'])
    end
  end

  describe '.last' do
    it 'to be nil' do
      expect(Lite::Redis::List.last(:example)).to eq(nil)
    end

    it 'to be "one"' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 'two')
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.last(:example)).to eq('one')
    end

    it 'to be ["2", "one"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 2)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.last(:example, 2)).to eq(['2', 'one'])
    end

    it 'to be ["three", "2", "one"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 2)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.last(:example, 4)).to eq(['three', '2', 'one'])
    end
  end

  describe '.between' do
    it 'to be nil' do
      expect(Lite::Redis::List.between(:example)).to eq(nil)
    end

    it 'to be ["2"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 2)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.between(:example, 2, 2)).to eq(['2'])
    end

    it 'to be ["2", "one"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 2)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.between(:example, 2, 3)).to eq(['2', 'one'])
    end

    it 'to be ["three", "2", "one"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 2)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.between(:example)).to eq(['three', '2', 'one'])
    end
  end

  describe '.all' do
    it 'to be nil' do
      expect(Lite::Redis::List.all(:example)).to eq(nil)
    end

    it 'to be ["three", "2", "one"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 2)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.all(:example)).to eq(['three', '2', 'one'])
    end
  end

  describe '.count' do
    it 'to be 0' do
      expect(Lite::Redis::List.count(:example)).to eq(0)
    end

    it 'to be 3' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 'two')
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.count(:example)).to eq(3)
    end
  end

  describe '.create' do
    it 'to be ["1"], ["2"], ["3"], ["4"]' do
      Lite::Redis::List.create('example_1', '1')

      expect(Lite::Redis::List.all('example_1')).to eq(['1'])
    end

    it 'to be ["three", "2", "1"]' do
      Lite::Redis::List.create(:example, '1')
      Lite::Redis::List.create(:example, 2)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.all(:example)).to eq(['three', '2', '1'])
    end

    it 'to be ["four", "three", "2", "1"]' do
      Lite::Redis::List.create(:example, ['1', '2', 'three', 'four'])

      expect(Lite::Redis::List.all(:example)).to eq(['four', 'three', '2', '1'])
    end

    it 'to be ["three", "2", "1"]' do
      Lite::Redis::List.create(:example, '1')
      Lite::Redis::List.create(:example, 2, :prepend)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.all(:example)).to eq(['three', '2', '1'])
    end

    it 'to be ["four", "three", "2", "1"]' do
      Lite::Redis::List.create(:example, ['1', '2', 'three', 'four'], :prepend)

      expect(Lite::Redis::List.all(:example)).to eq(['four', 'three', '2', '1'])
    end

    it 'to be ["three", "1", "2"]' do
      Lite::Redis::List.create(:example, '1')
      Lite::Redis::List.create(:example, 2, :append)
      Lite::Redis::List.create(:example, 'three')

      expect(Lite::Redis::List.all(:example)).to eq(['three', '1', '2'])
    end

    it 'to be ["1", "2", "three", "four"]' do
      Lite::Redis::List.create(:example, ['1', '2', 'three', 'four'], :append)

      expect(Lite::Redis::List.all(:example)).to eq(['1', '2', 'three', 'four'])
    end
  end

  describe '.create!' do
    it 'to be nil' do
      Lite::Redis::List.create!(:example, 2)

      expect(Lite::Redis::List.all(:example)).to eq(nil)
    end

    it 'to be nil' do
      Lite::Redis::List.create!(:example, [1, 2, 3, 4])

      expect(Lite::Redis::List.all(:example)).to eq(nil)
    end

    it 'to be ["three", "2", "1"]' do
      Lite::Redis::List.create(:example, '1')
      Lite::Redis::List.create!(:example, 2)
      Lite::Redis::List.create!(:example, 'three')

      expect(Lite::Redis::List.all(:example)).to eq(['three', '2', '1'])
    end

    it 'to be ["four", "three", "2", "1"]' do
      Lite::Redis::List.create(:example, '1')
      Lite::Redis::List.create!(:example, [2, 'three', 'four'])

      expect(Lite::Redis::List.all(:example)).to eq(['four', 'three', '2', '1'])
    end

    it 'to be ["three", "2", "1"]' do
      Lite::Redis::List.create(:example, '1')
      Lite::Redis::List.create!(:example, 2, :prepend)
      Lite::Redis::List.create!(:example, 'three')

      expect(Lite::Redis::List.all(:example)).to eq(['three', '2', '1'])
    end

    it 'to be ["four", "three", "2", "1"]' do
      Lite::Redis::List.create(:example, '1')
      Lite::Redis::List.create!(:example, [2, 'three', 'four'], :prepend)

      expect(Lite::Redis::List.all(:example)).to eq(['four', 'three', '2', '1'])
    end

    it 'to be ["three", "1", "2"]' do
      Lite::Redis::List.create(:example, '1')
      Lite::Redis::List.create!(:example, 2, :append)
      Lite::Redis::List.create!(:example, 'three')

      expect(Lite::Redis::List.all(:example)).to eq(['three', '1', '2'])
    end

    it 'to be ["1", "2", "three", "four"]' do
      Lite::Redis::List.create(:example, '1')
      Lite::Redis::List.create!(:example, [2, 'three', 'four'], :append)

      expect(Lite::Redis::List.all(:example)).to eq(['1', '2', 'three', 'four'])
    end
  end

  describe '.create_limit' do
    it 'to be ["three", "two"]' do
      Lite::Redis::List.create_limit(:example, 'one', 2)
      Lite::Redis::List.create_limit(:example, 'two', 2)
      Lite::Redis::List.create_limit(:example, 'three', 2)

      expect(Lite::Redis::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four", "three", "two"]' do
      Lite::Redis::List.create_limit(:example, ['one', 'two', 'three', 'four'], 3)

      expect(Lite::Redis::List.all(:example)).to eq(['four', 'three', 'two'])
    end

    it 'to be ["three", "two"]' do
      Lite::Redis::List.create_limit(:example, 'one', 2)
      Lite::Redis::List.create_limit(:example, 'two', 2, :prepend)
      Lite::Redis::List.create_limit(:example, 'three', 2)

      expect(Lite::Redis::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four", "three", "two"]' do
      Lite::Redis::List.create_limit(:example, ['one', 'two', 'three', 'four'], 3, :prepend)

      expect(Lite::Redis::List.all(:example)).to eq(['four', 'three', 'two'])
    end

    it 'to be ["three", "one"]' do
      Lite::Redis::List.create_limit(:example, 'one', 2)
      Lite::Redis::List.create_limit(:example, 'two', 2, :append)
      Lite::Redis::List.create_limit(:example, 'three', 2)

      expect(Lite::Redis::List.all(:example)).to eq(['three', 'one'])
    end

    it 'to be ["one", "two", "three"]' do
      Lite::Redis::List.create_limit(:example, ['one', 'two', 'three', 'four'], 3, :append)

      expect(Lite::Redis::List.all(:example)).to eq(['one', 'two', 'three'])
    end
  end

  describe '.create_limit!' do
    it 'to be nil' do
      Lite::Redis::List.create_limit!(:example, 'one', 2)
      Lite::Redis::List.create_limit!(:example, 'two', 2)
      Lite::Redis::List.create_limit!(:example, 'three', 2)

      expect(Lite::Redis::List.all(:example)).to eq(nil)
    end

    it 'to be nil' do
      Lite::Redis::List.create_limit!(:example, ['one', 'two', 'three'], 2)

      expect(Lite::Redis::List.all(:example)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      Lite::Redis::List.create_limit(:example, 'one', 2)
      Lite::Redis::List.create_limit!(:example, 'two', 2)
      Lite::Redis::List.create_limit!(:example, 'three', 2)

      expect(Lite::Redis::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four", "three", "two"]' do
      Lite::Redis::List.create_limit(:example, 'one', 3)
      Lite::Redis::List.create_limit!(:example, ['two', 'three', 'four'], 3)

      expect(Lite::Redis::List.all(:example)).to eq(['four', 'three', 'two'])
    end

    it 'to be ["three", "two"]' do
      Lite::Redis::List.create_limit(:example, 'one', 2)
      Lite::Redis::List.create_limit!(:example, 'two', 2, :prepend)
      Lite::Redis::List.create_limit!(:example, 'three', 2)

      expect(Lite::Redis::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four", "three", "two"]' do
      Lite::Redis::List.create_limit(:example, 'one', 3)
      Lite::Redis::List.create_limit!(:example, ['two', 'three', 'four'], 3, :prepend)

      expect(Lite::Redis::List.all(:example)).to eq(['four', 'three', 'two'])
    end

    it 'to be ["three", "one"]' do
      Lite::Redis::List.create_limit(:example, 'one', 2)
      Lite::Redis::List.create_limit!(:example, 'two', 2, :append)
      Lite::Redis::List.create_limit!(:example, 'three', 2)

      expect(Lite::Redis::List.all(:example)).to eq(['three', 'one'])
    end

    it 'to be ["one", "two", "three"]' do
      Lite::Redis::List.create_limit(:example, 'one', 3)
      Lite::Redis::List.create_limit!(:example, ['two', 'three', 'four'], 3, :append)

      expect(Lite::Redis::List.all(:example)).to eq(['one', 'two', 'three'])
    end
  end

  describe '.create_before' do
    it 'to be ["three", "four", "two", "one"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 'two')
      Lite::Redis::List.create(:example, 'three')

      Lite::Redis::List.create_before(:example, 'two', 'four')

      expect(Lite::Redis::List.all(:example)).to eq(['three', 'four', 'two', 'one'])
    end
  end

  describe '.create_after' do
    it 'to be ["three", "two", "four", "one"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 'two')
      Lite::Redis::List.create(:example, 'three')

      Lite::Redis::List.create_after(:example, 'two', 'four')

      expect(Lite::Redis::List.all(:example)).to eq(['three', 'two', 'four', 'one'])
    end
  end

  describe '.update' do
    it 'to be nil' do
      expect(Lite::Redis::List.update(:example, 1, 'v1')).to eq(nil)
    end

    it 'to be ["four", "five", "three"]' do
      Lite::Redis::List.create(:example, 'one', :append)
      Lite::Redis::List.create(:example, 'two', :append)
      Lite::Redis::List.create(:example, 'three', :append)

      Lite::Redis::List.update(:example, 0, 'four')
      Lite::Redis::List.update(:example, -2, 'five')

      expect(Lite::Redis::List.all(:example)).to eq(['four', 'five', 'three'])
    end
  end

  describe '.move' do
    it 'to be nil' do
      expect(Lite::Redis::List.move(:example1, :example2)).to eq(nil)
    end

    it 'to be "3"' do
      Lite::Redis::List.create(:example1, 1, :append)
      Lite::Redis::List.create(:example1, 'two', :append)
      Lite::Redis::List.create(:example1, '3', :append)

      expect(Lite::Redis::List.move(:example1, :example2)).to eq('3')
    end

    it 'to be ["1", "two", "3"]' do
      Lite::Redis::List.create(:example1, 1, :append)
      Lite::Redis::List.create(:example1, 'two', :append)
      Lite::Redis::List.create(:example1, '3', :append)

      Lite::Redis::List.move(:example1, :example2)

      expect(Lite::Redis::List.all(:example1)).to eq(['1', 'two'])
    end

    it 'to be ["1", "two", "3"]' do
      Lite::Redis::List.create(:example1, 1, :append)
      Lite::Redis::List.create(:example1, 'two', :append)
      Lite::Redis::List.create(:example1, '3', :append)

      Lite::Redis::List.move(:example1, :example2)

      expect(Lite::Redis::List.all(:example2)).to eq(['3'])
    end
  end

  describe '.move_blocking' do
    # TODO
  end

  describe '.destroy' do
    it 'to be 0' do
      expect(Lite::Redis::List.destroy(:example, 1, 'v1')).to eq(0)
    end

    it 'to be 2' do
      Lite::Redis::List.create(:example, 'v1', :append)
      Lite::Redis::List.create(:example, 'v2', :append)
      Lite::Redis::List.create(:example, 'v2', :append)
      Lite::Redis::List.create(:example, 'v2', :append)
      Lite::Redis::List.create(:example, 'v1', :append)

      Lite::Redis::List.destroy(:example, 1, 'v1')
      Lite::Redis::List.destroy(:example, -2, 'v2')

      expect(Lite::Redis::List.count(:example)).to eq(2)
    end
  end

  describe '.destroy_first' do
    it 'to be nil' do
      expect(Lite::Redis::List.destroy_first(:example)).to eq(nil)
    end

    it 'to be ["two", "one"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 'two')
      Lite::Redis::List.create(:example, 'three')

      Lite::Redis::List.destroy_first(:example)

      expect(Lite::Redis::List.all(:example)).to eq(['two', 'one'])
    end

    it 'to be ["one"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 'two')
      Lite::Redis::List.create(:example, 'three')
      Lite::Redis::List.create(:example, 'four')

      Lite::Redis::List.destroy_first(:example, 3)

      expect(Lite::Redis::List.all(:example)).to eq(['one'])
    end
  end

  describe '.destroy_last' do
    it 'to be nil' do
      expect(Lite::Redis::List.destroy_last(:example)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 'two')
      Lite::Redis::List.create(:example, 'three')

      Lite::Redis::List.destroy_last(:example)

      expect(Lite::Redis::List.all(:example)).to eq(['three', 'two'])
    end

    it 'to be ["four"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 'two')
      Lite::Redis::List.create(:example, 'three')
      Lite::Redis::List.create(:example, 'four')

      Lite::Redis::List.destroy_last(:example, 3)

      expect(Lite::Redis::List.all(:example)).to eq(['four'])
    end
  end

  describe '.destroy_except' do
    it 'to be nil' do
      expect(Lite::Redis::List.destroy_except(:example, 2, 3)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 'two')
      Lite::Redis::List.create(:example, 'three')
      Lite::Redis::List.create(:example, 'four')

      Lite::Redis::List.destroy_except(:example, 2, 3)

      expect(Lite::Redis::List.all(:example)).to eq(['three', 'two'])
    end
  end

  describe '.destroy_all' do
    it 'to be nil' do
      expect(Lite::Redis::List.destroy_all(:example)).to eq(nil)
    end

    it 'to be nil' do
      Lite::Redis::List.create(:example, 'one')
      Lite::Redis::List.create(:example, 'two')
      Lite::Redis::List.create(:example, 'three')

      Lite::Redis::List.destroy_all(:example)

      expect(Lite::Redis::List.all(:example)).to eq(nil)
    end
  end

  describe '.pop' do
    it 'to be nil' do
      expect(Lite::Redis::List.pop(:example)).to eq(nil)
    end

    it 'to be "one"' do
      Lite::Redis::List.create(:example, 'one', :append)
      Lite::Redis::List.create(:example, 'two', :append)
      Lite::Redis::List.create(:example, 'three', :append)

      expect(Lite::Redis::List.pop(:example)).to eq('one')
    end

    it 'to be "three"' do
      Lite::Redis::List.create(:example, 'one', :append)
      Lite::Redis::List.create(:example, 'two', :append)
      Lite::Redis::List.create(:example, 'three', :append)

      expect(Lite::Redis::List.pop(:example, :append)).to eq('three')
    end

    it 'to be ["two", "three"]' do
      Lite::Redis::List.create(:example, 'one', :append)
      Lite::Redis::List.create(:example, 'two', :append)
      Lite::Redis::List.create(:example, 'three', :append)
      Lite::Redis::List.pop(:example)

      expect(Lite::Redis::List.all(:example)).to eq(['two', 'three'])
    end

    it 'to be ["one", "two"]' do
      Lite::Redis::List.create(:example, 'one', :append)
      Lite::Redis::List.create(:example, 'two', :append)
      Lite::Redis::List.create(:example, 'three', :append)
      Lite::Redis::List.pop(:example, :append)

      expect(Lite::Redis::List.all(:example)).to eq(['one', 'two'])
    end
  end

  describe '.pop_blocking' do
    # TODO
  end

end
