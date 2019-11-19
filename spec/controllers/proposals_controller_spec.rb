require 'rails_helper'

RSpec.describe ProposalsController, type: :controller do
  describe 'create' do
    let!(:author) { Author.create(name: 'Author Name') }
    let(:proposal_params) { {
                            title: 'Title', 
                            body: 'Proposal body goes here...',
                            author_id: author.id
                          } }
    let(:params) { { proposal: proposal_params } }

    describe 'creating the proposal' do
      it 'creates a proposal' do
        expect { post :create, params }.to change { Proposal.count }.from(0).to(1)
      end

      context 'proposal is valid' do
        it 'redirects to the show page of the new proposal' do
          post :create, params
          proposal = Proposal.last
          expect(response).to redirect_to(proposal_path(proposal))
        end
      end

      context 'proposal is invalid' do
        before do
          proposal_params.merge!({ body: nil })
        end
        it 'renders the index page' do
          post :create, params
          expect(response).to render_template(:index)
        end
      end
    end

    describe 'creating the draft' do
      it 'creates a draft' do
        expect { post :create, params }.to change { Draft.count }.from(0).to(1)
      end

      it "sets the draft's author" do
        post :create, params
        draft = Draft.last
        expect(draft.author).to eq(author)
      end

      context 'non-default state is passed in the params' do
        let(:new_draft_params) { proposal_params.merge({ drafts_attributes: [{ state: 'Old' }] }) }
        let(:params) { { proposal: new_draft_params } }

        it 'sets the state' do
          post :create, params
          draft = Draft.last
          expect(draft.state).to eq('Old')
        end
      end

      context 'no state is passed in the params' do
        it 'sets the state to New' do
          post :create, params
          draft = Draft.last
          expect(draft.state).to eq('New')
        end
      end

      it 'sets the version to 1' do
        post :create, params
        draft = Draft.last
        expect(draft.version).to eq(1)
      end

      it 'sets the draft as the current_draft for the proposal' do
        post :create, params
        proposal = Proposal.last
        draft = Draft.last
        expect(proposal.current_draft).to eq(draft)
      end
    end
  end
end
