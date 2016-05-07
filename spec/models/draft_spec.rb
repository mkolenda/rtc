require 'rails_helper'

describe Draft do
  describe "#set_version" do
    let(:author) { Author.create(name: "Test Author") }
    let(:title) { "Test Title" }
    let(:body) { "Test Body" }
    let(:reviewed) { true }

    let(:proposal_attributes) {{ title: title,
                                 body: body,
                                 reviewed: reviewed,
                                 author: author }}

    let(:proposal){ Proposal.create(proposal_attributes)}

    it "sets the version equal to the amount of drafts in the proposal" do
      first_draft = proposal.drafts.create(state: "First", author: author)
      second_draft = proposal.drafts.create(state: "Second", author: author)

      expect(first_draft.version).to eq(1)
      expect(second_draft.version).to eq(2)
    end
  end
end
