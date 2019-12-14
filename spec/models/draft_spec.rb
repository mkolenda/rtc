require 'rails_helper'

RSpec.describe Draft, type: :model do
  subject {
    described_class.new(
      proposal_id: 1,
      author_id: 1,
      version: 1,
      written_at: DateTime.now,
      state: 'new'
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a proposal" do
    subject.proposal_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an author" do
    subject.author_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a version" do
    subject.version = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a written_at timestamp" do
    subject.written_at = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a state" do
    subject.state.clear
    expect(subject).to_not be_valid
  end

  it "belongs to a proposal" do
    assoc = described_class.reflect_on_association(:proposal)
    expect(assoc.macro).to eq :belongs_to
  end

  it "belongs to an author" do
    assoc = described_class.reflect_on_association(:author)
    expect(assoc.macro).to eq :belongs_to
  end

  it "has many external links" do
    assoc = described_class.reflect_on_association(:external_links)
    expect(assoc.macro).to eq :has_many
  end
end
