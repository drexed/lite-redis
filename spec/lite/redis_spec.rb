# frozen_string_literal: true

RSpec.describe Lite::Redis do
  it "to be a version number" do
    expect(Lite::Redis::VERSION).not_to be_nil
  end
end
