# frozen_string_literal: false

require "spec_helper"

RSpec.describe Lite::Redis::String do

  describe ".find" do
    it "to be nil" do
      expect(described_class.find(:example)).to be_nil
    end

    it 'to be "123"' do
      described_class.create(:example1, "123")
      described_class.create(:example2, 123)

      expect(described_class.find(:example1)).to eq("123")
      expect(described_class.find(:example2)).to eq("123")
    end
  end

  describe ".find_each" do
    it "to be [nil, nil]" do
      expect(described_class.find_each(:example, :example2)).to eq([nil, nil])
    end

    it 'to be ["one", "two"]' do
      described_class.create("example", "one")
      described_class.create("example2", "two")

      expect(described_class.find_each("example", "example2")).to eq(%w[one two])
    end

    it 'to be ["1", "2"]' do
      described_class.create("example", "1")
      described_class.create("example2", 2)

      expect(described_class.find_each("example", "example2")).to eq(%w[1 2])
    end
  end

  describe ".length" do
    it "to be 11" do
      described_class.create(:example, "hello world")

      expect(described_class.length(:example)).to eq(11)
    end
  end

  describe ".split" do
    it "to be nil" do
      expect(described_class.split(:example, 0, 3)).to be_nil
    end

    it 'to be "hel"' do
      described_class.create(:example, "hello world")

      expect(described_class.split(:example, 0, 2)).to eq("hel")
    end
  end

  describe ".create" do
    it 'to be "1"' do
      described_class.create(:example, "1")

      expect(described_class.find(:example)).to eq("1")
    end

    it 'to be "2"' do
      described_class.create(:example, "1")
      described_class.create(:example, "2")

      expect(described_class.find(:example)).to eq("2")
    end

    it 'to be "1" with nx option' do
      described_class.create(:example, "1")
      described_class.create(:example, "2", nx: true)

      expect(described_class.find(:example)).to eq("1")
    end

    it "to be nil" do
      described_class.create(:example, "1", xx: true)

      expect(described_class.find(:example)).to be_nil
    end

    it 'to be "1" with ex option' do
      described_class.create(:example, "1", ex: 1)

      expect(described_class.find(:example)).to eq("1")
    end
  end

  describe ".create!" do
    it 'to be "1"' do
      described_class.create!(:example, "1")

      expect(described_class.find(:example)).to eq("1")
    end

    it 'to be "1" when trying to override' do
      described_class.create(:example, "1")
      described_class.create!(:example, "2")

      expect(described_class.find(:example)).to eq("1")
    end
  end

  describe ".create_each" do
    it 'to be "world"' do
      described_class.create_each(:example, "hello", :example2, "world")

      expect(described_class.find(:example2)).to eq("world")
    end
  end

  describe ".create_each!" do
    it 'to be "hello"' do
      described_class.create_each!(:example, "hello", :example2, "world")

      expect(described_class.find(:example)).to eq("hello")
    end
  end

  describe ".create_until" do
    it "to be nil" do
      described_class.create_until(:example, "hello", 2)
      sleep(3)

      expect(described_class.find(:example)).to be_nil
    end
  end

  describe ".append" do
    it 'to be "hello"' do
      expect(described_class.append(:example, "hello")).to eq("hello")
    end

    it 'to be "hello world"' do
      described_class.create(:example, "hello")
      described_class.append(:example, " world")

      expect(described_class.find(:example)).to eq("hello world")
    end
  end

  describe ".replace" do
    it "to be nil" do
      expect(described_class.replace(:example, "hello", 6)).to be_nil
    end

    it 'to be "hello redis"' do
      described_class.create(:example, "hello world")
      described_class.replace(:example, "redis", 6)

      expect(described_class.find(:example)).to eq("hello redis")
    end
  end

  describe ".decrement" do
    it "to be -1" do
      expect(described_class.decrement("example")).to eq(-1)
    end

    it "to be 1" do
      described_class.create("example", 2)

      expect(described_class.decrement("example")).to eq(1)
    end

    it "to be 3" do
      described_class.create("example", 5)

      expect(described_class.decrement("example", 2)).to eq(3)
    end
  end

  describe ".increment" do
    it "to be 1" do
      expect(described_class.increment("example")).to eq(1)
    end

    it "to be 2" do
      described_class.create("example", 1)

      expect(described_class.increment("example")).to eq(2)
    end

    it "to be 5" do
      described_class.create(:example, 1)

      expect(described_class.increment("example", 4)).to eq(5)
    end
  end

  describe ".reset" do
    it "to be nil" do
      expect(described_class.reset(:example)).to be_nil
    end

    it 'to be "0"' do
      described_class.create(:example, 2)
      described_class.reset(:example)

      expect(described_class.find(:example)).to eq("0")
    end

    it 'to be "2"' do
      described_class.create(:example, 4)
      described_class.reset(:example, 2)

      expect(described_class.find(:example)).to eq("2")
    end
  end

  describe ".bit_count" do
    it "to be 0" do
      expect(described_class.bit_count(:example)).to eq(0)
    end

    it "to be 26" do
      described_class.create(:example, "foobar")

      expect(described_class.bit_count(:example)).to eq(26)
    end

    it "to be 4" do
      described_class.create(:example, "foobar")

      expect(described_class.bit_count(:example, 0, 0)).to eq(4)
    end

    it "to be 6" do
      described_class.create(:example, "foobar")

      expect(described_class.bit_count(:example, 1, 1)).to eq(6)
    end

    it "to be 10" do
      described_class.create(:example, "foobar")

      expect(described_class.bit_count(:example, 0, 1)).to eq(10)
    end
  end

  describe ".bit_where" do
    it "to be ..." do
      described_class.create(:sample1, "abc")
      described_class.create(:sample2, 123)

      described_class.bit_where(:and, "sample1&2", :sample1, :sample2)
      described_class.bit_where(:or, "sample1|2", :sample1, :sample2)
      described_class.bit_where(:xor, "sample1^2", :sample1, :sample2)
      # Lite::Redis::String.bit_where(:not, 'sample1~2', :sample1, :sample2)

      expect(described_class.find("sample1&2")).to eq('!"#')
      expect(described_class.find("sample1|2")).to eq("qrs")
      expect(described_class.find("sample1^2")).to eq("PPP")
      # expect(Lite::Redis::String.find('sample1~2')).to eq('qrs')
    end
  end

  describe ".get_bit" do
    it "to be 0" do
      described_class.create(:example, "a")

      expect(described_class.get_bit(:example, 3)).to eq(0)
      expect(described_class.get_bit(:example, 4)).to eq(0)
      expect(described_class.get_bit(:example, 5)).to eq(0)
      expect(described_class.get_bit(:example, 6)).to eq(0)
    end

    it "to be 1" do
      described_class.create(:example, "a")

      expect(described_class.get_bit(:example, 1)).to eq(1)
      expect(described_class.get_bit(:example, 2)).to eq(1)
      expect(described_class.get_bit(:example, 7)).to eq(1)
    end
  end

  describe ".set_bit" do
    it "to be 0" do
      described_class.set_bit(:example, 10, 0)

      expect(described_class.set_bit(:example, 10, 0)).to eq(0)
      expect(described_class.set_bit(:example, 10, 1)).to eq(0)
    end

    it "to be 1" do
      described_class.set_bit(:example, 10, 1)

      expect(described_class.get_bit(:example, 10)).to eq(1)
    end
  end

end
