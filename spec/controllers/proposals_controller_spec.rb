require 'rails_helper'

RSpec.describe ProposalsController, type: :controller do
  describe "POST #create" do
    let(:proposal_title) { "Test Title" }
    let(:proposal_body) { "Test Body" }
    let(:proposal_reviewed) { true }
    let(:proposal_parameters) {{ title: proposal_title,
                                 body: proposal_body,
                                 reviewed: proposal_reviewed }}

    let(:draft_state) { "Test State" }
    let(:draft_parameters) {{ state: draft_state }}

    let(:parameters){{ proposal: proposal_parameters, draft: draft_parameters }}

    it "redirects to proposals on success" do
      post :create, parameters

      expect(response).to redirect_to "/proposals/#{Proposal.first.id}"
    end

    it "creates a new draft with default params if no draft is included in the proposal" do
      Proposal.any_instance.should_receive(:create_first_draft!).once
      parameters[:draft].delete(:state)
      post :create, parameters

      expect(response).to redirect_to "/proposals/#{Proposal.first.id}"
    end
  end
end
