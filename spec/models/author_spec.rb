require 'rails_helper'

RSpec.describe Author, type: :model do
  subject {
    described_class.new(
      name: 'Oscar Wilde'
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name.clear
    expect(subject).to_not be_valid
  end

  it "has many proposals" do
    assoc = described_class.reflect_on_association(:proposals)
    expect(assoc.macro).to eq :has_many
  end
end
