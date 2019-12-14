require 'rails_helper'

RSpec.describe ExternalLink, type: :model do
  subject {
    described_class.new(
      title: 'www.example.com',
      current: true,
      draft_id: 1
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title.clear
    expect(subject).to_not be_valid
  end

  it "is not valid without a current status" do
    subject.current = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a draft" do
    subject.draft_id = nil
    expect(subject).to_not be_valid
  end

  it "references a draft" do
    assoc = described_class.reflect_on_association(:draft)
    expect(assoc.macro).to eq :belongs_to
  end
end
