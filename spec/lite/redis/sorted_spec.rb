# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::SortedSet do

  describe '.find' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.find(:example, 1)).to eq(nil)
    end

    it 'to be "two"' do
      Lite::Redis::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(Lite::Redis::SortedSet.find(:example, 2)).to eq('two')
    end

    it 'should return ["1", 1.0]' do
      Lite::Redis::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(Lite::Redis::SortedSet.find(:example, 1, with_scores: true)).to eq(['1', 1.0])
    end
  end

  describe '.find_score' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.find_score(:example, 1)).to eq(nil)
    end

    it 'to be "two"' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.find_score(:example, 2)).to eq('2')
    end

    it 'should return ["1", 1.0]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.find_score(:example, 1, with_scores: true)).to eq(['one', 1.0])
    end
  end

  describe '.first' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.first(:example)).to eq(nil)
    end

    it 'to be "1"' do
      Lite::Redis::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(Lite::Redis::SortedSet.first(:example)).to eq('1')
    end

    it 'should return ["1", 1.0]' do
      Lite::Redis::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(Lite::Redis::SortedSet.first(:example, with_scores: true)).to eq(['1', 1.0])
    end
  end

  describe '.first_score' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.first_score(:example)).to eq(nil)
    end

    it 'to be "1"' do
      Lite::Redis::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(Lite::Redis::SortedSet.first_score(:example)).to eq('1')
    end

    it 'should return ["1", 1.0]' do
      Lite::Redis::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(Lite::Redis::SortedSet.first_score(:example, with_scores: true)).to eq(['1', 1.0])
    end
  end

  describe '.last' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.last(:example)).to eq(nil)
    end

    it 'to be "3"' do
      Lite::Redis::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(Lite::Redis::SortedSet.last(:example)).to eq('3')
    end

    it 'should return ["3", 3.0]' do
      Lite::Redis::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(Lite::Redis::SortedSet.last(:example, with_scores: true)).to eq(['3', 3.0])
    end
  end

  describe '.last_score' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.last_score(:example)).to eq(nil)
    end

    it 'to be "1"' do
      Lite::Redis::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(Lite::Redis::SortedSet.last_score(:example)).to eq('1')
    end

    it 'should return ["1", 1.0]' do
      Lite::Redis::SortedSet.create(:example, 1, 1, 2, 'two', 3, '3')

      expect(Lite::Redis::SortedSet.last_score(:example, with_scores: true)).to eq(['1', 1.0])
    end
  end

  describe '.between' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.between(:example, 1, 2)).to eq(nil)
    end

    it 'to be ["one", "two"]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, 'two', 3, 'three')

      expect(Lite::Redis::SortedSet.between(:example, 1, 2)).to eq(['one', 'two'])
    end

    it 'should return [["one", 1.0], ["2", 2.0]]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.between(:example, 1, 2, with_scores: true)).to eq([['one', 1.0], ['2', 2.0]])
    end
  end

  describe '.between_reverse' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.between_reverse(:example, 1, 2)).to eq(nil)
    end

    it 'to be ["three", "two"]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, 'two', 3, 'three')

      expect(Lite::Redis::SortedSet.between_reverse(:example, 1, 2)).to eq(['three', 'two'])
    end

    it 'should return [["three", 3.0], ["2", 2.0]]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.between_reverse(:example, 1, 2, with_scores: true)).to eq([['three', 3.0], ['2', 2.0]])
    end
  end

  describe '.between_scores' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.between_scores(:example, 1, 2)).to eq(nil)
    end

    it 'to be nil' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.between_scores(:example, 100, 1)).to eq(nil)
    end

    it 'to be ["one", "2", "three"]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.between_scores(:example, 1, 100)).to eq(['one', '2', 'three'])
    end

    it 'to be ["one", "2"]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.between_scores(:example, 1, 2)).to eq(['one', '2'])
    end

    it 'should return [["one", 1.0], ["2", 2.0]]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.between_scores(:example, 1, 2, with_scores: true)).to eq([['one', 1.0], ['2', 2.0]])
    end
  end

  describe '.between_scores_reverse' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.between_scores_reverse(:example, 1, 2)).to eq(nil)
    end

    it 'to be nil' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.between_scores_reverse(:example, 1, 100)).to eq(nil)
    end

    it 'to be ["three", "2", "one"]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.between_scores_reverse(:example, 100, 1)).to eq(['three', '2', 'one'])
    end

    it 'to be ["2", "one"]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.between_scores_reverse(:example, 2, 1)).to eq(['2', 'one'])
    end

    it 'should return [["2", 2.0], ["one", 1.0]]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.between_scores_reverse(:example, 2, 1, with_scores: true)).to eq([['2', 2.0], ['one', 1.0]])
    end
  end

  describe '.between_lex' do
    # TODO
  end
  describe '.between_lex_reverse' do
    # TODO
  end

  describe '.all' do
    it 'to be ["one", "2", "three"]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.all(:example)).to eq(%w[one 2 three])
    end

    it 'to be [["one", 1.0], ["2", 2.0], ["three", 3.0]]' do
      array = [["one", 1.0], ["2", 2.0], ["three", 3.0]]
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.all(:example, with_scores: true)).to eq(array)
    end
  end

  describe '.all_reverse' do
    it 'to be ["three", "2", "one"]' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.all_reverse(:example)).to eq(%w[three 2 one])
    end

    it 'to be [["three", 3.0], ["2", 2.0], ["one", 1.0]]' do
      array = [["three", 3.0], ["2", 2.0], ["one", 1.0]]
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.all_reverse(:example, with_scores: true)).to eq(array)
    end
  end

  describe '.position' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.position(:example, 'one')).to eq(nil)
    end

    it 'to be nil' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.position(:example, 'four')).to eq(nil)
    end

    it 'to be 3' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.position(:example, 'three')).to eq(3)
    end
  end

  describe '.position_reverse' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.position_reverse(:example, 'one')).to eq(nil)
    end

    it 'to be nil' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.position_reverse(:example, 'four')).to eq(nil)
    end

    it 'to be 3' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.position_reverse(:example, 'three')).to eq(1)
    end
  end

  describe '.score' do
    it 'to be nil' do
      expect(Lite::Redis::SortedSet.score(:example, 'one')).to eq(nil)
    end

    it 'to be nil' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.score(:example, 'four')).to eq(nil)
    end

    it 'to be 3' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.score(:example, 'three')).to eq(3.0)
    end
  end

  describe '.count' do
    it 'to be 0' do
      expect(Lite::Redis::SortedSet.count(:example)).to eq(0)
    end

    it 'to be 3' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.count(:example)).to eq(3)
    end
  end

  describe '.count_between' do
    it 'to be 0' do
      expect(Lite::Redis::SortedSet.count_between(:example, 2, 3)).to eq(0)
    end

    it 'to be 2' do
      Lite::Redis::SortedSet.create(:example, 1, 'one', 2, '2', 3, 'three')

      expect(Lite::Redis::SortedSet.count_between(:example, 2, 3)).to eq(2)
    end
  end

  describe '.create' do
    it 'to be 2' do
      Lite::Redis::SortedSet.create(:example, 1, 'one')

      expect(Lite::Redis::SortedSet.between(:example, 1, 1)).to eq(['one'])
    end
  end

  describe '.create_intersection' do
    # TODO
  end

  describe '.create_combination' do
    # TODO
  end

  describe '.increment' do
    it 'to be 3' do
      Lite::Redis::SortedSet.create(:example, 1, 'one')

      expect(Lite::Redis::SortedSet.increment(:example, 'one', 2)).to eq(3)
      expect(Lite::Redis::SortedSet.score(:example, 'one')).to eq(3)
    end
  end

  describe '.decrement' do
    it 'to be -1' do
      Lite::Redis::SortedSet.create(:example, 1, 'one')

      expect(Lite::Redis::SortedSet.decrement(:example, 'one', 2)).to eq(-1)
      expect(Lite::Redis::SortedSet.score(:example, 'one')).to eq(-1)
    end
  end

  describe '.destroy' do
    it 'to be 2' do
      Lite::Redis::SortedSet.create(:example, 1, 'one')
      Lite::Redis::SortedSet.create(:example, 2, 'two')
      Lite::Redis::SortedSet.create(:example, 3, 'three')

      expect(Lite::Redis::SortedSet.destroy(:example, 'two')).to eq(true)
      expect(Lite::Redis::SortedSet.find(:example, 2)).to eq('three')
    end
  end

  describe '.destroy_between' do
    it 'to be 0' do
      expect(Lite::Redis::SortedSet.destroy_between(:example, 1, 2)).to eq(0)
    end

    it 'to be 2' do
      Lite::Redis::SortedSet.create(:example, 1, 'one')
      Lite::Redis::SortedSet.create(:example, 2, 'two')
      Lite::Redis::SortedSet.create(:example, 3, 'three')

      expect(Lite::Redis::SortedSet.destroy_between(:example, 1, 2)).to eq(2)
      expect(Lite::Redis::SortedSet.count(:example)).to eq(1)
    end
  end

  describe '.destroy_scores' do
    it 'to be 0' do
      expect(Lite::Redis::SortedSet.destroy_scores(:example, 1, 2)).to eq(0)
    end

    it 'to be 2' do
      Lite::Redis::SortedSet.create(:example, 1, 'one')
      Lite::Redis::SortedSet.create(:example, 2, 'two')
      Lite::Redis::SortedSet.create(:example, 3, 'three')

      expect(Lite::Redis::SortedSet.destroy_scores(:example, 0, 2)).to eq(2)
      expect(Lite::Redis::SortedSet.count(:example)).to eq(1)
    end
  end

  describe '.destroy_lex' do
    # TODO
  end

  describe '.scan' do
    # TODO
  end

end
