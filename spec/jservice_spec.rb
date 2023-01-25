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
  
  it "can handle options for clues" do
    clues = jservice.clues(value: 100)
    expect(clues.all?{_1["value"] == 100}).to be true
  end
  
  it "can request random clues" do
    clues = jservice.random_clues()
    expect(clues.size).to eq(1)
  end
  
  it "can request random final clues" do
    clues = jservice.random_finals(1)
    expect(clues.size).to eq(1)
  end
  
  it "can request categories" do
    clues = jservice.categories()
    expect(clues.size).to eq(1)
  end
  
  it "can request specific categories" do
    clues = jservice.category(1)
    expect(clues["id"]).to eq(1)
  end
end
