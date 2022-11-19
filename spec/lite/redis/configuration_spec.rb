# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lite::Redis::Configuration do
  after { Lite::Redis.reset_configuration! }

  describe "#configure" do
    it 'to be "foo"' do
      Lite::Redis.configuration.client = "foo"

      expect(Lite::Redis.configuration.client).to eq("foo")
    end
  end

  describe "#reset_configuration!" do
    it "to be true" do
      Lite::Redis.configuration.client = "foo"
      Lite::Redis.reset_configuration!

      expect(Lite::Redis.configuration.client.is_a?(Redis)).to be(true)
    end
  end

end
