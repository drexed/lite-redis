# frozen_string_literal: true

module AcceptanceHelper

  def verify!
    expect(results).to eq(template)
  end

end
