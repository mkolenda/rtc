require 'rails_helper'

RSpec.describe Proposal, type: :model do
  subject {
    described_class.new(
      title: 'Boom goes the dynamite',
      body: 'The quick brown fox jumped over the lazy dog',
      reviewed: true,
      author_id: 1
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title.clear
    expect(subject).to_not be_valid
  end

  it "is not valid without a body" do
    subject.body.clear
    expect(subject).to_not be_valid
  end

  it "is not valid without being reviewed" do
    subject.reviewed = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an author" do
    subject.author_id = nil
    expect(subject).to_not be_valid
  end

  it "has many drafts" do
    assoc = described_class.reflect_on_association(:drafts)
    expect(assoc.macro).to eq :has_many
  end

  it "belongs to an author" do
    assoc = described_class.reflect_on_association(:author)
    expect(assoc.macro).to eq :belongs_to
  end

  it "has one current draft" do
    assoc = described_class.reflect_on_association(:current_draft)
    expect(assoc.macro).to eq :has_one
  end
end
