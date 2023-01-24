# frozen_string_literal: true

RSpec.describe Jservice do
  jservice = Jservice.new()

  it "has a version number" do
    expect(Jservice::VERSION).not_to be nil
  end

  it "can request clues" do
    clues = jservice.clues()
    expect(clues.size).to eq(100)
  end
end
