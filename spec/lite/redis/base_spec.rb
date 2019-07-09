# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Lite::Redis::Base do

  describe '#caller' do
    it 'to be "123"' do
      string = Lite::Redis::String.new
      string.create(:example1, '123')

      expect(string.find(:example1)).to eq('123')
    end
  end

end
