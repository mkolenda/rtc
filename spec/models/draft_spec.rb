require 'rails_helper'

describe Draft do
  describe "#set_version" do
    let(:proposal){ FactoryGirl.create(:proposal) }
    let(:author){ proposal.author }

    it "sets the version equal to the amount of drafts in the proposal" do
      first_draft = proposal.drafts.create(state: "First", author: author)
      second_draft = proposal.drafts.create(state: "Second", author: author)

      expect(first_draft.version).to eq(1)
      expect(second_draft.version).to eq(2)
    end
  end
end
