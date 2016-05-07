require 'rails_helper'

describe Proposal do
  describe "#create_draft!" do
    let(:proposal){ FactoryGirl.create(:proposal) }
    let(:author) {proposal.author}

    let(:state) { "Test State" }
    let(:draft_attributes) {{ state: state }}

    describe "First Draft" do
      it "Creates the first draft when no other drafts are present" do
        proposal.should_receive(:create_first_draft!).once

        proposal.create_draft!(draft_attributes, author.id)
      end

      it "Creates a first draft with default parameters if no attributes are passed" do
        new_draft = proposal.create_draft!(nil, author.id)

        expect(new_draft.author).to eq(author)
        expect(new_draft.state).to eq("New")
        expect(new_draft.version).to eq(1)
      end

      it "Allows the state to be named differently, given attributes" do
        new_draft = proposal.create_draft!(draft_attributes, author.id)

        expect(new_draft.state).to eq("Test State")
      end
    end

    describe "Subsequent Drafts" do
      it "Updates the current_draft to be newly created draft" do
        first_draft  = proposal.create_draft!(nil, author.id)
        expect(proposal.reload.current_draft).to eq(first_draft)

        second_draft = proposal.create_draft!(draft_attributes, author.id)
        expect(proposal.reload.current_draft).to eq(second_draft)
      end

      it "Increments the version when creating new drafts" do
        first_draft  = proposal.create_draft!(nil, author.id)
        expect(first_draft.version).to eq(1)

        second_draft = proposal.create_draft!(draft_attributes, author.id)
        expect(second_draft.version).to eq(2)
      end

      it "Sets the previous current_drafts external_links' current attribute to false when creating a new draft" do
        first_draft  = proposal.create_draft!(nil, author.id)
        external_link = first_draft.external_links.create(title: "Test Title")

        second_draft = proposal.create_draft!(draft_attributes, author.id)

        expect(external_link.reload.current).to be(false)
      end
    end
  end
end
